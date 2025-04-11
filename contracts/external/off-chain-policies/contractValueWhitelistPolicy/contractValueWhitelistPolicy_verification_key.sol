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
        5_719_824_025_805_702_544_481_079_398_360_016_977_448_033_890_109_566_730_163_489_282_749_749_047_622;
    uint256 constant alphay =
        8_650_753_596_294_016_459_418_637_178_235_300_088_697_925_729_017_101_197_852_489_333_897_857_532_853;
    uint256 constant betax1 =
        2_376_251_286_998_042_977_476_096_174_561_436_334_997_996_586_112_568_353_572_285_781_364_493_920_682;
    uint256 constant betax2 =
        17_355_719_295_966_920_714_040_821_357_930_091_713_698_539_844_561_075_942_218_918_673_445_793_888_230;
    uint256 constant betay1 =
        1_197_733_187_756_048_177_288_536_702_552_826_765_999_829_135_402_641_189_402_884_994_826_210_264_675;
    uint256 constant betay2 =
        986_365_345_068_939_805_529_545_982_989_781_149_688_558_160_681_917_974_602_649_869_840_526_010_802;
    uint256 constant gammax1 =
        11_559_732_032_986_387_107_991_004_021_392_285_783_925_812_861_821_192_530_917_403_151_452_391_805_634;
    uint256 constant gammax2 =
        10_857_046_999_023_057_135_944_570_762_232_829_481_370_756_359_578_518_086_990_519_993_285_655_852_781;
    uint256 constant gammay1 =
        4_082_367_875_863_433_681_332_203_403_145_435_568_316_851_327_593_401_208_105_741_076_214_120_093_531;
    uint256 constant gammay2 =
        8_495_653_923_123_431_417_604_973_247_489_272_438_418_190_587_263_600_148_770_280_649_306_958_101_930;
    uint256 constant deltax1 =
        19_886_888_489_950_702_492_411_511_113_511_823_162_966_582_676_678_683_132_530_659_085_160_267_012_537;
    uint256 constant deltax2 =
        14_914_427_591_516_222_078_309_063_769_967_096_100_621_372_768_773_011_203_843_081_972_794_814_140_997;
    uint256 constant deltay1 =
        16_002_319_689_553_399_404_969_631_659_453_266_186_538_720_307_706_252_563_415_543_161_013_082_469_086;
    uint256 constant deltay2 =
        14_312_438_092_520_314_483_069_099_337_560_811_243_362_045_850_720_389_173_935_202_395_579_313_366_629;

    uint256 constant IC0x =
        19_074_865_649_456_431_007_831_424_667_233_690_998_951_427_808_075_884_867_678_629_170_665_811_502_714;
    uint256 constant IC0y =
        17_679_737_015_206_346_484_789_056_002_519_619_906_830_442_182_234_215_748_571_770_495_288_159_245_359;

    uint256 constant IC1x =
        19_308_394_801_931_682_104_245_152_710_445_100_379_390_906_149_532_362_193_866_320_475_221_640_121_971;
    uint256 constant IC1y =
        21_519_045_680_157_812_106_659_069_688_624_542_685_347_949_885_632_019_191_487_752_023_695_786_123_551;

    uint256 constant IC2x =
        329_066_439_949_494_509_461_278_240_686_131_513_902_502_523_606_762_358_284_495_535_046_912_751_987;
    uint256 constant IC2y =
        21_571_663_794_673_121_265_327_129_956_071_755_160_708_889_129_140_231_942_301_520_285_981_752_953_728;

    uint256 constant IC3x =
        17_436_590_379_048_902_058_255_761_300_008_262_120_426_876_625_014_539_793_925_676_620_781_607_334_844;
    uint256 constant IC3y =
        16_226_062_925_759_547_511_173_684_298_980_705_253_444_208_392_764_210_237_482_330_393_523_351_670_993;

    uint256 constant IC4x =
        13_930_702_289_198_436_101_768_247_920_970_321_022_337_848_239_536_355_828_191_980_228_816_416_151_943;
    uint256 constant IC4y =
        20_623_232_281_458_270_539_317_675_428_160_603_605_876_967_718_602_358_173_314_581_578_445_626_340_070;

    uint256 constant IC5x =
        18_919_352_548_869_121_666_538_144_761_163_918_888_951_711_848_482_115_355_056_464_958_792_874_054_747;
    uint256 constant IC5y =
        5_625_379_114_828_025_685_969_156_424_713_183_164_975_926_221_989_983_971_391_245_218_563_874_786_889;

    uint256 constant IC6x =
        606_734_773_912_198_071_912_807_224_749_294_055_220_818_335_451_596_680_658_912_093_383_429_959_922;
    uint256 constant IC6y =
        14_297_941_049_240_990_784_161_391_942_815_865_111_419_955_667_702_038_039_991_604_578_974_663_616_495;

    uint256 constant IC7x =
        12_385_703_133_140_923_141_543_475_039_879_811_391_303_841_574_923_991_959_690_982_897_459_294_630_182;
    uint256 constant IC7y =
        12_508_957_157_456_289_046_140_268_100_755_966_102_118_303_950_414_793_735_817_560_494_563_016_660_543;

    uint256 constant IC8x =
        5_581_971_696_439_622_835_444_712_357_330_619_319_378_947_577_407_374_959_241_674_738_902_116_126_478;
    uint256 constant IC8y =
        11_396_834_039_433_353_952_120_337_464_952_157_030_583_592_508_895_077_705_884_080_046_748_454_173_428;

    uint256 constant IC9x =
        15_059_934_812_702_716_488_741_462_471_962_987_184_775_358_617_013_048_566_125_411_843_521_601_817_038;
    uint256 constant IC9y =
        11_167_641_095_093_892_180_265_778_235_251_910_795_655_694_381_936_086_052_098_345_050_601_062_333_616;

    uint256 constant IC10x =
        7_858_865_373_493_011_425_562_687_883_362_304_767_878_389_931_408_638_836_602_621_113_848_343_744_027;
    uint256 constant IC10y =
        17_122_061_420_664_966_701_878_736_393_199_343_399_653_037_595_444_136_951_803_551_324_969_781_241_259;

    uint256 constant IC11x =
        11_302_222_543_151_877_677_852_019_388_400_819_246_456_674_586_768_305_703_014_908_541_733_372_244_499;
    uint256 constant IC11y =
        14_617_256_063_937_468_216_110_554_681_941_776_227_740_795_143_375_477_509_759_208_623_075_541_136_781;

    uint256 constant IC12x =
        7_947_659_701_620_056_312_745_304_912_902_038_333_104_213_793_896_482_679_242_364_054_677_284_388_979;
    uint256 constant IC12y =
        10_315_946_578_944_309_211_857_819_225_863_220_025_076_807_645_298_312_880_714_248_417_195_918_523_955;

    uint256 constant IC13x =
        10_774_212_146_367_758_829_534_891_461_295_014_168_093_350_111_068_122_257_181_439_657_857_310_920_435;
    uint256 constant IC13y =
        9_811_127_223_497_646_516_777_074_082_871_150_074_658_738_562_137_804_654_681_103_585_780_134_331_888;

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
