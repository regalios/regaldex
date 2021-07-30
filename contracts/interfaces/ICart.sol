
// SPDX-License-Identifier: MIT
pragma solidity > 0.6.1 <= 0.8.6;

interface ICart {

    function cartId() external returns(address cartId);
    function cartItems() external returns(address[] calldata);
    function addItem(address itemId) external returns(bool);
    function removeItem(address itemId) external returns(bool);
    function cartTotal() external returns(uint256);
    function cartTotalCrypto(uint256 cryptoId) external returns(uint256);
    function clear() external;
    function save() external returns(address);
    function load(address cartId) external returns(ICart cart);

}