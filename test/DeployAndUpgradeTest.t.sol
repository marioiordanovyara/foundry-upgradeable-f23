// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;
import {Test} from "forge-std/Test.sol";
import {BoxV1} from "../src/BoxV1.sol";
import {BoxV2} from "../src/BoxV2.sol";
import {DeployBox} from "../script/DeployBox.s.sol";
import {UpgradeBox} from "../script/UpgradeBox.s.sol";

contract DeployAndUpgradeTest is Test {
    address proxy;
    DeployBox deployBox;
    UpgradeBox upgradeBox;

    function setUp() public {
        deployBox = new DeployBox();
        upgradeBox = new UpgradeBox();
        proxy = deployBox.run();
    }

    function testProxyStartsAsV1() public {
        vm.expectRevert();
        BoxV2(proxy).setNumber(10);
    }

    function testInitialize() public {
        BoxV1 box = BoxV1(proxy);
        box.initialize(10);
        assertEq(box.getNumber(), 10);
        BoxV1 v1 = new BoxV1();
        v1.initialize(1);
    }

    function testUpgrades() public {
        BoxV1 box = BoxV1(proxy);
        assertEq(box.version(), 1);

        BoxV2 box2 = new BoxV2();

        upgradeBox.updradeBox(proxy, address(box2));

        assertEq(box.version(), 2);
    }
}
