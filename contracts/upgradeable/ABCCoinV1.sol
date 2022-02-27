// SPDX-License-Identifier: MIT

pragma solidity ^0.8.2;

import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import "@openzeppelin/contracts-upgradeable/token/ERC20/ERC20Upgradeable.sol";
import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";

contract ABCCoinV1 is Initializable, ERC20Upgradeable, OwnableUpgradeable {
    /**
     * @notice Initializer
     */
    function initialize() public initializer {
        __ERC20_init("ABC", "ABC");
        __Ownable_init();
    }

    function mintTokens(address _account, uint256 _amount) public onlyOwner {
        _mint(_account, _amount);
    }

    function burnTokens(address _account, uint256 _amount) public onlyOwner {
        _burn(_account, _amount);
    }

    function balanceOfUser(address _account) public view returns (uint256) {
        return balanceOf(_account);
    }
}
