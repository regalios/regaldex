// SPDX-License-Identifier: MIT
pragma solidity > 0.6.1 <= 0.8.6;


import "../factories/TokenFactory.sol";
import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/utils/math/SafeMathUpgradeable.sol";

contract  NFTBox is OwnableUpgradeable {

    using SafeMathUpgradeable for uint256;

    struct OptionSettings {
        uint256 maxQuantity;

    }



    enum Class {
        UNIQUE,
        RARE,
        LIMITED,
        COMMON,
        HIDDEN,
        INVALID
    }

      mapping (uint256 => OptionSettings) internal optionToSettings;
  mapping (uint256 => uint256[]) public classToTokenIds;
  mapping (uint256 => bool) public classIsPreminted;

    modifier nftOnly(uint tokenSupply) {

        require(tokenSupply == 1);
        _;

    }

    function getNFTClass(uint tokenSupply) public pure returns(Class nftclass) {
        if(tokenSupply == 1) {
            return Class.UNIQUE;
        }
        if(tokenSupply <= 5) {
            return Class.RARE;
        }
        if(tokenSupply <= 10) {
            return Class.LIMITED;
        }
        if(tokenSupply > 10) {
            return Class.COMMON;
        }
        return Class.INVALID;

    }

    function setOptionSettings(
        uint256 _option,
        uint256 maxQuantity
    ) public onlyOwner {

    }

}