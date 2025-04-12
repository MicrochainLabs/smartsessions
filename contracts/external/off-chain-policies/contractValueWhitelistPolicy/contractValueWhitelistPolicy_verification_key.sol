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
        14_619_157_880_266_710_032_912_238_831_433_988_722_979_588_245_162_232_378_701_230_219_755_168_564_225;
    uint256 constant alphay =
        20_735_726_973_475_454_007_072_537_670_391_573_313_354_094_488_013_907_666_264_879_537_436_442_359_286;
    uint256 constant betax1 =
        3_273_674_083_871_418_750_826_195_414_595_940_011_878_685_133_189_427_204_785_423_793_043_717_431_501;
    uint256 constant betax2 =
        2_839_831_597_706_881_680_935_501_318_131_820_700_946_352_543_629_587_090_119_245_210_796_032_572_185;
    uint256 constant betay1 =
        20_712_800_859_050_105_638_923_798_159_324_018_426_379_252_517_177_171_630_127_990_931_734_306_406_973;
    uint256 constant betay2 =
        19_148_282_714_019_788_895_852_166_616_604_569_097_088_536_916_997_099_701_189_185_553_537_890_790_305;
    uint256 constant gammax1 =
        11_559_732_032_986_387_107_991_004_021_392_285_783_925_812_861_821_192_530_917_403_151_452_391_805_634;
    uint256 constant gammax2 =
        10_857_046_999_023_057_135_944_570_762_232_829_481_370_756_359_578_518_086_990_519_993_285_655_852_781;
    uint256 constant gammay1 =
        4_082_367_875_863_433_681_332_203_403_145_435_568_316_851_327_593_401_208_105_741_076_214_120_093_531;
    uint256 constant gammay2 =
        8_495_653_923_123_431_417_604_973_247_489_272_438_418_190_587_263_600_148_770_280_649_306_958_101_930;
    uint256 constant deltax1 =
        2_302_066_475_455_644_420_263_071_790_973_763_186_748_036_683_562_956_503_038_779_228_388_553_789_897;
    uint256 constant deltax2 =
        3_942_318_890_824_903_374_538_229_267_196_657_678_975_800_204_033_803_317_661_306_667_329_409_109_017;
    uint256 constant deltay1 =
        12_673_570_358_057_186_537_046_633_723_619_962_731_839_188_463_625_038_905_733_310_243_878_627_616_725;
    uint256 constant deltay2 =
        16_897_263_074_998_386_547_546_342_717_143_650_256_997_674_779_786_056_861_264_263_531_587_979_248_250;

    uint256 constant IC0x =
        16_367_085_169_692_360_825_104_152_913_748_224_110_418_456_926_110_871_286_827_246_312_117_352_920_390;
    uint256 constant IC0y =
        13_794_153_386_474_442_825_500_403_276_882_116_270_993_605_751_750_111_267_449_870_479_065_072_754_243;

    uint256 constant IC1x =
        18_801_076_622_154_419_735_654_951_175_397_991_830_439_114_507_559_579_733_046_252_598_889_384_773_315;
    uint256 constant IC1y =
        5_494_135_357_477_726_083_709_405_492_702_450_669_927_898_032_909_063_260_337_226_305_649_275_139_932;

    uint256 constant IC2x =
        16_150_163_867_008_891_169_401_437_127_302_941_176_379_201_603_514_855_115_241_498_118_281_239_007_519;
    uint256 constant IC2y =
        18_650_395_991_371_212_847_525_673_760_012_139_137_804_568_866_402_926_249_097_413_906_866_185_170_231;

    uint256 constant IC3x =
        4_378_514_328_527_442_923_614_153_103_573_288_328_602_901_495_520_102_304_702_136_347_188_549_673_943;
    uint256 constant IC3y =
        7_280_711_710_315_969_475_041_619_709_651_119_160_739_482_186_455_736_663_945_915_111_989_781_742_193;

    uint256 constant IC4x =
        20_573_550_598_406_318_335_069_648_083_968_612_944_909_795_177_228_776_131_225_500_265_652_261_602_890;
    uint256 constant IC4y =
        21_453_962_731_714_865_768_404_132_754_441_861_300_416_289_367_941_431_763_110_137_817_928_000_342_837;

    uint256 constant IC5x =
        16_055_388_025_951_185_780_142_187_478_577_960_167_979_047_518_604_163_888_500_729_527_795_607_162_096;
    uint256 constant IC5y =
        18_158_670_752_237_103_945_238_014_049_844_740_062_264_862_489_494_146_553_808_302_963_166_954_779_612;

    uint256 constant IC6x =
        7_936_176_939_660_618_646_003_492_465_855_120_898_056_744_397_653_116_699_132_699_455_847_920_871_490;
    uint256 constant IC6y =
        17_557_390_596_263_231_628_019_741_441_333_124_873_519_802_762_062_108_049_079_996_558_487_294_892_330;

    uint256 constant IC7x =
        4_539_141_743_698_901_779_846_839_258_542_701_353_738_411_930_073_992_704_643_373_014_313_630_854_251;
    uint256 constant IC7y =
        3_473_208_739_087_368_084_644_805_370_259_741_669_133_235_469_679_238_904_310_813_083_400_536_929_533;

    uint256 constant IC8x =
        17_341_068_763_272_990_507_110_773_582_847_538_835_228_800_051_048_801_786_840_736_996_374_912_322_732;
    uint256 constant IC8y =
        5_684_768_320_216_785_547_540_317_956_194_324_838_791_259_934_110_588_926_982_312_041_988_219_987_799;

    uint256 constant IC9x =
        1_040_951_019_093_945_973_271_835_058_127_599_268_893_850_207_075_995_646_022_522_014_857_991_738_950;
    uint256 constant IC9y =
        9_901_272_010_001_150_712_118_041_291_398_073_046_365_956_878_040_963_410_531_131_618_991_286_374_517;

    uint256 constant IC10x =
        20_261_228_794_296_085_406_975_395_731_939_169_223_908_596_257_019_044_272_935_964_552_592_045_125_750;
    uint256 constant IC10y =
        13_852_079_170_837_649_953_845_882_427_161_123_946_955_251_365_681_854_625_533_954_381_404_246_619_753;

    uint256 constant IC11x =
        11_990_512_769_412_765_985_724_290_463_273_901_941_516_984_000_574_814_620_488_135_409_541_658_096_432;
    uint256 constant IC11y =
        3_943_532_636_334_343_357_387_739_932_142_798_890_821_937_141_560_984_562_878_513_445_682_866_692_817;

    uint256 constant IC12x =
        3_914_994_586_144_423_141_591_258_766_416_073_423_452_271_169_845_219_725_473_587_131_819_053_830_930;
    uint256 constant IC12y =
        4_014_997_864_954_036_351_903_852_809_501_375_974_882_472_117_876_672_448_510_178_097_215_843_363_246;

    uint256 constant IC13x =
        6_579_949_677_202_715_960_462_698_180_265_557_629_790_412_478_586_550_159_687_859_833_241_130_980_211;
    uint256 constant IC13y =
        17_930_764_688_041_824_875_354_568_475_746_647_946_723_443_301_295_727_083_351_501_323_792_433_752_239;

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
