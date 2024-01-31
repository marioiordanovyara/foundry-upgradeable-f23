// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;
import {Script} from "forge-std/Script.sol";
import {DevOpsTools} from "@foundry-devops/DevOpsTools.sol";
import {BoxV2} from "../src/BoxV2.sol";
import {BoxV1} from "../src/BoxV1.sol";

contract UpgradeBox is Script {
    function run() external {
        vm.startBroadcast();
        BoxV2 box = new BoxV2();
        vm.stopBroadcast();

        address mostRecentlyDeployed = DevOpsTools.get_most_recent_deployment(
            "ERC19667Proxy",
            block.chainid
        );

        updradeBox(mostRecentlyDeployed, address(box));
    }

    function updradeBox(
        address proxyAddress,
        address newImplementation
    ) public {
        vm.startBroadcast();
        BoxV1(proxyAddress).upgradeToAndCall(newImplementation, "");
        vm.stopBroadcast();
    }
}
