// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {Script, console2} from "forge-std/Script.sol";
import {Raffle} from "../src/Raffle.sol";
import {DevOpsTools} from "lib/foundry-devops/src/DevOpsTools.sol";
import {
    VRFCoordinatorV2_5Mock
} from "lib/chainlink-brownie-contracts/contracts/src/v0.8/vrf/mocks/VRFCoordinatorV2_5Mock.sol";

contract InteractRaffle is Script {
    function run() external {
        // -----------------------------
        // 0. Setup
        // -----------------------------
        address raffleAddr = DevOpsTools.get_most_recent_deployment("Raffle", block.chainid);
        Raffle raffle = Raffle(raffleAddr);

        address localAccount = 0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266;
        vm.deal(localAccount, 100 ether);

        // -----------------------------
        // 1. Enter the raffle
        // -----------------------------
        vm.startBroadcast(localAccount);
        raffle.enterRaffle{value: raffle.getEntranceFee()}();
        console2.log("Entered the raffle!");
        vm.stopBroadcast();

        // -----------------------------
        // 2. Warp time so upkeep is valid
        // -----------------------------
        uint256 interval = raffle.getInterval();
        vm.warp(block.timestamp + interval + 1);
        console2.log("Time warped by interval + 1 second");

        // -----------------------------
        // 3. Trigger upkeep
        // -----------------------------
        vm.startBroadcast(localAccount);
        raffle.performUpkeep(""); // calls requestRandomWords internally
        vm.stopBroadcast();
        console2.log("performUpkeep() called, request sent to VRF");

        // -----------------------------
        // 4. Fulfill random words (local)
        // -----------------------------
        VRFCoordinatorV2_5Mock vrf =
            VRFCoordinatorV2_5Mock(DevOpsTools.get_most_recent_deployment("VRFCoordinatorV2_5Mock", block.chainid));

        uint256 requestId = 1; // usually first request
        vrf.fulfillRandomWords(requestId, raffleAddr);
        console2.log("Random number fulfilled by VRF mock");

        // -----------------------------
        // 5. Print the winner
        // -----------------------------
        address winner = raffle.getRecentWinner();
        console2.log("The winner is:", winner);
    }
}
