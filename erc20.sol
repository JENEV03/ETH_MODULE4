// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

contract JeneviveDegenGamingToken is ERC20, Ownable {
    using Strings for uint256;

    mapping(address => string) public uniqueIds;
    mapping(string => bool) private _usedIds;

    event UniqueIdSet(address indexed user, string uniqueId);

    constructor() ERC20("JeneviveDegenGamingToken", "JDGT") Ownable(msg.sender) {}

    function mintTokens(address _to, uint256 _amount) public onlyOwner {
        _mint(_to, _amount);
    }

    function transferTokens(address _to, uint256 _amount) public {
        require(balanceOf(msg.sender) >= _amount, "Transfer failed: Insufficient balance");
        _transfer(msg.sender, _to, _amount);
    }

    function setUniqueId(string memory _uniqueId) public {
        require(!_usedIds[_uniqueId], "Unique ID already used");
        _usedIds[_uniqueId] = true;
        uniqueIds[msg.sender] = _uniqueId;
        emit UniqueIdSet(msg.sender, _uniqueId);
    }

    function redeemItem(uint256 _itemId) public {
        require(balanceOf(msg.sender) >= _itemId, "Redeem failed: Insufficient balance");
        _burn(msg.sender, _itemId);
        // Implement item redemption logic here
    }

    function burnTokens(uint256 _amount) public {
        require(balanceOf(msg.sender) >= _amount, "Burn failed: Insufficient balance");
        _burn(msg.sender, _amount);
    }

    function getBalance() external view returns (uint256) {
        return balanceOf(msg.sender);
    }

    function decimals() override public pure returns (uint8) {
        return 0;
    }
}