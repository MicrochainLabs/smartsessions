// SPDX-License-Identifier: AGPL-3.0-only
pragma solidity ^0.8.25;

import "forge-std/Script.sol";
import "contracts/SmartSession.sol";
import "contracts/external/policies/SudoPolicy.sol";
import "contracts/external/off-chain-policies/contractAndValueWhitelistPolicy/ContractValueWhitelistPolicy.sol";
import "contracts/external/off-chain-policies/contractAndValueWhitelistPolicy/verification_key.sol";


contract DeploySmartSessionWithOffChainPermission is Script {
    uint256 privKey;

    function run() public {
        privKey = vm.envUint("PRIVATE_KEY");
        console2.log("Deployer Addr: ", vm.addr(privKey));

        vm.startBroadcast(privKey);

        _deploySmartSession();
        _deploySubModules();

        vm.stopBroadcast();
    }

    function _deploySmartSession() public returns (address) {
        SmartSession smartSession = new SmartSession();
        console2.log("SmartSession Addr: ", address(smartSession));

        return address(smartSession);
    }

    function _deploySubModules() public returns (address) {
        SudoPolicy sudoPolicy = new SudoPolicy();
        console2.log("SudoPolicy Address ", address(sudoPolicy));

        Groth16Verifier groth16Verifier = new Groth16Verifier();
        console2.log("Groth16Verifier Address ", address(groth16Verifier));

        ContractValueWhitelistPolicy contractValueWhitelistPolicy = new ContractValueWhitelistPolicy(IUserOpZkPolicyVerifier(address(groth16Verifier)));
        console2.log("ContractValueWhitelistPolicy Address ", address(contractValueWhitelistPolicy));
    }
}
