// SPDX-License-Identifier: MIT

pragma solidity ^0.8.2;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract ABCCoin is ERC20, Ownable {
    constructor() ERC20("XO2", "XO2C") {}

    function mintTokens(address _account, uint256 _amount) public onlyOwner {
        _mint(_account, _amount);
    }

    function burnTokens(address _account, uint256 _amount) public onlyOwner {
        _burn(_account, _amount);
    }
}
