//SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import {Script} from "forge-std/Script.sol";
import {BasicNft} from "../src/BasicNft.sol";

contract DeployBasicNft is Script {
    function run() external returns (BasicNft) {
        vm.startBroadcast();
        // Deploy the BasicNft contract
        BasicNft basicNft = new BasicNft();
        vm.stopBroadcast();

        return basicNft;
    }
}
