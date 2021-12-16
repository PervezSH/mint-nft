pragma solidity ^0.8.0;

import "hardhat/console.sol";
// Import OpenZeppelin Contracts
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

// Inherit the contract we imported
contract MyNFT is ERC721URIStorage {

    // Keep track of Token Ids
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    // Pass the name of our NFTs token and it's symbol
    // NFT standard is known as ERC721
    constructor () ERC721 ("PerSh_NFT", "PERX") {
        console.log("I'm an NFT Contract:)");
    }

    // Function user will hit to get their NFT
    function makeAnNFT () public {
        // Get current token tokenId, starts at 0
        uint256 newItemId = _tokenIds.current();
        // Mint the NFT to the sender
        _safeMint(msg.sender, newItemId);
        // Set the NFTs data
        _setTokenURI(newItemId, "https://jsonkeeper.com/b/8F71");
        console.log("An NFT with token Id %s has been minted to %s", newItemId, msg.sender);
        // Increment the counter for next NFT
        _tokenIds.increment();
    }
}