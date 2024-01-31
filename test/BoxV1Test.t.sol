// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {Test} from "forge-std/Test.sol";
import {BoxV1} from "../src/BoxV1.sol";

contract BoxV1Test is Test {
    BoxV1 box;

    function setUp() external {
        box = new BoxV1();
    }

    function testBoxInitialize() public {
        box.initialize(10);
    }
}
