🏭 StableFactory & 🌊 Secure Faucet Contracts

This repository contains the core smart contracts powering the StableFactory token launchpad and the FlowStable Secure Faucet.

These contracts are designed for the Stable Testnet (Chain ID: 2201) to allow users to generate custom ERC20 tokens and receive gasless airdrops of gUSDT.

📂 Contracts Overview

1. Token Factory System

Files: LaunchpadToken, TokenFactory
A factory-pattern architecture that allows users to deploy their own customizable ERC20 tokens with a single transaction.

TokenFactory: The entry point contract. It takes a configuration struct, deploys a new LaunchpadToken, and emits a TokenCreated event for indexing.

LaunchpadToken: An enhanced ERC20 contract that supports:

Mintable: Owner can mint new tokens (if enabled).

Burnable: Holders can destroy tokens (if enabled).

Pausable: Owner can freeze all transfers (if enabled).

Supply Management: Supports Fixed, Capped, and Unlimited supply models.

2. FlowStable Secure Faucet

Files: FlowStableSecureFaucet
A security-hardened faucet that dispenses 1 gUSDT (Native Currency) to users.

Mechanism: Gasless claiming via Meta-Transactions.

Security: Uses ECDSA signature verification to ensure requests are authorized by a backend relayer.

Protections: Includes Replay Protection (Nonces), Chain ID validation, and Max Claim limits.

🛠️ Technical Specifications

Token Factory (LaunchpadToken.sol)

Solidity Version: ^0.8.20

Dependencies: OpenZeppelin (ERC20, Ownable, Pausable, Burnable).

Features:

mint(address to, uint256 amount): Restricted to Owner. Checks maxSupply if set.

pause() / unpause(): Restricted to Owner. Freezes _update logic.

burn(uint256 value): Public. Reduces totalSupply.

Secure Faucet (FlowStableSecureFaucet.sol)

Solidity Version: ^0.8.19

Native Currency: gUSDT (18 Decimals).

Claim Limit: 5 Claims per wallet.

Fund Amount: 1.0 gUSDT per claim.

🔐 Faucet Security & Integration

The Faucet uses an off-chain signing mechanism to prevent bot spam and allow the backend to pay for the gas fees (Gasless Claim).

1. The Hashing Logic

The smart contract verifies the signature against a hash composed of specific parameters. To generate a valid signature on the frontend/backend, follow this structure:

Solidity Logic:

bytes32 messageHash = keccak256(abi.encodePacked(
    userAddress,
    contractAddress,
    chainId,
    nonce
));


JavaScript (Ethers v6) Implementation:

const messageHash = ethers.solidityPackedKeccak256(
    ["address", "address", "uint256", "uint256"],
    [
        userAddress, 
        FAUCET_CONTRACT_ADDRESS, 
        2201, // Stable Testnet Chain ID
        nonce // Current nonce from contract
    ]
);

// Sign the binary data
const signature = await signer.signMessage(ethers.getBytes(messageHash));


2. Interaction Flow

Frontend: Fetches nonces(userAddress) from the contract.

Frontend: User signs the hash of (User + Target + ChainID + Nonce).

Frontend: Sends signature and userAddress to the Backend API.

Backend: Validates eligibility (IP check, captcha, etc.).

Backend: Calls claimGasless(user, signature) on the contract, paying the gas fee.

Contract: Verifies signer matches user, increments nonce, and sends 1 gUSDT.

🚀 Deployment Instructions

Prerequisites

Node.js & Hardhat/Foundry

Wallet with gUSDT for deployment gas.

1. Deploy Factory

// Deploy TokenFactory.sol
// No constructor arguments required


2. Deploy Faucet

// Deploy FlowStableSecureFaucet.sol
// Constructor sets msg.sender as owner


After deployment, the owner must fund the Faucet contract by sending gUSDT to its address.

📜 ABI References

TokenFactory ABI

[
  "function createToken(tuple(string name, string symbol, uint256 initialSupply, uint256 maxSupply, bool isMintable, bool isBurnable, bool isPausable) config) external payable returns (address)",
  "event TokenCreated(address indexed tokenAddress, address indexed owner, string name, string symbol, uint256 initialSupply, string tokenType)"
]


Faucet ABI

[
  "function claimGasless(address user, bytes memory signature) external",
  "function nonces(address) view returns (uint256)",
  "function claimCount(address) view returns (uint256)",
  "function MAX_CLAIMS() view returns (uint256)"
]


Powered by FlowStable
