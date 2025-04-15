// SPDX-License-Identifier: GPL-3.0
/*
    Copyright 2021 0KIMS association.

    This file is generated with [snarkJS](https://github.com/iden3/snarkjs).

    snarkJS is a free software: you can redistribute it and/or modify it
    under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    snarkJS is distributed in the hope that it will be useful, but WITHOUT
    ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
    or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public
    License for more details.

    You should have received a copy of the GNU General Public License
    along with snarkJS. If not, see <https://www.gnu.org/licenses/>.
*/

pragma solidity >=0.7.0 <0.9.0;

contract Groth16Verifier {
    // Scalar field size
    uint256 constant r    = 21888242871839275222246405745257275088548364400416034343698204186575808495617;
    // Base field size
    uint256 constant q   = 21888242871839275222246405745257275088696311157297823662689037894645226208583;

    // Verification Key data
    uint256 constant alphax  = 19348088517027304381919814720645357066516474735717669600059287543533214811890;
    uint256 constant alphay  = 651607389804327227884052865996960272154984248648343573826089823334738687542;
    uint256 constant betax1  = 17368435055846285956394639435567316139657004442820365922459272699172422654647;
    uint256 constant betax2  = 16074166066354573629593655053540298753799609527039464518195757795635860238142;
    uint256 constant betay1  = 5215476770653413053958931855482575408700126953084042946901905574172449282651;
    uint256 constant betay2  = 695968381100465158290347787959344541154843287593548951091199134756091506144;
    uint256 constant gammax1 = 11559732032986387107991004021392285783925812861821192530917403151452391805634;
    uint256 constant gammax2 = 10857046999023057135944570762232829481370756359578518086990519993285655852781;
    uint256 constant gammay1 = 4082367875863433681332203403145435568316851327593401208105741076214120093531;
    uint256 constant gammay2 = 8495653923123431417604973247489272438418190587263600148770280649306958101930;
    uint256 constant deltax1 = 17473843620744696234296318754769665205744155114755813872687870930790095215121;
    uint256 constant deltax2 = 9450803690741660318425829558950657420856636267297416370375009667749629575398;
    uint256 constant deltay1 = 14452473399317732747850764240565251491864714851371390208861512461861822286766;
    uint256 constant deltay2 = 17512893047119736295597976430886233899187355669626992552935011368715404888541;

    
    uint256 constant IC0x = 21054300474962362206811822207524858032565835245352180143200328602916349038314;
    uint256 constant IC0y = 2037065313642316517531567535038008283224941149178692628051701845817101993208;
    
    uint256 constant IC1x = 2706072134366177343643681314262724379063200675959269641891985783163928086909;
    uint256 constant IC1y = 20210727153972877766705988332027207248699131317155915090820018175914324011711;
    
    uint256 constant IC2x = 1373117097256396139192233581163466215462476090840444348953820666904571981604;
    uint256 constant IC2y = 18032807559269733460219527733384259980131432684751966921591038439222923622470;
    
    uint256 constant IC3x = 11819296584555235082030949866650568629269718154071531633031555698683871534320;
    uint256 constant IC3y = 10231769326171436711806560816671990358772486109881728245044545046652091397721;
    
    uint256 constant IC4x = 21484851193830514539522322562882617292763181509683484406465862107104471296871;
    uint256 constant IC4y = 5140609456123477864378021965995574275504926089939598296122374867954460075949;
    
    uint256 constant IC5x = 9744029593663928331343865486609159772565960579815817009773908415517533187207;
    uint256 constant IC5y = 18518109552718501780287434104859870243721511591876160527406753343116470609457;
    
    uint256 constant IC6x = 20207364118559402101598770796026539371587584092770097336587194446113542810973;
    uint256 constant IC6y = 12094236373275467005940909858503046445131045108058504629541011009493097566934;
    
    uint256 constant IC7x = 21023722611913430105243284747974204805633507855188357330221128163471167931495;
    uint256 constant IC7y = 10964751078989869967664786617201780850120836531096247277198070640935825694928;
    
    uint256 constant IC8x = 20700697541310483187692525092650404797230880671295350116666698424580802580926;
    uint256 constant IC8y = 462124197354278653722147343273580733242482568270654740336688556488370412920;
    
    uint256 constant IC9x = 1023845440109396555469635277402196324505154964213356757983761452274068668449;
    uint256 constant IC9y = 17620882332532764101901228026344454929767089005863367769519930156538309868548;
    
    uint256 constant IC10x = 9124552044429813464331135174878304476109809036788169772519803980952374411601;
    uint256 constant IC10y = 19790367438760607700732205656408603430176550494090821755191318625932387932943;
    
    uint256 constant IC11x = 10010782809508823753543558886730656482383076314009212750280927477384664672889;
    uint256 constant IC11y = 18312350973311817745878381195786026193734812712211277068082196783331170618850;
    
    uint256 constant IC12x = 21154167869010994841222545161978497166972333403734246247107666768240159741809;
    uint256 constant IC12y = 11121999818763005448999773902126209359811511398984932901387867097992081013788;
    
    uint256 constant IC13x = 5536655921242907084950417306962783092909842181216440086981312130426786690522;
    uint256 constant IC13y = 8361924340174434090015369933594447160682973285386376252181984592689891948894;
    
 
    // Memory data
    uint16 constant pVk = 0;
    uint16 constant pPairing = 128;

    uint16 constant pLastMem = 896;

    function verifyProof(uint[2] calldata _pA, uint[2][2] calldata _pB, uint[2] calldata _pC, uint[13] calldata _pubSignals) public view returns (bool) {
        assembly {
            function checkField(v) {
                if iszero(lt(v, r)) {
                    mstore(0, 0)
                    return(0, 0x20)
                }
            }
            
            // G1 function to multiply a G1 value(x,y) to value in an address
            function g1_mulAccC(pR, x, y, s) {
                let success
                let mIn := mload(0x40)
                mstore(mIn, x)
                mstore(add(mIn, 32), y)
                mstore(add(mIn, 64), s)

                success := staticcall(sub(gas(), 2000), 7, mIn, 96, mIn, 64)

                if iszero(success) {
                    mstore(0, 0)
                    return(0, 0x20)
                }

                mstore(add(mIn, 64), mload(pR))
                mstore(add(mIn, 96), mload(add(pR, 32)))

                success := staticcall(sub(gas(), 2000), 6, mIn, 128, pR, 64)

                if iszero(success) {
                    mstore(0, 0)
                    return(0, 0x20)
                }
            }

            function checkPairing(pA, pB, pC, pubSignals, pMem) -> isOk {
                let _pPairing := add(pMem, pPairing)
                let _pVk := add(pMem, pVk)

                mstore(_pVk, IC0x)
                mstore(add(_pVk, 32), IC0y)

                // Compute the linear combination vk_x
                
                g1_mulAccC(_pVk, IC1x, IC1y, calldataload(add(pubSignals, 0)))
                
                g1_mulAccC(_pVk, IC2x, IC2y, calldataload(add(pubSignals, 32)))
                
                g1_mulAccC(_pVk, IC3x, IC3y, calldataload(add(pubSignals, 64)))
                
                g1_mulAccC(_pVk, IC4x, IC4y, calldataload(add(pubSignals, 96)))
                
                g1_mulAccC(_pVk, IC5x, IC5y, calldataload(add(pubSignals, 128)))
                
                g1_mulAccC(_pVk, IC6x, IC6y, calldataload(add(pubSignals, 160)))
                
                g1_mulAccC(_pVk, IC7x, IC7y, calldataload(add(pubSignals, 192)))
                
                g1_mulAccC(_pVk, IC8x, IC8y, calldataload(add(pubSignals, 224)))
                
                g1_mulAccC(_pVk, IC9x, IC9y, calldataload(add(pubSignals, 256)))
                
                g1_mulAccC(_pVk, IC10x, IC10y, calldataload(add(pubSignals, 288)))
                
                g1_mulAccC(_pVk, IC11x, IC11y, calldataload(add(pubSignals, 320)))
                
                g1_mulAccC(_pVk, IC12x, IC12y, calldataload(add(pubSignals, 352)))
                
                g1_mulAccC(_pVk, IC13x, IC13y, calldataload(add(pubSignals, 384)))
                

                // -A
                mstore(_pPairing, calldataload(pA))
                mstore(add(_pPairing, 32), mod(sub(q, calldataload(add(pA, 32))), q))

                // B
                mstore(add(_pPairing, 64), calldataload(pB))
                mstore(add(_pPairing, 96), calldataload(add(pB, 32)))
                mstore(add(_pPairing, 128), calldataload(add(pB, 64)))
                mstore(add(_pPairing, 160), calldataload(add(pB, 96)))

                // alpha1
                mstore(add(_pPairing, 192), alphax)
                mstore(add(_pPairing, 224), alphay)

                // beta2
                mstore(add(_pPairing, 256), betax1)
                mstore(add(_pPairing, 288), betax2)
                mstore(add(_pPairing, 320), betay1)
                mstore(add(_pPairing, 352), betay2)

                // vk_x
                mstore(add(_pPairing, 384), mload(add(pMem, pVk)))
                mstore(add(_pPairing, 416), mload(add(pMem, add(pVk, 32))))


                // gamma2
                mstore(add(_pPairing, 448), gammax1)
                mstore(add(_pPairing, 480), gammax2)
                mstore(add(_pPairing, 512), gammay1)
                mstore(add(_pPairing, 544), gammay2)

                // C
                mstore(add(_pPairing, 576), calldataload(pC))
                mstore(add(_pPairing, 608), calldataload(add(pC, 32)))

                // delta2
                mstore(add(_pPairing, 640), deltax1)
                mstore(add(_pPairing, 672), deltax2)
                mstore(add(_pPairing, 704), deltay1)
                mstore(add(_pPairing, 736), deltay2)


                let success := staticcall(sub(gas(), 2000), 8, _pPairing, 768, _pPairing, 0x20)

                isOk := and(success, mload(_pPairing))
            }

            let pMem := mload(0x40)
            mstore(0x40, add(pMem, pLastMem))

            // Validate that all evaluations ∈ F
            
            checkField(calldataload(add(_pubSignals, 0)))
            
            checkField(calldataload(add(_pubSignals, 32)))
            
            checkField(calldataload(add(_pubSignals, 64)))
            
            checkField(calldataload(add(_pubSignals, 96)))
            
            checkField(calldataload(add(_pubSignals, 128)))
            
            checkField(calldataload(add(_pubSignals, 160)))
            
            checkField(calldataload(add(_pubSignals, 192)))
            
            checkField(calldataload(add(_pubSignals, 224)))
            
            checkField(calldataload(add(_pubSignals, 256)))
            
            checkField(calldataload(add(_pubSignals, 288)))
            
            checkField(calldataload(add(_pubSignals, 320)))
            
            checkField(calldataload(add(_pubSignals, 352)))
            
            checkField(calldataload(add(_pubSignals, 384)))
            
            checkField(calldataload(add(_pubSignals, 416)))
            

            // Validate all evaluations
            let isValid := checkPairing(_pA, _pB, _pC, _pubSignals, pMem)

            mstore(0, isValid)
             return(0, 0x20)
         }
     }
 }
