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
    uint256 constant r =
        21_888_242_871_839_275_222_246_405_745_257_275_088_548_364_400_416_034_343_698_204_186_575_808_495_617;
    // Base field size
    uint256 constant q =
        21_888_242_871_839_275_222_246_405_745_257_275_088_696_311_157_297_823_662_689_037_894_645_226_208_583;

    // Verification Key data
    uint256 constant alphax =
        19_348_088_517_027_304_381_919_814_720_645_357_066_516_474_735_717_669_600_059_287_543_533_214_811_890;
    uint256 constant alphay =
        651_607_389_804_327_227_884_052_865_996_960_272_154_984_248_648_343_573_826_089_823_334_738_687_542;
    uint256 constant betax1 =
        17_368_435_055_846_285_956_394_639_435_567_316_139_657_004_442_820_365_922_459_272_699_172_422_654_647;
    uint256 constant betax2 =
        16_074_166_066_354_573_629_593_655_053_540_298_753_799_609_527_039_464_518_195_757_795_635_860_238_142;
    uint256 constant betay1 =
        5_215_476_770_653_413_053_958_931_855_482_575_408_700_126_953_084_042_946_901_905_574_172_449_282_651;
    uint256 constant betay2 =
        695_968_381_100_465_158_290_347_787_959_344_541_154_843_287_593_548_951_091_199_134_756_091_506_144;
    uint256 constant gammax1 =
        11_559_732_032_986_387_107_991_004_021_392_285_783_925_812_861_821_192_530_917_403_151_452_391_805_634;
    uint256 constant gammax2 =
        10_857_046_999_023_057_135_944_570_762_232_829_481_370_756_359_578_518_086_990_519_993_285_655_852_781;
    uint256 constant gammay1 =
        4_082_367_875_863_433_681_332_203_403_145_435_568_316_851_327_593_401_208_105_741_076_214_120_093_531;
    uint256 constant gammay2 =
        8_495_653_923_123_431_417_604_973_247_489_272_438_418_190_587_263_600_148_770_280_649_306_958_101_930;
    uint256 constant deltax1 =
        17_473_843_620_744_696_234_296_318_754_769_665_205_744_155_114_755_813_872_687_870_930_790_095_215_121;
    uint256 constant deltax2 =
        9_450_803_690_741_660_318_425_829_558_950_657_420_856_636_267_297_416_370_375_009_667_749_629_575_398;
    uint256 constant deltay1 =
        14_452_473_399_317_732_747_850_764_240_565_251_491_864_714_851_371_390_208_861_512_461_861_822_286_766;
    uint256 constant deltay2 =
        17_512_893_047_119_736_295_597_976_430_886_233_899_187_355_669_626_992_552_935_011_368_715_404_888_541;

    uint256 constant IC0x =
        21_054_300_474_962_362_206_811_822_207_524_858_032_565_835_245_352_180_143_200_328_602_916_349_038_314;
    uint256 constant IC0y =
        2_037_065_313_642_316_517_531_567_535_038_008_283_224_941_149_178_692_628_051_701_845_817_101_993_208;

    uint256 constant IC1x =
        2_706_072_134_366_177_343_643_681_314_262_724_379_063_200_675_959_269_641_891_985_783_163_928_086_909;
    uint256 constant IC1y =
        20_210_727_153_972_877_766_705_988_332_027_207_248_699_131_317_155_915_090_820_018_175_914_324_011_711;

    uint256 constant IC2x =
        1_373_117_097_256_396_139_192_233_581_163_466_215_462_476_090_840_444_348_953_820_666_904_571_981_604;
    uint256 constant IC2y =
        18_032_807_559_269_733_460_219_527_733_384_259_980_131_432_684_751_966_921_591_038_439_222_923_622_470;

    uint256 constant IC3x =
        11_819_296_584_555_235_082_030_949_866_650_568_629_269_718_154_071_531_633_031_555_698_683_871_534_320;
    uint256 constant IC3y =
        10_231_769_326_171_436_711_806_560_816_671_990_358_772_486_109_881_728_245_044_545_046_652_091_397_721;

    uint256 constant IC4x =
        21_484_851_193_830_514_539_522_322_562_882_617_292_763_181_509_683_484_406_465_862_107_104_471_296_871;
    uint256 constant IC4y =
        5_140_609_456_123_477_864_378_021_965_995_574_275_504_926_089_939_598_296_122_374_867_954_460_075_949;

    uint256 constant IC5x =
        9_744_029_593_663_928_331_343_865_486_609_159_772_565_960_579_815_817_009_773_908_415_517_533_187_207;
    uint256 constant IC5y =
        18_518_109_552_718_501_780_287_434_104_859_870_243_721_511_591_876_160_527_406_753_343_116_470_609_457;

    uint256 constant IC6x =
        20_207_364_118_559_402_101_598_770_796_026_539_371_587_584_092_770_097_336_587_194_446_113_542_810_973;
    uint256 constant IC6y =
        12_094_236_373_275_467_005_940_909_858_503_046_445_131_045_108_058_504_629_541_011_009_493_097_566_934;

    uint256 constant IC7x =
        21_023_722_611_913_430_105_243_284_747_974_204_805_633_507_855_188_357_330_221_128_163_471_167_931_495;
    uint256 constant IC7y =
        10_964_751_078_989_869_967_664_786_617_201_780_850_120_836_531_096_247_277_198_070_640_935_825_694_928;

    uint256 constant IC8x =
        20_700_697_541_310_483_187_692_525_092_650_404_797_230_880_671_295_350_116_666_698_424_580_802_580_926;
    uint256 constant IC8y =
        462_124_197_354_278_653_722_147_343_273_580_733_242_482_568_270_654_740_336_688_556_488_370_412_920;

    uint256 constant IC9x =
        1_023_845_440_109_396_555_469_635_277_402_196_324_505_154_964_213_356_757_983_761_452_274_068_668_449;
    uint256 constant IC9y =
        17_620_882_332_532_764_101_901_228_026_344_454_929_767_089_005_863_367_769_519_930_156_538_309_868_548;

    uint256 constant IC10x =
        9_124_552_044_429_813_464_331_135_174_878_304_476_109_809_036_788_169_772_519_803_980_952_374_411_601;
    uint256 constant IC10y =
        19_790_367_438_760_607_700_732_205_656_408_603_430_176_550_494_090_821_755_191_318_625_932_387_932_943;

    uint256 constant IC11x =
        10_010_782_809_508_823_753_543_558_886_730_656_482_383_076_314_009_212_750_280_927_477_384_664_672_889;
    uint256 constant IC11y =
        18_312_350_973_311_817_745_878_381_195_786_026_193_734_812_712_211_277_068_082_196_783_331_170_618_850;

    uint256 constant IC12x =
        21_154_167_869_010_994_841_222_545_161_978_497_166_972_333_403_734_246_247_107_666_768_240_159_741_809;
    uint256 constant IC12y =
        11_121_999_818_763_005_448_999_773_902_126_209_359_811_511_398_984_932_901_387_867_097_992_081_013_788;

    uint256 constant IC13x =
        5_536_655_921_242_907_084_950_417_306_962_783_092_909_842_181_216_440_086_981_312_130_426_786_690_522;
    uint256 constant IC13y =
        8_361_924_340_174_434_090_015_369_933_594_447_160_682_973_285_386_376_252_181_984_592_689_891_948_894;

    // Memory data
    uint16 constant pVk = 0;
    uint16 constant pPairing = 128;

    uint16 constant pLastMem = 896;

    function verifyProof(
        uint256[2] calldata _pA,
        uint256[2][2] calldata _pB,
        uint256[2] calldata _pC,
        uint256[13] calldata _pubSignals
    )
        public
        view
        returns (bool)
    {
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
