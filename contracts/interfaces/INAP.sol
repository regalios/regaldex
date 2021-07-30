// SPDX-License-Identifier: MIT
pragma solidity > 0.6.1 <= 0.8.6;

import "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import "./IStore.sol";
/*
*
*  Interface for NAPs : NON ALTERABLE PRODUCTS (maybe a future proposal?)
*  inherits some ERC721 properties
*
*
*/

interface INAP  {

    event NAPSaleInitiated(address indexed _fromOwner, address indexed _toClient, uint timestamp, uint price, uint256 fees);

    event NAPSaleSuccessful(address indexed _fromOwner, address indexed _toClient, uint timestamp, uint price, address txAddress);

    event NAPListingSuccessfull(address indexed _fromOwner, address indexed _productNap, uint timestamp, uint256 _listingFees);


    function loadProductMetas() external view returns(INAPMetas metas);

    function buyNap() external payable returns(address);

    function transferOwnershipOfNapTo(address to) external payable returns(address);

    function save(address storeId) external;

    function load() external returns(INAP product);

    function getApproved(address napId) external returns(bool);

    function listFees() external returns(uint256);

    function _beforeNapTransfer() external;

    function _afterSuccessTransfer() external;

    function _beforeDelivery() external;

}

interface INAPMetas {
// NAP METADATAS

    function uri() external view returns(string memory);

    function name() external view returns(string memory);

    // get all languages this product is having returns an id linked to an array of strings
    function langs() external view returns(uint256);

    function description() external view returns(string memory);

    function sku() external view returns(string memory);

    function productKey() external view returns(uint256);

    function antiAlterationCharacteristicsMetas() external view returns (uint256);

    function barCode() external view returns(uint256);

    function image() external view returns(string memory);

    function images() external view returns(string[] calldata);

    function options() external view returns(uint256[] calldata);

    function option(uint256 optionID) external;

    //get product owner / merchant / seller
    function owner() external view returns(address);

    function price() external view returns(uint);

    function priceCrypto(uint256 cryptoId) external view returns(uint);

    function saveCategory() external;

    function loadCategory() external returns(address category);
}


interface INAPSpecialPricing {

    function hasSpecial() external view returns(bool);

    function percentOff() external view returns(uint);

    function specialIsValid() external view returns (bool);

    function calculateSpecial() external returns (uint);

    function setSpecialPrice(uint) external;

    function specialPrice() external returns (uint);

}
