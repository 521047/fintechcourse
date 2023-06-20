# Vault Smart Contract

This repository contains the Vault contract implemented in Solidity. The contract manages ERC721 Non-Fungible Tokens (NFTs) and issues ERC20 tokens.

## Contract Description

The Vault contract is designed to allow whitelisted addresses to deposit and withdraw ERC721 NFTs. The owner of the contract has the authority to set a "price" for any deposited NFT, expressed in the contract's own ERC20 tokens. The owner of these ERC20 tokens can then burn their tokens in exchange for withdrawing the specified NFT.

Once NFTs have been deposited and their prices set, the contract owner can lock the vault, issue ERC20 tokens, and specify percentage allocations for each of the previous depositors. These depositors can then withdraw their allocated ERC20 tokens.

## Contract Structure

The contract incorporates features from OpenZeppelin's ERC20 and Ownable contracts.

### Structures

#### NFT

A structure storing the details about the NFT, including its owner, contract address, and price in ERC20 tokens.

#### Mappings

- `_depositedNFTs`: Maps from contract address and token ID to the NFT struct.
- `_depositors`: Maps approved depositors.
- `_allocations`: Maps the percentage allocations for each depositor.

### Key Functions

#### addDepositor

Allows the contract owner to whitelist a depositor.

#### depositNFT

Allows a whitelisted depositor to deposit an NFT from a specific contract into the vault.

#### setNFTPrice

Allows the contract owner to set a price for an NFT in the contract's ERC20 tokens.

#### withdrawNFT

Allows the NFT's original owner to withdraw it, assuming the vault is not locked.

#### purchaseNFT

Allows any address to purchase a deposited NFT using the contract's ERC20 tokens, assuming the vault is locked.

#### lockVault / unlockVault

Allows the contract owner to lock or unlock the vault.

#### mintVaultToken

Allows the contract owner to mint ERC20 tokens.

#### setAllocation

Allows the contract owner to set the percentage allocations for each depositor.

#### withdrawVaultToken

Allows depositors to withdraw their allocated ERC20 tokens.

## Testing and Deployment

It is advised to thoroughly test this contract using Hardhat or another Ethereum development environment before deploying it to a live network. Verification of the contract's functionality and ensuring its behavior aligns with the expected outcomes is crucial.
