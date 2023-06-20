// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

import "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract Vault is ERC20, Ownable {
    struct NFT {
        address owner;
        address contractAddress;
        uint256 price;
    }

    mapping(address => mapping(uint256 => NFT)) private _depositedNFTs;
    mapping(address => bool) private _depositors;
    bool public isVaultLocked = false;
    mapping(address => uint256) private _allocations;

    constructor() ERC20("Vault Token", "VT") Ownable() {
    }

    function addDepositor(address _depositor) external onlyOwner {
        _depositors[_depositor] = true;
    }

    function depositNFT(address _contract, uint256 _tokenId) external {
        require(_depositors[msg.sender], "Depositor not whitelisted");
        require(!isVaultLocked, "Vault is locked");
        IERC721(_contract).transferFrom(msg.sender, address(this), _tokenId);
        _depositedNFTs[_contract][_tokenId] = NFT(msg.sender, _contract, 0);
    }

    function setNFTPrice(address _contract, uint256 _tokenId, uint256 _price) external onlyOwner {
        _depositedNFTs[_contract][_tokenId].price = _price;
    }

    function withdrawNFT(address _contract, uint256 _tokenId) external {
        require(_depositedNFTs[_contract][_tokenId].owner == msg.sender, "Caller not owner");
        require(!isVaultLocked, "Vault is locked");
        IERC721(_contract).transferFrom(address(this), msg.sender, _tokenId);
        delete _depositedNFTs[_contract][_tokenId];
    }

    function purchaseNFT(address _contract, uint256 _tokenId) external {
        require(isVaultLocked, "Vault is not locked");
        uint256 price = _depositedNFTs[_contract][_tokenId].price;
        require(balanceOf(msg.sender) >= price, "Insufficient Vault token balance");
        _burn(msg.sender, price);
        IERC721(_contract).transferFrom(address(this), msg.sender, _tokenId);
        delete _depositedNFTs[_contract][_tokenId];
    }

    function lockVault() external onlyOwner {
        isVaultLocked = true;
    }

    function unlockVault() external onlyOwner {
        isVaultLocked = false;
    }

    function mintVaultToken(uint256 amount) external onlyOwner {
        _mint(address(this), amount);
    }

    function setAllocation(address depositor, uint256 percentage) external onlyOwner {
        _allocations[depositor] = percentage;
    }

    function withdrawVaultToken() external {
        uint256 balance = balanceOf(address(this));
        uint256 amount = (balance * _allocations[msg.sender]) / 100;
        _transfer(address(this), msg.sender, amount);
    }

    function getNFTDetails(address _contract, uint256 _tokenId) external view returns (NFT memory) {
        return _depositedNFTs[_contract][_tokenId];
    }
}
