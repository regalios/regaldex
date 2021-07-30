// SPDX-License-Identifier: MIT
pragma solidity > 0.6.1 <= 0.8.6;

import "./INAP.sol";

interface IStore {

    function name() external view returns(string memory);
    function urlKey() external view returns(string memory);
    function langs() external view returns (string[] memory);
    function sales() external view returns (address[] memory);
    function totalSales() external view returns(uint256);
    function description() external view returns(string memory);
    function numProducts() external view returns(uint);
    function categories() external view returns(INAPCategory[] memory);
    function metas() external view returns(string memory);
    function storeId() external view returns(address);
    function owner() external view returns(address);
    function _delegateAccess(address) external;
    function _isVerified() external view returns(bool);
    function create(IFormFieldKey[] calldata) external view returns(address);
    function whosOnline() external view returns(address[] memory);
    function _signNap(address napid) external view returns(bytes32);
    function _verifyNapSignature(address napid, bytes32 signature) external;
    function _whiteList(address _target) external;
    function _ban(address _target) external;
    function _isBanned(address _source) external view returns(bool);
    function _isWhitelisted(address _source) external view returns(bool);
    function _merchants() external view returns(address[] memory);
    function _search(string[] calldata) external view returns(string[] memory);
    function _cache(string calldata key, string[] memory results) external;
    function _fromCache(string calldata key) external view returns(string[] memory);
    function hash() external view returns(bytes32);

}



interface INAPCategory {

    event CategoryCreated(address indexed _by, string _name, address indexed _categoryId, uint timestamp);
    event ProductAddedToCategory(address indexed _by, address indexed productid, address indexed categoryid, string productName, string CategoryName);

    function name() external view returns(string memory);

    function urlKey() external view returns(string memory);

    function children() external view returns(address[] memory);

    function parents() external view returns(address[] memory);

    function catId() external view returns(address catid);

    function addProduct(INAP) external view returns(bool);

    function isNavigation() external view returns (bool);

    function create(IFormFieldKey[] calldata) external returns (bool, address);

    function hash() external returns(bytes32);

}

interface IFormFieldKey {
    function key(string calldata id) external view returns(string memory);
    function setKey(string calldata id, string calldata val) external returns(bool);

}