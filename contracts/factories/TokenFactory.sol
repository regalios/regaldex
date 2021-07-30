// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

import "@openzeppelin/contracts/token/ERC20/presets/ERC20PresetFixedSupply.sol";
import "../lib/Strings.sol";

enum TokenType {
    ERC20,
    ERC721,
    ERC1155,
    NAP
}

contract TokenFactory {

    TokenType private _tokenType;
    ERC20 public erc20Token;
    using Strings for string;
    ERC20TokenFactoryParams erc20TokenParams;

    constructor(TokenType tokenType) {
        if(tokenType == TokenType.ERC20) {



        }
    }

    function executeERC20TokenFactory(string memory name, string memory symbol,  uint256 initialSupply, address owner) public {

        new ERC20TokenFactory(name, symbol, initialSupply, owner);

    }
   
    
    


}

 struct ERC20TokenFactoryParams {

     string name;
     string symbol;
     uint256 initialSupply;
     address owner;

}

contract  ERC20TokenFactory {

ERC20 erc20Token;

     constructor(string memory name,
        string memory symbol,
        uint256 initialSupply,
        address owner) {

      
            createERC20Token(name, symbol, initialSupply, owner);
        

    }

function createERC20Token(  string memory name,
        string memory symbol,
        uint256 initialSupply,
        address owner) public payable  returns (ERC20){

        erc20Token = new ERC20PresetFixedSupply(name, symbol, initialSupply, owner);
        

        return erc20Token;

    }
}