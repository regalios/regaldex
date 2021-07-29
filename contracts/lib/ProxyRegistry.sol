// SPDX-License-Identifier: MIT
pragma solidity > 0.6.1 <= 0.8.6; 

import "./Assets.sol";
import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";

contract ProxyRegistry  {


    struct Registry {
        address tokenRegistry;
        address userRegistry;
    }

  
    Registry _proxyRegistry;
    TokenRegistry private loadedTrInstance;
    UserRegistry private loadedUrInstance;

   constructor(address trAddr, address urAddr) {

        loadedTrInstance = TokenRegistry(trAddr);
        loadedUrInstance = UserRegistry(urAddr);
        _proxyRegistry.tokenRegistry = loadedTrInstance._getRegistryAddress();
        _proxyRegistry.userRegistry = loadedUrInstance._getRegistryAddress();


    }

    function loadUsers() external view returns(UserRegistry) {
        return loadedUrInstance;
    }

   function loadTokens() external view returns(TokenRegistry) {
        return loadedTrInstance;
    }

}


contract UserRegistry {

    mapping (address => userRegistryElem) userRegistry;

    struct userRegistryElem {
        address user;
        string profileUri;
        string name;
        string avatarUri;
        string metadataUri;
        bool isOnline;
        bool needValidation;
        string signature;
        uint dateCreated;
    }

    address contractAddress = address(0);

    function _getRegistryAddress() external view returns(address) {
        return contractAddress;
    }

    constructor() {
       
    }

    function registerUser(string memory name,
    string memory avatarUri,
    string memory metadataUri,
    string memory profileUri) onlyNewUser public virtual  {

        userRegistry[msg.sender].user = msg.sender;
        userRegistry[msg.sender].profileUri = profileUri;
        userRegistry[msg.sender].name = name;
        userRegistry[msg.sender].avatarUri = avatarUri;
        userRegistry[msg.sender].metadataUri = metadataUri;
        userRegistry[msg.sender].isOnline = false;
        userRegistry[msg.sender].dateCreated = block.timestamp;
        userRegistry[msg.sender].needValidation = true;
        userRegistry[msg.sender].signature = "";

    }

    function loadCurrentUser() public virtual returns(userRegistryElem memory user) {

        require(!!exists());
        userRegistry[msg.sender].isOnline = true;
        return userRegistry[msg.sender];

    }

    function loadOtherUser(address userId) public virtual  returns(userRegistryElem memory user) {
        require(!!exists());
        userRegistry[userId].isOnline = checkOnlineStatus(userId);
        return userRegistry[userId];
    }

    function checkOnlineStatus(address userId) public virtual returns(bool) {
        if(!userRegistry[userId].isOnline) {
        return false;
        }
        return true;
    }



    function exists() public view returns(bool) {

        if(userRegistry[msg.sender].user == msg.sender) {
            return true;
        }
        return false;

    }

    modifier onlyNewUser() {
        require(!exists());
        _;
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

  address contractAddress = address(0);

    function _getRegistryAddress() external view returns(address) {
        return contractAddress;
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