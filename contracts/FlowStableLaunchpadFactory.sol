// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Pausable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

// ==========================================
// 1. THE UNIVERSAL TOKEN
// ==========================================
contract LaunchpadToken is ERC20, ERC20Burnable, ERC20Pausable, Ownable {
    
    uint256 public immutable maxSupply;
    bool public immutable isMintable;
    bool public immutable isPausable;
    bool public immutable isBurnable; 

    constructor(
        string memory _name,
        string memory _symbol,
        uint256 _initialSupply,
        uint256 _maxSupply,
        address _creator,
        bool _isMintable,
        bool _isBurnable, 
        bool _isPausable
    ) ERC20(_name, _symbol) Ownable(_creator) {
        
        maxSupply = _maxSupply;
        isMintable = _isMintable;
        isPausable = _isPausable;
        isBurnable = _isBurnable; 

        if (_maxSupply > 0) {
            require(_initialSupply <= _maxSupply, "Init supply exceeds Max supply");
        }

        _mint(_creator, _initialSupply * 10 ** decimals());
    }

    // --- MINT LOGIC ---
    function mint(address to, uint256 amount) public onlyOwner {
        require(isMintable, "Minting is disabled (Fixed Supply)");
        if (maxSupply > 0) {
            require(totalSupply() + amount <= maxSupply * 10 ** decimals(), "Exceeds Max Supply");
        }
        _mint(to, amount);
    }

    // --- PAUSE LOGIC ---
    function pause() public onlyOwner {
        require(isPausable, "Token is Unstoppable (Cannot Pause)");
        _pause();
    }

    function unpause() public onlyOwner {
        require(isPausable, "Token is Unstoppable");
        _unpause();
    }

    // --- BURN LOGIC (FIX: Added Override) ---
    function burn(uint256 value) public override {
        require(isBurnable, "Burning is disabled");
        super.burn(value);
    }

    function burnFrom(address account, uint256 value) public override {
        require(isBurnable, "Burning is disabled");
        super.burnFrom(account, value);
    }

    // --- REQUIRED OVERRIDES ---
    function _update(address from, address to, uint256 value)
        internal
        override(ERC20, ERC20Pausable)
    {
        super._update(from, to, value);
    }
}

// ==========================================
// 2. THE FACTORY
// ==========================================
contract TokenFactory {

    event TokenCreated(
        address indexed tokenAddress,
        address indexed owner,
        string name,
        string symbol,
        uint256 initialSupply,
        string tokenType
    );

    struct TokenConfig {
        string name;
        string symbol;
        uint256 initialSupply;
        uint256 maxSupply;
        bool isMintable;
        bool isBurnable;
        bool isPausable;
    }

    function createToken(TokenConfig memory config) external payable returns (address) {
        
        LaunchpadToken newToken = new LaunchpadToken(
            config.name,
            config.symbol,
            config.initialSupply,
            config.maxSupply,
            msg.sender,
            config.isMintable,
            config.isBurnable,
            config.isPausable
        );

        emit TokenCreated(
            address(newToken),
            msg.sender,
            config.name,
            config.symbol,
            config.initialSupply,
            config.isMintable ? "Mintable" : "Fixed"
        );

        return address(newToken);
    }
}
