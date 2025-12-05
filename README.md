# FlowStable  
### Liquidity, Bridging, and DeFi Infrastructure for StableChain  
#### Built by FlowStable Labs

---

## Overview

FlowStable is a liquidity and bridging stack designed specifically for the **StableChain** ecosystem.  
This repository hosts the **official FlowStable website**, delivered as a fast, minimal, static deployment.

The website introduces the protocol, provides access to testnet tools, and acts as the primary entry point for users and developers.

---

## Product Modules

### 1. Bridge & Unwrap  
**Live on Testnet**

```
Transfer assets from Sepolia → StableChain  
Unwrap bridged tokens using FlowStable’s L2 unlock contract  
Powered by gUSDT settlement liquidity  
```

Accessible at:

```
flowstable.in/bridge-testnet
```

_Routed via Vercel rewrites to a dedicated bridge repository._

---

### 2. Spot Trading (DEX)  
**Coming Soon**

```
AMM-based DEX  
Native liquidity pools (FST/gUSDT)  
Clean trading interface  
StableChain-native routing logic  
```

---

### 3. Supply, Lend & Stake  
**Coming Soon**

```
Lending markets  
Staking pools  
Isolated risk models  
Network-native reward distribution  
```

---

## Website Architecture

```
/
|— index.html               Landing page
|— assets/                  Icons, images, styles
|— vercel.json              Route rewrites (bridge)
```

### Routing

```
/                    → Main website
/bridge-testnet      → Redirects to FlowStable Bridge UI deployment
```

---

## Tech Stack

```
HTML5  
CSS3  
JavaScript  
Vercel Static Deployment  
Custom routing with vercel.json  
```

The website uses no frameworks to ensure minimal load time and maximal reliability.

---

## Deployment

Production is deployed automatically through Vercel.

Trigger a deployment:

```
git push origin main
```

Manual deployment:

```
vercel deploy --prod
```

---

## Roadmap

```
▪ Fully featured DEX on StableChain  
▪ Android FlowStable Wallet  
▪ Liquidity analytics  
▪ Lending + staking primitives  
▪ FST token integration  
▪ Expanded bridging routes  
```

---

## Contributors

```
Pranav (@PranavOOx)
Naitik Rahane (@naitikrahane)
```

To contribute, fork the repository and open a pull request.

---

## License

MIT License.  
See `LICENSE` file for details.

---

## About FlowStable Labs

FlowStable Labs builds modular liquidity and asset mobility infrastructure for the Stable.xyz ecosystem.

```
Website: https://flowstable.in
Ecosystem: Stable.xyz
```

---
