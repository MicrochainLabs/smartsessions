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
    uint256 constant alphax  = 14619157880266710032912238831433988722979588245162232378701230219755168564225;
    uint256 constant alphay  = 20735726973475454007072537670391573313354094488013907666264879537436442359286;
    uint256 constant betax1  = 3273674083871418750826195414595940011878685133189427204785423793043717431501;
    uint256 constant betax2  = 2839831597706881680935501318131820700946352543629587090119245210796032572185;
    uint256 constant betay1  = 20712800859050105638923798159324018426379252517177171630127990931734306406973;
    uint256 constant betay2  = 19148282714019788895852166616604569097088536916997099701189185553537890790305;
    uint256 constant gammax1 = 11559732032986387107991004021392285783925812861821192530917403151452391805634;
    uint256 constant gammax2 = 10857046999023057135944570762232829481370756359578518086990519993285655852781;
    uint256 constant gammay1 = 4082367875863433681332203403145435568316851327593401208105741076214120093531;
    uint256 constant gammay2 = 8495653923123431417604973247489272438418190587263600148770280649306958101930;
    uint256 constant deltax1 = 2302066475455644420263071790973763186748036683562956503038779228388553789897;
    uint256 constant deltax2 = 3942318890824903374538229267196657678975800204033803317661306667329409109017;
    uint256 constant deltay1 = 12673570358057186537046633723619962731839188463625038905733310243878627616725;
    uint256 constant deltay2 = 16897263074998386547546342717143650256997674779786056861264263531587979248250;

    
    uint256 constant IC0x = 16367085169692360825104152913748224110418456926110871286827246312117352920390;
    uint256 constant IC0y = 13794153386474442825500403276882116270993605751750111267449870479065072754243;
    
    uint256 constant IC1x = 18801076622154419735654951175397991830439114507559579733046252598889384773315;
    uint256 constant IC1y = 5494135357477726083709405492702450669927898032909063260337226305649275139932;
    
    uint256 constant IC2x = 16150163867008891169401437127302941176379201603514855115241498118281239007519;
    uint256 constant IC2y = 18650395991371212847525673760012139137804568866402926249097413906866185170231;
    
    uint256 constant IC3x = 4378514328527442923614153103573288328602901495520102304702136347188549673943;
    uint256 constant IC3y = 7280711710315969475041619709651119160739482186455736663945915111989781742193;
    
    uint256 constant IC4x = 20573550598406318335069648083968612944909795177228776131225500265652261602890;
    uint256 constant IC4y = 21453962731714865768404132754441861300416289367941431763110137817928000342837;
    
    uint256 constant IC5x = 16055388025951185780142187478577960167979047518604163888500729527795607162096;
    uint256 constant IC5y = 18158670752237103945238014049844740062264862489494146553808302963166954779612;
    
    uint256 constant IC6x = 7936176939660618646003492465855120898056744397653116699132699455847920871490;
    uint256 constant IC6y = 17557390596263231628019741441333124873519802762062108049079996558487294892330;
    
    uint256 constant IC7x = 4539141743698901779846839258542701353738411930073992704643373014313630854251;
    uint256 constant IC7y = 3473208739087368084644805370259741669133235469679238904310813083400536929533;
    
    uint256 constant IC8x = 17341068763272990507110773582847538835228800051048801786840736996374912322732;
    uint256 constant IC8y = 5684768320216785547540317956194324838791259934110588926982312041988219987799;
    
    uint256 constant IC9x = 1040951019093945973271835058127599268893850207075995646022522014857991738950;
    uint256 constant IC9y = 9901272010001150712118041291398073046365956878040963410531131618991286374517;
    
    uint256 constant IC10x = 20261228794296085406975395731939169223908596257019044272935964552592045125750;
    uint256 constant IC10y = 13852079170837649953845882427161123946955251365681854625533954381404246619753;
    
    uint256 constant IC11x = 11990512769412765985724290463273901941516984000574814620488135409541658096432;
    uint256 constant IC11y = 3943532636334343357387739932142798890821937141560984562878513445682866692817;
    
    uint256 constant IC12x = 3914994586144423141591258766416073423452271169845219725473587131819053830930;
    uint256 constant IC12y = 4014997864954036351903852809501375974882472117876672448510178097215843363246;
    
    uint256 constant IC13x = 6579949677202715960462698180265557629790412478586550159687859833241130980211;
    uint256 constant IC13y = 17930764688041824875354568475746647946723443301295727083351501323792433752239;
    
 
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
