pragma solidity ^0.8.0;

import "hardhat/console.sol";
// Import OpenZeppelin Contracts
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
// Import the helper functions from base64 contract
import { Base64 } from "./libraries/Base64.sol";


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
    
    event NewEpicNFTMinted(address sender, uint256 tokenId);

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
        string memory combinedWord = string(abi.encodePacked(first, second));

        // Create SVG dynamically by concatenating baseSVG, randomly grabbed first word, second word, and then close the <text> and <svg> tags.
        string memory finalSvg = string(abi.encodePacked(baseSvg, first, second, "</text></svg>"));
        
        // Dynamically generate the metadata
        // Get all the JSON metadata in place and base64 encode it.
        string memory json = Base64.encode(
            bytes(
                string(
                    abi.encodePacked(
                        '{"name": "',
                        // Set the title of our NFT as the generated word.
                        combinedWord,
                        '", "description": "A highly acclaimed collection of squares.", "image": "data:image/svg+xml;base64,',
                        // Add data:image/svg+xml;base64 and then append our base64 encode our svg.
                        Base64.encode(bytes(finalSvg)),
                        '"}'
                    )
                )
            )
        );

        // Just like before, we prepend data:application/json;base64, to our data.
        string memory finalTokenUri = string(
            abi.encodePacked("data:application/json;base64,", json)
        );

        console.log("\n--------------------");
        console.log(finalTokenUri);
        console.log("--------------------\n");

        // Mint the NFT to the sender
        _safeMint(msg.sender, newItemId);

        // Set the NFTs data
        _setTokenURI(newItemId, finalTokenUri);
        console.log("An NFT with token Id %s has been minted to %s", newItemId, msg.sender);

        // Increment the counter for next NFT
        _tokenIds.increment();

        // Emit event
        emit NewEpicNFTMinted(msg.sender, newItemId);
    }
}