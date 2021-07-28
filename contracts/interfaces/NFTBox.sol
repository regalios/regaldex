// SPDX-License-Identifier: MIT
pragma solidity > 0.6.1 <= 0.8.6;

interface INFTbox {


function name() external view returns (string memory);

function symbol() external view returns (string memory);

function canMint(uint256 _amount) external view returns(bool);

function uri(uint256 _tokenID) external view returns (string memory);

function supportsFactoryInterface() external view returns (bool);

function factorySchemaName() external view returns (string memory);

function open(uint256 _boxId, address _boxAddress) external;

function setClassForTokenId(uint256 _tokenID, uint256 _classID) external;

function resetClass(uint256 _classID) external;

function withdraw() external;

  function safeTransferFrom(address _from, address _to, uint256 _boxId, uint256 _amount, bytes calldata _data) external;

  function balanceOf(address _owner, uint256 _boxId) external view returns (uint256);

  function isApprovedForAll(address _owner, address _operator) external view returns (bool);

}