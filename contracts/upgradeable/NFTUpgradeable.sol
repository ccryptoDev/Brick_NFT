// SPDX-License-Identifier: MIT

pragma solidity ^0.8.2;

import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import "@openzeppelin/contracts-upgradeable/token/ERC721/ERC721Upgradeable.sol";
import "@openzeppelin/contracts-upgradeable/token/ERC721/extensions/ERC721EnumerableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/token/ERC721/extensions/ERC721URIStorageUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/token/ERC20/IERC20Upgradeable.sol";
import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";

// import "./ABCCoinUpgradeable.sol";

contract NFTUpgradeable is
    Initializable,
    ERC721URIStorageUpgradeable,
    ERC721EnumerableUpgradeable,
    OwnableUpgradeable
{
    IERC20Upgradeable ABCCoin;
    address receiverAddr;
    string private _baseURIextended;
    string public baseExtension = ".json";
    uint256 lastTokenId;
    uint256 totalABCAmount;
    event MintFinished(address to, uint256 _tokenId);

    /**
     * @notice Initializer
     */
    function initialize(address _receiverAddr) public initializer {
        __ERC721_init("Brick", "Brick");
        receiverAddr = _receiverAddr;
    }

    /**
     * @notice A method to set baseURI with new one.
     * @param baseURI_ new baseURI.
     */
    function setBaseURI(string memory baseURI_) external onlyOwner {
        _baseURIextended = baseURI_;
    }

    /**
     * @notice An overrride function to get the baseURI.
     */
    function _baseURI() internal view virtual override returns (string memory) {
        return _baseURIextended;
    }

    /**
     * @notice tokenURI overrride function.
     */
    function tokenURI(uint256 tokenId)
        public
        view
        override(ERC721Upgradeable, ERC721URIStorageUpgradeable)
        returns (string memory)
    {
        require(
            _exists(tokenId),
            "ERC721URIStorage: URI query for nonexistent token"
        );
        string memory __baseURI;
        __baseURI = _baseURI();
        // Concatenate the unrevealBaseURI and tokenId (via abi.encodePacked).
        return
            bytes(__baseURI).length > 0
                ? string(abi.encodePacked(__baseURI, tokenId, baseExtension))
                : "";
    }

    /**
     * @notice _burn internal overrride function.
     */
    function _burn(uint256 tokenId)
        internal
        override(ERC721Upgradeable, ERC721URIStorageUpgradeable)
    {
        super._burn(tokenId);
    }

    /**
     * @notice _beforeTokenTransfer internal overrride function.
     */
    function _beforeTokenTransfer(
        address from,
        address to,
        uint256 tokenId
    ) internal override(ERC721Upgradeable, ERC721EnumerableUpgradeable) {
        super._beforeTokenTransfer(from, to, tokenId);
    }

    /**
     * @notice supportsInterface overrride function.
     */
    function supportsInterface(bytes4 interfaceId)
        public
        view
        override(ERC721Upgradeable, ERC721EnumerableUpgradeable)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }

    /**
     * @notice A method to allow for user to mint after pay ABC.
     * @param _to the address of receiver to get minted.
     * @param _tokenAmount the amount of ABC.
     */
    function mintNFT(address _to, uint256 _tokenAmount) public {
        require(
            ABCCoin.transferFrom(msg.sender, receiverAddr, _tokenAmount),
            "ABC token transaction failed!"
        );

        uint256 _id = nextTokenId();
        _safeMint(_to, _id, "");
        incrementTokenId();

        // accumulate ABC amount
        totalABCAmount += _tokenAmount;

        emit MintFinished(_to, _id);
    }

    /**
     * @return The list of all tokens enumerated.
     */
    function getAllTokensList() public view returns (uint256[] memory) {
        uint256[] memory _tokensList = new uint256[](
            ERC721EnumerableUpgradeable.totalSupply()
        );
        uint256 i;

        for (i = 0; i < ERC721EnumerableUpgradeable.totalSupply(); i++) {
            _tokensList[i] = ERC721EnumerableUpgradeable.tokenByIndex(i);
        }
        return (_tokensList);
    }

    /**
     * @notice A method to get the list of all tokens owned by any user.
     * @param _owner the owner address.
     * @return The list of tokens owned by any user.
     */
    function getTokensListOwnedByUser(address _owner)
        public
        view
        returns (uint256[] memory)
    {
        uint256[] memory _tokensOfOwner = new uint256[](
            ERC721Upgradeable.balanceOf(_owner)
        );
        uint256 i;

        for (i = 0; i < ERC721Upgradeable.balanceOf(_owner); i++) {
            _tokensOfOwner[i] = ERC721EnumerableUpgradeable.tokenOfOwnerByIndex(
                _owner,
                i
            );
        }
        return (_tokensOfOwner);
    }

    function nextTokenId() public view returns (uint256) {
        return lastTokenId + 1;
    }

    function incrementTokenId() internal {
        lastTokenId++;
    }

    /*
    *  @notice get totalABCAmount 
    */
    function getTotalABCAmount() public view returns (uint256) {
        return totalABCAmount;
    }

    /**
     * @notice get the Last token id.
     */
    function getLastTokenId() public view returns (uint256) {
        return lastTokenId;
    }

    function setReceiverAddr(address _receiverAddr) public {
        receiverAddr = _receiverAddr;
    }

    function getReceiverAddr() public view returns (address) {
        return receiverAddr;
    }
}
