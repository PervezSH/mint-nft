pragma solidity ^0.8.0;

import "hardhat/console.sol";
// Import OpenZeppelin Contracts
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

// Inherit the contract we imported
contract MyNFT is ERC721URIStorage {

    // Keep track of Token Ids
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    // Base SVG variable
    string baseSvg = "<svg xmlns='http://www.w3.org/2000/svg' preserveAspectRatio='xMinYMin meet' viewBox='0 0 350 350'><style>.base { fill: white; font-family: serif; font-size: 24px; }</style><rect width='100%' height='100%' fill='black' /><text x='50%' y='50%' class='base' dominant-baseline='middle' text-anchor='middle'>";

    // Arrays of Random words
    string[] firstWords = ["Alpha", "Angel", "Baby", "Bazooka", "Buckshot", "Captain", "Cool", "Cosmo", "Electric", "Duck"];
    string[] secondWords = ["Gojo", "Eren", "Levi", "Hisoka", "Killua", "Okkotsu", "Panda", "Inumaki", "Mizuhara", "Sukuna"];

    // Randon Generator
    function random(string memory input) internal pure returns (uint256) {
      return uint256(keccak256(abi.encodePacked(input)));
    }

    // Function to randomly pick a word
    function pickRandomFirstWord (uint256 tokenId) public view returns (string memory) {
        // Generate random # using first word anda stringified version of the tokenId
        uint256 rand = random(string(abi.encodePacked("FIRST_WORD", Strings.toString(tokenId))));
        // Squash the random # between 0 and the length of the array to avoid going out of bounds.
        rand = rand % firstWords.length;
        return firstWords[rand];
    }
    function pickRandomSecondWord(uint256 tokenId) public view returns (string memory) {
        uint256 rand = random(string(abi.encodePacked("SECOND_WORD", Strings.toString(tokenId))));
        rand = rand % secondWords.length;
        return secondWords[rand];
    }

    // Pass the name of our NFTs token and it's symbol
    // NFT standard is known as ERC721
    constructor () ERC721 ("PerSh_NFT", "PERX") {
        console.log("I'm an NFT Contract:)");
    }

    // Function user will hit to get their NFT
    function makeAnNFT () public {
        // Get current token tokenId, starts at 0
        uint256 newItemId = _tokenIds.current();
        // Randomly grab one word from each of the two  arrays.
        string memory first = pickRandomFirstWord(newItemId);
        string memory second = pickRandomSecondWord(newItemId);
        // Create SVG dynamically by concatenating baseSVG, randomly grabbed first word, second word, and then close the <text> and <svg> tags.
        string memory finalSvg = string(abi.encodePacked(baseSvg, first, second, "</text></svg>"));
        console.log("\n--------------------");
        console.log(finalSvg);
        console.log("--------------------\n");
        // Mint the NFT to the sender
        _safeMint(msg.sender, newItemId);
        // Set the NFTs data
        _setTokenURI(newItemId, "data:application/json;base64,ewogICAgIm5hbWUiOiAiUmljaydzIENhdGNocGhyYXNlIiwKICAgICJkZXNjcmlwdGlvbiI6ICJDYXRjaHBocmFzZSBvZiBzbWFydGVzdCBpbiB0aGUgdW5pdmVyc2UsIHdoaWNoIG1lYW4gSSBhbSBpbiBncmVhdCBwYWluIiwKICAgICJpbWFnZSI6ICJkYXRhOmltYWdlL3N2Zyt4bWw7YmFzZTY0LFBITjJaeUI0Yld4dWN6MGlhSFIwY0RvdkwzZDNkeTUzTXk1dmNtY3ZNakF3TUM5emRtY2lJSEJ5WlhObGNuWmxRWE53WldOMFVtRjBhVzg5SW5oTmFXNVpUV2x1SUcxbFpYUWlJSFpwWlhkQ2IzZzlJakFnTUNBek5UQWdNelV3SWo0S0lDQWdJRHh6ZEhsc1pUNHVZbUZ6WlNCN0lHWnBiR3c2SUhkb2FYUmxPeUJtYjI1MExXWmhiV2xzZVRvZ2MyVnlhV1k3SUdadmJuUXRjMmw2WlRvZ01UUndlRHNnZlR3dmMzUjViR1UrQ2lBZ0lDQThjbVZqZENCM2FXUjBhRDBpTVRBd0pTSWdhR1ZwWjJoMFBTSXhNREFsSWlCbWFXeHNQU0ppYkdGamF5SWdMejRLSUNBZ0lEeDBaWGgwSUhnOUlqVXdKU0lnZVQwaU5UQWxJaUJqYkdGemN6MGlZbUZ6WlNJZ1pHOXRhVzVoYm5RdFltRnpaV3hwYm1VOUltMXBaR1JzWlNJZ2RHVjRkQzFoYm1Ob2IzSTlJbTFwWkdSc1pTSStWM1ZpWW1FZ2JIVmlZbUVnWkhWaUlHUjFZaUU4TDNSbGVIUStDand2YzNablBnPT0iCn0=");
        console.log("An NFT with token Id %s has been minted to %s", newItemId, msg.sender);
        // Increment the counter for next NFT
        _tokenIds.increment();
    }
}