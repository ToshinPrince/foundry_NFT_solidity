// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

//...................................................................(1)
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
        deployer = new DeployBasicNft();
        basicNft = deployer.run();
    }

    function testNameIsCorrect() public view {
        string memory expectedName = "dogiee";
        string memory actualName = basicNft.name();
        assert(
            keccak256(abi.encodePacked(expectedName)) ==
                keccak256(abi.encodePacked(actualName))
        );
    }

    function testCanMintAndHaveABalance() public {
        vm.prank(USER);
        basicNft.mintNft(PUG);

        assert(basicNft.balanceOf(USER) == 1);
        assert(
            keccak256(abi.encodePacked(PUG)) ==
                keccak256(abi.encodePacked(basicNft.tokenURI(0)))
        );
    }

    //.......................................................................(2)
    // import {Test} from "forge-std/Test.sol";
    // import {DeployBasicNft} from "../script/DeployBasicNft.s.sol";
    // import {BasicNft} from "../src/BasicNft.sol";

    // contract BasicNftTest is Test {
    //     DeployBasicNft public deployer;
    //     BasicNft public basicNft;
    //     address public owner;
    //     address public user1;
    //     address public user2;

    //     function setUp() public {
    //         deployer = new DeployBasicNft();
    //         basicNft = deployer.run();
    //         owner = vm.addr(1);
    //         user1 = vm.addr(2);
    //         user2 = vm.addr(3);
    //     }

    //     function testMintNFT() public {
    //         string memory tokenUri1 = "https://example.com/nft1";
    //         string memory tokenUri2 = "https://example.com/nft2";

    //         vm.prank(owner);
    //         basicNft.mintNft(tokenUri1);
    //         assertEq(basicNft.balanceOf(owner), 1);
    //         assertEq(basicNft.tokenURI(0), tokenUri1);

    //         vm.prank(user1);
    //         basicNft.mintNFT(tokenUri2);
    //         assertEq(basicNft.balanceOf(user1), 1);
    //         assertEq(basicNft.tokenURI(1), tokenUri2);
    //     }

    //     function testFailMintNFTWithInvalidTokenUri() public {
    //         string memory invalidTokenUri = "";
    //         vm.prank(owner);
    //         basicNft.mintNft(invalidTokenUri);
    //     }

    //     function testTransferNFT() public {
    //         string memory tokenUri = "https://example.com/nft";
    //         vm.prank(owner);
    //         basicNft.mintNft(tokenUri);

    //         vm.prank(owner);
    //         basicNft.transferFrom(owner, user1, 0);
    //         assertEq(basicNft.balanceOf(owner), 0);
    //         assertEq(basicNft.balanceOf(user1), 1);
    //     }

    //     function testFailTransferNFTWithUnauthorizedUser() public {
    //         string memory tokenUri = "https://example.com/nft";
    //         vm.prank(owner);
    //         basicNft.mintNft(tokenUri);

    //         vm.prank(user1);
    //         basicNft.transferFrom(owner, user2, 0);
    //     }

    //.................................................(3)

    // import {Test} from "forge-std/Test.sol";
    // import {DeployBasicNft} from "../script/DeployBasicNft.s.sol";
    // import {BasicNft} from "../src/BasicNft.sol";

    // contract BasicNftTest is Test {
    //     DeployBasicNft public deployer;
    //     BasicNft public basicNft;

    //     address public owner = address(this);

    //     string constant TEST_TOKEN_URI = "ipfs://example-token-uri";
    //     string constant TEST_TOKEN_URI_2 = "ipfs://example-token-uri-2";

    //     function setUp() public {
    //         deployer = new DeployBasicNft();
    //         basicNft = deployer.run();
    //     }

    //     function testDeployment() public {
    //         assertEq(basicNft.name(), "dogiee");
    //         assertEq(basicNft.symbol(), "dog");
    //     }

    //     function testMintNft() public {
    //         basicNft.mintNft(TEST_TOKEN_URI);
    //         assertEq(basicNft.tokenURI(0), TEST_TOKEN_URI);
    //         assertEq(basicNft.ownerOf(0), owner);
    //     }

    //     function testTokenUri() public {
    //         basicNft.mintNft(TEST_TOKEN_URI);
    //         string memory tokenUri = basicNft.tokenURI(0);
    //         assertEq(tokenUri, TEST_TOKEN_URI);
    //     }

    //     function testNonExistentTokenUri() public {
    //         vm.expectRevert("ERC721Metadata: URI query for nonexistent token");
    //         basicNft.tokenURI(999);
    //     }

    //     function testMultipleMints() public {
    //         basicNft.mintNft(TEST_TOKEN_URI);
    //         basicNft.mintNft(TEST_TOKEN_URI_2);

    //         assertEq(basicNft.tokenURI(0), TEST_TOKEN_URI);
    //         assertEq(basicNft.tokenURI(1), TEST_TOKEN_URI_2);

    //         assertEq(basicNft.ownerOf(0), owner);
    //         assertEq(basicNft.ownerOf(1), owner);
    //     }

    //     function testMintingIncreasesCounter() public {
    //         uint256 initialCounter = basicNft.s_tokenCounter();
    //         basicNft.mintNft(TEST_TOKEN_URI);
    //         uint256 newCounter = basicNft.s_tokenCounter();
    //         assertEq(newCounter, initialCounter + 1);
    //     }
}
