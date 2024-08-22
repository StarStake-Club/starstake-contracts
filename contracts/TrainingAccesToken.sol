// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/utils/StringsUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/token/ERC721/extensions/ERC721BurnableUpgradeable.sol";

contract TrainingAccessToken is ERC721BurnableUpgradeable, OwnableUpgradeable {

    uint256 public minted;
    bool public isMintActive;
    string private _baseTokenURI;

    modifier whenMintActive() {
        require(isMintActive, "Minting not active");
        _;
    }

    function initialize() external initializer {
        __Ownable_init();
        __ERC721_init("Test", "Test");
        __ERC721Burnable_init();
    }

    /**
     * @dev Mints access training tokens to an address
     * @param _to          Address of the future owner of the token
     * @param _quantity    Amount of tokens to mint
     */
    function mint(address _to, uint256 _quantity) public whenMintActive {
        for (uint256 i = 0; i < _quantity; i++) {
            minted++;
            _mint(_to, minted);
        }
    }

    /**
     * Override isApprovedForAll for whitelisted accounts to enable burn on redemption.
     */
    function isApprovedForAll(address _owner, address _operator)
        public
        view
        override
        returns (bool isOperator)
    {

        return ERC721Upgradeable.isApprovedForAll(_owner, _operator);
    }

    function _baseURI() internal view virtual override returns (string memory) {
        return _baseTokenURI;
    }

    function setBaseURI(string calldata baseURI) external onlyOwner {
        _baseTokenURI = baseURI;
    }

    function exists(uint256 _tokenId) external view returns (bool) {
        return _exists(_tokenId);
    }

    //////
    /////Owner Functions
    /////
    function startMinting() external onlyOwner {
        isMintActive = true;
    }

    function stopMinting() external onlyOwner whenMintActive {
        isMintActive = false;
    }
}
