# Decentralized Lottery (Raffle) with Foundry & Chainlink VRF

This project implements a decentralized lottery (raffle) smart contract using Solidity, tested and deployed locally with **Foundry** and Chainlink's VRF mock. The lottery randomly selects a winner among entrants after a time interval.

---

> ⚠️ **Warning:** The `DeployRaffle` script can fail due to a bug in `SubscriptionAPI.sol`. The subscription ID calculation using `block.number` and `s_currentSubNonce` may cause an overflow. Removing or adjusting the increment of `s_currentSubNonce` at the line where `subId` is computed fixes the error.

## Table of Contents

- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Deployment](#deployment)
- [Testing](#testing)
- [Interacting Locally](#interacting-locally)
- [Project Structure](#project-structure)

---

## Prerequisites

- [Foundry](https://foundry.paradigm.xyz/)
- [Anvil](https://book.getfoundry.sh/anvil/overview) (local Ethereum node)
- [Node.js & npm](https://nodejs.org/) (optional, for scripts)

---

## Installation

1. **Clone the repository:**

```bash
git clone <your-repo-url>
cd decentralized-lottery
```
