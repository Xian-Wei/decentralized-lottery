# Decentralized Lottery (Raffle) with Foundry & Chainlink VRF

This project implements a decentralized lottery (raffle) smart contract using Solidity, tested and deployed locally with **Foundry** and Chainlink's VRF mock. The lottery randomly selects a winner among entrants after a time interval.

> ⚠️ **Warning:** The `DeployRaffle` script can fail due to a bug in `SubscriptionAPI.sol`. The subscription ID calculation using `block.number` and `s_currentSubNonce` may cause an overflow. Removing or adjusting the increment of `s_currentSubNonce` at the line where `subId` is computed fixes the error.

## Table of Contents

* [Prerequisites](#prerequisites)
* [Installation](#installation)
* [Deployment](#deployment)
* [Testing](#testing)
* [Interacting Locally](#interacting-locally)
* [Project Structure](#project-structure)
* [Makefile Commands](#makefile-commands)
* [Example Workflow](#example-workflow)
* [Optional: Testnet / Sepolia Deployment](#optional-testnet--sepolia-deployment)

## Prerequisites

* [Foundry](https://foundry.paradigm.xyz/)
* [Anvil](https://book.getfoundry.sh/anvil/overview) (local Ethereum node)
* [Node.js & npm](https://nodejs.org/) (optional, for additional scripts)

## Installation

Clone the repository and install dependencies in one step:

```bash
git clone <your-repo-url>
cd decentralized-lottery
forge install
```

## Deployment

Start a local node with Anvil:

```bash
anvil
```

Deploy the Raffle contract locally:

```bash
make deploy
```

This runs the `DeployRaffle` script and deploys the contract to your local Anvil chain.

## Testing

Run Foundry tests:

```bash
forge test
```

Or with verbose output:

```bash
forge test -vvv
```

## Interacting Locally

After deployment, you can interact with your raffle contract using the provided scripts and Makefile commands.

Enter the raffle and pick a winner:

```bash
make interactRaffle
```

This runs the full local cycle: enter the raffle using a funded account, warp time to satisfy the raffle interval, trigger `performUpkeep()` to request a random number, fulfill the random number using the VRF mock, and print the winner to the console.

**Notes:**

* Ensure Anvil is running before executing `make interactRaffle`.
* Scripts handle **timewarping** and VRF mock fulfillment automatically for local testing.

## Project Structure

```
├─ src/                # Solidity contracts
│  └─ Raffle.sol
├─ script/             # Foundry scripts
│  ├─ DeployRaffle.s.sol
│  └─ InteractRaffle.s.sol
├─ test/               # Solidity tests
├─ lib/                # Libraries (Chainlink mocks, DevOpsTools)
├─ broadcast/          # Foundry broadcast outputs
└─ Makefile            # Script commands
```

## Makefile Commands

* `make deploy` → Deploy the Raffle contract locally
* `make interactRaffle` → Enter the raffle, trigger upkeep, fulfill VRF, and pick a winner
* `make test` → Run all Foundry tests

## Example Workflow

```bash
# 1. Start local node
anvil

# 2. Deploy contract
make deploy

# 3. Enter raffle and pick a winner
make interactRaffle

# 4. Optional: run tests
make test
```

This workflow ensures a complete **local end-to-end lottery simulation**.

## Optional: Testnet / Sepolia Deployment

If you want to deploy to Sepolia or another testnet:

1. Add your **RPC URL** and **private key** in the Makefile or `.env` file.
2. Use the network argument when running the script:

```bash
make interactRaffle ARGS="--network sepolia"
```

Your Makefile should handle `NETWORK_ARGS` dynamically for local vs. testnet.

This README covers **installation, local deployment, testing, interaction, and optional testnet usage**, providing a complete guide for anyone using your decentralized lottery project.
