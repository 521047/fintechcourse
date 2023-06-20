Vault Solidity Contract
This repository contains a Vault contract written in Solidity, designed for managing ERC721 Non-fungible tokens (NFTs) and issuing ERC20 tokens.

Overview
The Vault contract allows whitelisted addresses to deposit and withdraw ERC721 NFTs. The owner of the contract can set a "price" for any deposited NFT, expressed in the contract's own ERC20 tokens. Any owner of these ERC20 tokens can then burn their tokens in exchange for withdrawing a specified NFT.

After depositing NFTs and setting prices, the contract owner can lock the vault, issue ERC20 tokens, and specify percentage allocations for each of the previous depositors. These depositors can then withdraw their allocated ERC20 tokens.

Contract Structure
The contract is based on OpenZeppelin's ERC20 and Ownable contracts. It contains several key structures and functions:

Structures
NFT: A structure to store details about the NFT - its owner, contract address, and price in ERC20 tokens.
_depositedNFTs: A mapping from contract address and token ID to the NFT struct.
_depositors: A mapping of approved depositors.
_allocations: A mapping of the percentage allocations for each depositor.
Key Functions
addDepositor: Allows the contract owner to whitelist a depositor.
depositNFT: Allows a whitelisted depositor to deposit an NFT from a specific contract into the vault.
setNFTPrice: Allows the contract owner to set a price for an NFT in the contract's ERC20 tokens.
withdrawNFT: Allows the NFT's original owner to withdraw it, assuming the vault is not locked.
purchaseNFT: Allows any address to purchase a deposited NFT using the contract's ERC20 tokens, assuming the vault is locked.
lockVault / unlockVault: Allows the contract owner to lock or unlock the vault.
mintVaultToken: Allows the contract owner to mint ERC20 tokens.
setAllocation: Allows the contract owner to set the percentage allocations for each depositor.
withdrawVaultToken: Allows depositors to withdraw their allocated ERC20 tokens.
Testing and Deployment
Please thoroughly test this contract using Hardhat or another Ethereum development environment before deploying it to a live network. It is important to verify the contract's functionality and ensure it behaves as expected.
