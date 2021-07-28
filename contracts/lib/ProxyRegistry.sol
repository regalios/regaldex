// SPDX-License-Identifier: MIT
pragma solidity > 0.6.1 <= 0.8.6; 

import "./Assets.sol";

contract ProxyRegistry {


    struct Registry {
        address payable[] users;

    }



}

contract TokenRegistry {

    address payable owner;
    
    mapping (uint256 => tokenRegistryElem) tokenRegistry;

    struct tokenRegistryElem {
        address token;
        uint tokenVersion;
        uint balance;
        bool isMintable;
        bool isSaleable;
        bool isAvailable;
        bool isAuction;
        uint AssetType;
        address payable[] issuers;
        address payable[] owners;
        string uri;
        uint deadline;
        uint startdate;

    }

    tokenRegistryElem[] elements;

    function add(
        uint assetType,
        uint256 tokenid,
        address _tokenAddress,
        uint _version,
        address payable issuer,
        string memory uri
    ) public {

       tokenRegistry[tokenid].token = _tokenAddress;
       tokenRegistry[tokenid].AssetType = assetType;
       tokenRegistry[tokenid].tokenVersion = _version;
       tokenRegistry[tokenid].issuers.push(issuer);
       tokenRegistry[tokenid].uri = uri;
       
    }

    modifier onlyIssuer(address _sender,
    uint256 tokenid,
    uint256 issuerid) {
        require(_sender == tokenRegistry[tokenid].issuers[issuerid]);
        _;
    }

    modifier isMintable(uint256 tokenid) {
        require(tokenRegistry[tokenid].isMintable);
        _;
    }

    modifier onlyAssetOwner(address _sender, uint256 tokenid, uint256 ownerid) {
        require(_sender == tokenRegistry[tokenid].owners[ownerid]);
        _;
    }

    constructor() {

        owner = payable(msg.sender);
        
    }


}