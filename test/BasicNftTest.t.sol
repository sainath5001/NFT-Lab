//SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import {Test} from "forge-std/Test.sol";
import {DeployBasicNft} from "../script/DeployBasicNft.s.sol";
import {BasicNft} from "../src/BasicNft.sol";

contract BasicNftTest is Test {
    DeployBasicNft public deployer;
    BasicNft public basicNft;
    address public USER = makeAddr("user");
    string public constant PUG =
        "ipfs://bafybeig37ioir76s7mg5oobetncojcm3c3hxasyd4rvid4jqhy4gkaheg4/?filename=0-PUG.json";

    function setUp() public {
        // This function is called before each test function
        deployer = new DeployBasicNft();
        basicNft = deployer.run();
    }

    function testNameIsCorrect() public view {
        // Test the name of the NFT
        string memory expectedName = "Dogie";
        string memory actualName = basicNft.name();
        assertEq(actualName, expectedName, "NFT name is incorrect");
    }

    function testSymbolIsCorrect() public view {
        // Test the symbol of the NFT
        string memory expectedSymbol = "DOG";
        string memory actualSymbol = basicNft.symbol();
        assertEq(actualSymbol, expectedSymbol, "NFT symbol is incorrect");
    }

    function testCanMintAndHaveABalance() public {
        vm.prank(USER);
        basicNft.mintNft(PUG);

        assert(basicNft.balanceOf(USER) == 1);
        assert(keccak256(abi.encodePacked(PUG)) == keccak256(abi.encodePacked(basicNft.tokenURI(0))));
    }

    //     function testTokenUriRevertsForNonExistentToken() public {
    //     // Try to get tokenURI for a token that hasn't been minted
    //     vm.expectRevert(BasicNft.BasicNft__TokenUriNotFound.selector);
    //     basicNft.tokenURI(0);
    // }
    function testGetTokenCounter() public {
        // Mint an NFT and check the token counter
        vm.prank(USER);
        basicNft.mintNft(PUG);
        uint256 expectedCounter = 1;
        uint256 actualCounter = basicNft.getTokenCounter();
        assertEq(actualCounter, expectedCounter, "Token counter is incorrect");
    }
}
