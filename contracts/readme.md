# 🏭 StableFactory & 🌊 FlowStable Secure Faucet

This repository contains the core smart contracts powering the **StableFactory** token launchpad and the **FlowStable Secure Faucet**.

These contracts are designed for the **Stable Testnet (Chain ID: 2201)** to allow users to generate custom ERC20 tokens and receive gasless airdrops of gUSDT.

---

## 📂 Contracts Overview

### 1. Token Factory System
**Files:** `LaunchpadToken.sol`, `TokenFactory.sol`  

A factory-pattern architecture that allows users to deploy their own customizable ERC20 tokens with a single transaction.

- **TokenFactory**: Entry point contract. Accepts a configuration struct, deploys a new `LaunchpadToken`, and emits a `TokenCreated` event.
- **LaunchpadToken**: Enhanced ERC20 contract supporting:
  - **Mintable:** Owner can mint new tokens (if enabled).
  - **Burnable:** Holders can destroy tokens (if enabled).
  - **Pausable:** Owner can freeze all transfers (if enabled).
  - **Supply Management:** Supports Fixed, Capped, and Unlimited supply models.

---

### 2. FlowStable Secure Faucet
**Files:** `FlowStableSecureFaucet.sol`  

A security-hardened faucet that dispenses **1 gUSDT** per claim.

- **Mechanism:** Gasless claiming via Meta-Transactions.
- **Security:** Uses ECDSA signature verification to ensure requests are authorized.
- **Protections:** Replay protection (Nonces), Chain ID validation, Max Claim limits (5 claims per wallet).

---

## 🛠️ Technical Specifications

### Token Factory (LaunchpadToken.sol)
- **Solidity Version:** ^0.8.20
- **Dependencies:** OpenZeppelin (ERC20, Ownable, Pausable, Burnable)
- **Functions:**
  - `mint(address to, uint256 amount)` — Restricted to Owner. Checks `maxSupply` if set.
  - `pause()` / `unpause()` — Restricted to Owner. Freezes _update logic.
  - `burn(uint256 value)` — Public. Reduces totalSupply.

### Secure Faucet (FlowStableSecureFaucet.sol)
- **Solidity Version:** ^0.8.19
- **Native Currency:** gUSDT (18 Decimals)
- **Claim Limit:** 5 claims per wallet
- **Fund Amount:** 1 gUSDT per claim

---

## 🔐 Faucet Security & Integration

1. **Hashing Logic**
```solidity
bytes32 messageHash = keccak256(abi.encodePacked(
    userAddress,
    contractAddress,
    chainId,
    nonce
));
````

```javascript
const messageHash = ethers.solidityPackedKeccak256(
    ["address", "address", "uint256", "uint256"],
    [userAddress, FAUCET_CONTRACT_ADDRESS, 2201, nonce]
);
const signature = await signer.signMessage(ethers.getBytes(messageHash));
```

2. **Interaction Flow**

* Frontend fetches `nonces(userAddress)` from contract.
* User signs hash `(User + Target + ChainID + Nonce)`.
* Backend validates eligibility.
* Backend calls `claimGasless(user, signature)` on the contract.
* Contract verifies signer, increments nonce, and sends 1 gUSDT.

---

## 🚀 Deployment Instructions

**Prerequisites:**

* Node.js & Hardhat/Foundry
* Wallet with gUSDT for deployment gas

1. **Deploy Factory**

```solidity
// Deploy TokenFactory.sol
```

2. **Deploy Faucet**

```solidity
// Deploy FlowStableSecureFaucet.sol
// Owner is set to deployer
```

After deployment, fund the faucet by sending gUSDT to its address.

---

## 📜 ABI References

**TokenFactory ABI**

```json
[
  "function createToken(tuple(string name, string symbol, uint256 initialSupply, uint256 maxSupply, bool isMintable, bool isBurnable, bool isPausable) config) external payable returns (address)",
  "event TokenCreated(address indexed tokenAddress, address indexed owner, string name, string symbol, uint256 initialSupply, string tokenType)"
]
```

**Faucet ABI**

```json
[
  "function claimGasless(address user, bytes memory signature) external",
  "function nonces(address) view returns (uint256)",
  "function claimCount(address) view returns (uint256)",
  "function MAX_CLAIMS() view returns (uint256)"
]
```

---

**Powered by FlowStable**

```

This README is structured for **GitHub**, easy to read, and explains both your token factory and faucet clearly.  

If you want, I can also **make a shorter “one-page quickstart” version** for deployers to just copy-paste commands. Do you want me to do that?
```
