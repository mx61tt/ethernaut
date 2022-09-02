// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.6.0;

import "forge-std/Test.sol";
import "../src/level0.sol";

contract POC is Test {
    Instance level0 = Instance(0xb7EDaB9083BD4596575FC781381ca27Eae5D08e9);

    function test() external {
        vm.startBroadcast();

        level0.password();
        level0.authenticate(level0.password());

        vm.stopBroadcast();
    }
}
