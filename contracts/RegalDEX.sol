// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;


import "@openzeppelin/contracts-upgradeable/token/ERC1155/ERC1155Upgradeable.sol";
import "@openzeppelin/contracts-upgradeable/token/ERC1155/extensions/ERC1155BurnableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/token/ERC1155/extensions/IERC1155MetadataURIUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/token/ERC1155/extensions/ERC1155PausableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/access/AccessControlEnumerableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/utils/StringsUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/utils/math/SafeMathUpgradeable.sol";
import "./lib/Strings.sol";
import "./lib/ProxyRegistry.sol";
//import "./tokens/RegalERC20.sol";





contract RegalDEX is Initializable,  ERC1155Upgradeable, ERC1155BurnableUpgradeable, ERC1155PausableUpgradeable, AccessControlEnumerableUpgradeable {


using Strings for string;
using SafeMathUpgradeable for uint256;

//ERC20Upgradeable public exchangeToken;



address proxyRegistryAddress;
address tokenFactoryAddress;
address erc721TokensRegistry;
address userRegistryAddress;
address tokenRegistryAddress;

address storeContractAddress;
address regalV1Router;

function initialize(
  address _proxyRegistry,
  address _tokenFactory,
  address _erc721TokensRegistry,
  address _userRegistry,
  address _tokenRegistry
  //address _mainERC20Token
) public virtual initializer {

  proxyRegistryAddress = _proxyRegistry;
  tokenFactoryAddress = _tokenFactory;
  erc721TokensRegistry = _erc721TokensRegistry;
  userRegistryAddress = _userRegistry;
  tokenRegistryAddress = _tokenRegistry;
  //mainERC20Token = RegalERC20(_mainERC20Token);

}

function setStoreContractAddress(address sca) public payable returns(bool) {
  storeContractAddress = sca;
  return true;
}



function getUserRegistry() public virtual view returns(UserRegistry) {
  return UserRegistry(userRegistryAddress);
}

function getTokenRegistry() public virtual view returns(TokenRegistry) {
  return TokenRegistry(tokenRegistryAddress);
}

function getProxyRegistry() public virtual view returns(ProxyRegistry) {
  return ProxyRegistry(proxyRegistryAddress);
}

function getStoreContract() internal {}





  /* Cancelled / finalized orders, by hash. */
    mapping(bytes32 => bool) public cancelledOrFinalized;

    /* Orders verified by on-chain approval (alternative to ECDSA signatures so that smart contracts can place orders directly). */
    mapping(bytes32 => bool) public approvedOrders;

      /* For split fee orders, minimum required protocol maker fee, in basis points. Paid to owner (who can change it). */
    uint public minimumMakerProtocolFee = 0;

    /* For split fee orders, minimum required protocol taker fee, in basis points. Paid to owner (who can change it). */
    uint public minimumTakerProtocolFee = 0;

    address public protocolFeeRecipient;

    enum FeeMethod { 
      ProtocolFee, SplitFee }

/* Inverse basis point. */
    uint public constant INVERSE_BASIS_POINT = 10000;



struct Order {

  address exchange;
  address maker;
  address taker;
  uint makerRelayerFee;
        /* Taker relayer fee of the order, or maximum taker fee for a taker order. */
        uint takerRelayerFee;
        /* Maker protocol fee of the order, unused for taker order. */
        uint makerProtocolFee;
        /* Taker protocol fee of the order, or maximum taker fee for a taker order. */
        uint takerProtocolFee;
        /* Order fee recipient or zero address for taker order. */
        address feeRecipient;
        /* Fee method (protocol token or split fee). */
        FeeMethod feeMethod;
        address target;



}


 function _beforeTokenTransfer(
        address operator,
        address from,
        address to,
        uint256[] memory ids,
        uint256[] memory amounts,
        bytes memory data
    ) internal virtual override(ERC1155Upgradeable, ERC1155PausableUpgradeable) {

      super._beforeTokenTransfer(operator,from,to,ids,amounts,data);

    }

     /**
     * @dev See {IERC165-supportsInterface}.
     */
    function supportsInterface(bytes4 interfaceId) public view virtual override(AccessControlEnumerableUpgradeable, ERC1155Upgradeable) returns (bool) {
        return
            interfaceId == type(IERC1155Upgradeable).interfaceId ||
            interfaceId == type(IERC1155MetadataURIUpgradeable).interfaceId ||
            super.supportsInterface(interfaceId);
    }

  


}