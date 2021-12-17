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
        _setTokenURI(newItemId, "data:application/json;base64,ewogICAgIm5hbWUiOiAiUmljaydzIENhdGNocGhyYXNlIiwKICAgICJkZXNjcmlwdGlvbiI6ICJDYXRjaHBocmFzZSBvZiBzbWFydGVzdCBpbiB0aGUgdW5pdmVyc2UsIHdoaWNoIG1lYW4gSSBhbSBpbiBncmVhdCBwYWluIiwKICAgICJpbWFnZSI6ICJkYXRhOmltYWdlL3N2Zyt4bWw7YmFzZTY0LFBITjJaeUI0Yld4dWN6MGlhSFIwY0RvdkwzZDNkeTUzTXk1dmNtY3ZNakF3TUM5emRtY2lJSEJ5WlhObGNuWmxRWE53WldOMFVtRjBhVzg5SW5oTmFXNVpUV2x1SUcxbFpYUWlJSFpwWlhkQ2IzZzlJakFnTUNBek5UQWdNelV3SWo0S0lDQWdJRHh6ZEhsc1pUNHVZbUZ6WlNCN0lHWnBiR3c2SUhkb2FYUmxPeUJtYjI1MExXWmhiV2xzZVRvZ2MyVnlhV1k3SUdadmJuUXRjMmw2WlRvZ01UUndlRHNnZlR3dmMzUjViR1UrQ2lBZ0lDQThjbVZqZENCM2FXUjBhRDBpTVRBd0pTSWdhR1ZwWjJoMFBTSXhNREFsSWlCbWFXeHNQU0ppYkdGamF5SWdMejRLSUNBZ0lEeDBaWGgwSUhnOUlqVXdKU0lnZVQwaU5UQWxJaUJqYkdGemN6MGlZbUZ6WlNJZ1pHOXRhVzVoYm5RdFltRnpaV3hwYm1VOUltMXBaR1JzWlNJZ2RHVjRkQzFoYm1Ob2IzSTlJbTFwWkdSc1pTSStWM1ZpWW1FZ2JIVmlZbUVnWkhWaUlHUjFZaUU4TDNSbGVIUStDand2YzNablBnPT0iCn0=");
        console.log("An NFT with token Id %s has been minted to %s", newItemId, msg.sender);
        // Increment the counter for next NFT
        _tokenIds.increment();
    }
}