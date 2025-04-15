// SPDX-License-Identifier: MIT

pragma solidity ^0.8.23;

import "../../../DataTypes.sol";
import { IPolicy, IUserOpZkPolicy, VALIDATION_SUCCESS, VALIDATION_FAILED } from "../../../interfaces/IPolicy.sol";
import { PackedUserOperation } from "modulekit/external/ERC4337.sol";
import { IERC165 } from "forge-std/interfaces/IERC165.sol";
import { IERC7579Account } from "erc7579/interfaces/IERC7579Account.sol";
import { IAccountExecute } from "modulekit/external/ERC4337.sol";
import { ExecType, CallType, CALLTYPE_BATCH, CALLTYPE_SINGLE, EXECTYPE_DEFAULT } from "erc7579/lib/ModeLib.sol";
import { IERC20 } from "forge-std/interfaces/IERC20.sol";
import { Execution, ExecutionLib as ExecutionLib } from "../../../lib/ExecutionLib.sol";
import { ISmartSession } from "../../../ISmartSession.sol";
import { ConfigLib } from "../../../lib/ConfigLib.sol";

interface IUserOpZkPolicyVerifier {
    function verifyProof(
        uint256[2] memory a,
        uint256[2][2] memory b,
        uint256[2] memory c,
        uint256[13] memory input
    )
        external
        view
        returns (bool);
}

contract ContractValueWhitelistPolicy is IUserOpZkPolicy {
    using ExecutionLib for *;

    error PolicyNotInitialized(ConfigId id, address multiplexer, address account);
    error UnsupportedCallType(CallType callType);

    struct Groth16Proof {
        uint256[2] a;
        uint256[2][2] b;
        uint256[2] c;
        uint256 opProof;
    }

    mapping(ConfigId id => mapping(address msgSender => mapping(address userOpSender => uint256))) internal
        stateTreeRoots;

    uint256 immutable SNARK_SCALAR_FIELD =
        21_888_242_871_839_275_222_246_405_745_257_275_088_548_364_400_416_034_343_698_204_186_575_808_495_617;

    IUserOpZkPolicyVerifier private immutable userOpPolicyVerifier;

    constructor(IUserOpZkPolicyVerifier _userOpPolicyVerifier) {
        userOpPolicyVerifier = _userOpPolicyVerifier;
    }

    /**
     * Initializes the policy to be used by given account through multiplexer (msg.sender) such as Smart Sessions.
     * Overwrites state.
     * @notice ATTENTION: This method is called during permission installation as part of the enabling policies flow.
     * A secure policy would minimize external calls from this method (ideally, to 0) to prevent passing control flow to
     * external contracts.
     */
    function initializeWithMultiplexer(address account, ConfigId configId, bytes calldata initData) external {
        stateTreeRoots[configId][msg.sender][account] = uint256(bytes32(initData[0:32]));
    }

    function getStateTreeRoot(
        ConfigId configId,
        address multiplexer,
        address smartAccount
    )
        external
        view
        returns (uint256)
    {
        return stateTreeRoots[configId][multiplexer][smartAccount];
    }

    /**
     * @notice Checks if the limit is not exceeded.
     * @param id The config ID.
     * @param op The user operation.
     * @return The validation result.
     */
    //function checkUserOpPolicy(ConfigId id, PackedUserOperation calldata op, bytes32 userOpHash, bytes proof) external
    // returns (uint256) {
    function checkUserOpZkPolicy(ConfigId id, PackedUserOperation calldata op, bytes32 userOpHash, bytes memory proof) external returns (uint256) {
        return _verifyProof(id, msg.sender, op.sender, op, userOpHash, proof);
    }

    /**
     * @notice Internal method to check if the limit is not exceeded.
     * @param id The config ID.
     * @param multiplexer The multiplexer.
     * @param smartAccount The smart account.
     * @return The validation result.
     */
    function _verifyProof(
        ConfigId id,
        address multiplexer,
        address smartAccount,
        PackedUserOperation calldata op,
        bytes32 userOpHash,
        bytes memory proof
    )
        internal
        returns (uint256)
    {
        uint256 stateTreeRoot = stateTreeRoots[id][multiplexer][smartAccount];
        require(stateTreeRoot > 0, PolicyNotInitialized(id, multiplexer, smartAccount));
        uint256[13] memory inputs = _decodeUserOpCallData(op.callData);
        Groth16Proof memory groth16Proof = _decodeProof(proof);
        inputs[0] = stateTreeRoot;
        inputs[1] = groth16Proof.opProof;
        inputs[2] = uint256(uint160(address(smartAccount)));
        inputs[3] = uint256(ConfigId.unwrap(id));
        inputs[4] = uint256(userOpHash) % SNARK_SCALAR_FIELD;

        if(!userOpPolicyVerifier.verifyProof(groth16Proof.a, groth16Proof.b, groth16Proof.c, inputs)){
            return VALIDATION_FAILED;
        }
        return VALIDATION_SUCCESS;
    }

    function _decodeProof(bytes memory proof) public pure returns(Groth16Proof memory decodedProof ) {
        {
            (
                uint256 proof0,
                uint256 proof1,
                uint256 proof2,
                uint256 proof3,
                uint256 proof4,
                uint256 proof5,
                uint256 proof6,
                uint256 proof7,
                uint256 opProof
            ) = abi.decode(proof, (uint256, uint256, uint256, uint256, uint256, uint256, uint256, uint256, uint256));
            decodedProof = Groth16Proof([proof0, proof1],[[proof2, proof3], [proof4, proof5]], [proof6, proof7], opProof);
        }
    }

    function _decodeUserOpCallData(bytes calldata userOpCallData) internal pure returns (uint256[13] memory) {
        //uint256[13] memory callsInputs = new uint256[](13);
        uint256[13] memory callsInputs;
        bytes4 selector = bytes4(userOpCallData[0:4]);
        if (selector == IERC7579Account.execute.selector) {
            // Decode ERC7579 execution mode
            (CallType callType,) = userOpCallData.get7579ExecutionTypes();

            // DEFAULT EXEC & SINGLE CALL
            if (callType == CALLTYPE_SINGLE) {
                (address target, uint256 value, bytes calldata callData) =
                    userOpCallData.decodeUserOpCallData().decodeSingle();
                address to = _tokenTransferOrApprove(callData);
                callsInputs[5] = uint256(uint160(target));
                callsInputs[7] = value;
                callsInputs[9] = uint256(uint32(bytes4(callData[:4])));
                callsInputs[11] = uint256(uint160(to));
            }
            // DEFAULT EXEC & BATCH CALL
            else if (callType == CALLTYPE_BATCH) {
                // Decode the batch of 7579 executions from the user operation's call data
                Execution[] calldata executions = userOpCallData.decodeUserOpCallData().decodeBatch();
                uint256 length = executions.length;
                // Revert if there are no executions in the batch
                if (length == 0) revert ISmartSession.NoExecutionsInBatch();

                //only support: tx < 3 just for testing purpose
                require(length < 3, "nb tx must be less than 3");

                uint256 valueIndex = 5 + length;
                uint256 functionSelectorIndex = 5 + length * 2;
                uint256 toIndex = 5 + length * 3;
                // Iterate through each execution in the batch
                for (uint256 i; i < length; i++) {
                    Execution calldata execution = executions[i];
                    callsInputs[5 + i] = uint256(uint160(execution.target));
                    callsInputs[valueIndex + i] = execution.value;
                    callsInputs[functionSelectorIndex + i] = uint256(uint32(bytes4(execution.callData[:4])));
                    address to = _tokenTransferOrApprove(execution.callData);
                    callsInputs[toIndex + i] = uint256(uint160(to));
                }
            } else {
                revert UnsupportedCallType(callType);
            }
        }
        return callsInputs;
    }

    function _tokenTransferOrApprove(bytes calldata callData) internal pure returns (address) {
        bytes4 functionSelector = bytes4(callData[0:4]);

        if (functionSelector == IERC20.approve.selector) {
            (address to,) = abi.decode(callData[4:], (address, uint256));
            return to;
        } else if (functionSelector == bytes4(keccak256("increaseAllowance(address,uint256)"))) {
            (address to,) = abi.decode(callData[4:], (address, uint256));
            return to;
        } else if (functionSelector == IERC20.transfer.selector) {
            (address to,) = abi.decode(callData[4:], (address, uint256));
            return to;
        } else if (functionSelector == IERC20.transferFrom.selector) {
            (, address to,) = abi.decode(callData[4:], (address, address, uint256));
            return to;
        }
        return address(0);
    }

    function supportsInterface(bytes4 interfaceID) external pure override returns (bool) {
        return (
            interfaceID == type(IERC165).interfaceId || interfaceID == type(IPolicy).interfaceId
                || interfaceID == type(IUserOpZkPolicy).interfaceId
        );
    }
}