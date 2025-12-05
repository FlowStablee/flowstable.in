// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

// Security Note: Native gUSDT optimized contract
contract FlowStableSecureFaucet {
    address public owner;
    
    // 1 gUSDT (Native) = 10^18 units
    uint256 public constant FUND_AMOUNT = 1 ether; 
    uint256 public constant MAX_CLAIMS = 5;

    mapping(address => uint256) public claimCount;
    mapping(address => uint256) public nonces;

    event FeeSent(address indexed recipient, uint256 amount);
    event Deposit(address indexed sender, uint256 amount);

    constructor() {
        owner = msg.sender;
    }

    
    receive() external payable {
        emit Deposit(msg.sender, msg.value);
    }

    // 2. Main Gasless Function
    function claimGasless(address user, bytes memory signature) external {
        // --- CHECKS ---
        require(address(this).balance >= FUND_AMOUNT, "Faucet Empty");
        require(claimCount[user] < MAX_CLAIMS, "Limit Reached");

        // --- VERIFY SIGNATURE (SECURE) ---
        bytes32 messageHash = keccak256(abi.encodePacked(
            user, 
            address(this), 
            block.chainid, // 🛡️ Security Layer: Chain ID protection
            nonces[user]
        ));
        
        bytes32 ethSignedMessageHash = keccak256(
            abi.encodePacked("\x19Ethereum Signed Message:\n32", messageHash)
        );

        address signer = recoverSigner(ethSignedMessageHash, signature);
        require(signer == user, "Invalid Signature: Frontend and Contract logic not matched");

        // --- EFFECTS (State Update First) ---
        claimCount[user]++;
        nonces[user]++;

        // --- INTERACTIONS (Send Money) ---
        (bool success, ) = payable(user).call{value: FUND_AMOUNT}("");
        require(success, "Transfer Failed: Contract balance check");
        
        emit FeeSent(user, FUND_AMOUNT);
    }

    // --- HELPER FUNCTIONS ---

    function recoverSigner(bytes32 _ethSignedMessageHash, bytes memory _signature)
        internal
        pure
        returns (address)
    {
        (bytes32 r, bytes32 s, uint8 v) = splitSignature(_signature);
        return ecrecover(_ethSignedMessageHash, v, r, s);
    }

    function splitSignature(bytes memory sig)
        internal
        pure
        returns (bytes32 r, bytes32 s, uint8 v)
    {
        require(sig.length == 65, "Invalid signature length");
        assembly {
            r := mload(add(sig, 32))
            s := mload(add(sig, 64))
            v := byte(0, mload(add(sig, 96)))
        }
    }

    
    function withdraw() external {
        require(msg.sender == owner, "Only Owner");
        payable(owner).transfer(address(this).balance);
    }
}
