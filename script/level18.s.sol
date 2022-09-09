// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

import "forge-std/Script.sol";
import "src/level18.sol";

contract POC is Script {
    MagicNum level18;

    function setUp() public {
        level18 = MagicNum(0x386124C347C97C6f1fB84f5c472F20c9d5cA97f4);
    }

    function run() external {
        /**
        The steps to perform a raw EVM bytecode deploy to return uint 42.

        Runtime code (10 bytes):

        PUSH1 0x2A <-- value (32-byte)
        PUSH1 0x80 <-- offset
        MSTORE <-- Save word to memory

        PUSH1 0x20 <-- size == 32 = 0x20
        PUSH1 0x80 <-- offset
        RETURN <-- 	Halt execution returning output data
        
        Initialization code (12 bytes):

        (This section is only copying the runtime code and placing at 0x00 offset)
        PUSH1 0x0a <-- size (10 bytes) == size of the runtime code
        PUSH1 0x0c <-- offset == 12 == size of init code (12 bytes)
        PUSH1 0x00 <-- destOffset - destination to where paste the code
        CODECOPY <-- Copy code running in current environment to memory

        (This section will actually execute the runtime code)
        PUSH1 0x0a <-- size == 10 == 0x0a (runtime code)
        PUSH1 0x00 <-- offset == destOffset 
        RETURN <-- Halt execution returning output data

        References:
        https://blog.dixitaditya.com/ethernaut-level-18-magicnumber
        https://www.evm.codes/
        https://cmichel.io/ethernaut-solutions/
        https://medium.com/coinmonks/ethernaut-lvl-19-magicnumber-walkthrough-how-to-deploy-contracts-using-raw-assembly-opcodes-c50edb0f71a2

         */
        vm.startBroadcast();

        address solver;

        bytes memory code = hex"600a600c600039600a6000f3602a60805260206080f3";

        assembly {
            solver := create(0, add(code, 0x20), mload(code))
        }
        level18.setSolver(solver);

        vm.stopBroadcast();
    }
}
