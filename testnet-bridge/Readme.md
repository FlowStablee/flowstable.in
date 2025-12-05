# Stable-Testnet-Bridge
It allows users to Mint testnet tokens on Sepolia, Bridge them via LayerZero, and Unwrap them into gUSDT on StableChain.
# 🌊 FlowStable

**The Gateway to StableChain.**

FlowStable is a seamless, decentralized interface designed to onboard users onto the **Stable.xyz Testnet**. It simplifies the complex process of acquiring liquidity by guiding users through a 3-step journey: **Mint, Bridge, and Unwrap**.

Built with a focus on UX, FlowStable leverages **LayerZero's OFT standard** for cross-chain messaging and interacts directly with StableChain's wrapper contracts.

![FlowStable UI](https://via.placeholder.com/800x400?text=Project+Screenshot+Here)
## 🚀 Key Features

* **1. Mint Faucet:** One-click minting of testnet `USDT0` tokens on the Sepolia network.
* **2. Cross-Chain Bridge:** Secure bridging from Sepolia to Stable Testnet using **LayerZero** technology.
* **3. Auto-Unwrap:** Convert bridged tokens into **gUSDT** (StableChain's native gas token) instantly.
* **4. Smart UX:**
    * Auto-network switching (Sepolia ↔ Stable).
    * Real-time balance updates.
    * Rate-limit optimized RPC handling.
    * Professional "Dark Mode" UI inspired by Uniswap.

## 🛠️ Tech Stack

* **Frontend:** HTML5, CSS3 (Radial Gradients, Glassmorphism).
* **Blockchain Logic:** Ethers.js (v6).
* **Integrations:**
    * **LayerZero:** For cross-chain message passing.
    * **StableChain:** For final settlement and unwrapping.

## ⛓️ Contract Addresses & Config

| Asset | Network | Address / Value |
| :--- | :--- | :--- |
| **USDT0 Token** | Sepolia | `0xc4DCC311c028e341fd8602D8eB89c5de94625927` |
| **OApp (Bridge)** | Sepolia | `0xc099cD946d5efCC35A99D64E808c1430cEf08126` |
| **USDT0 Token** | Stable Testnet | `0x78Cf24370174180738C5B8E352B6D14c83a6c9A9` |
| **Wrapper** | Stable Testnet | `0xcAB8F3ed8528655E0C2fad1C504c6CfEccf50B90` |
| **Chain ID** | Stable Testnet | `2201` (0x899) |
| **LayerZero EID** | Destination | `40374` |

## ⚡ How to Run Locally

Since this project uses vanilla JS and Ethers.js via CDN, you don't need `npm install` or a build process.

1.  **Clone the repository:**
    ```bash
    git clone [https://github.com/your-username/flowstable.git](https://github.com/your-username/flowstable.git)
    cd flowstable
    ```

2.  **Serve the files:**
    It is recommended to run this on a local server to avoid CORS issues with MetaMask.
    
    * **Using Python:**
        ```bash
        python -m http.server 8000
        ```
    * **Using VS Code:**
        Right-click `mint.html` and select **"Open with Live Server"**.

3.  **Start the Flow:**
    Open `http://localhost:8000/mint.html` in your browser.

## 📖 Usage Guide

1.  **Step 1 (Mint):** Connect MetaMask to **Sepolia**. Click "Mint" to receive 1000 USDT0.
2.  **Step 2 (Bridge):** Go to the Bridge tab. Approve the contract, Quote the LayerZero fee, and click **Bridge**. Wait for the transaction to finalize on Sepolia.
3.  **Step 3 (Unwrap):** Switch network to **Stable Testnet**. Approve the wrapper contract and click **Swap** to receive **gUSDT**.

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

1.  Fork the Project
2.  Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3.  Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4.  Push to the Branch (`git push origin feature/AmazingFeature`)
5.  Open a Pull Request

## 📄 License

Distributed under the MIT License. See `LICENSE` for more information.

---

<p align="center">
  Built with ❤️ for the Stable.xyz Community
</p>
