// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

import "../../node_modules/@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import "../../node_modules/@openzeppelin/contracts-upgradeable/token/ERC20/utils/SafeERC20Upgradeable.sol";
import "../../node_modules/@openzeppelin/contracts-upgradeable/token/ERC20/ERC20Upgradeable.sol";
import "../../node_modules/@openzeppelin/contracts-upgradeable/token/ERC20/extensions/ERC20PausableUpgradeable.sol";
import "../../node_modules/@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import "./Cashback.sol";
import "../../node_modules/@openzeppelin/contracts-upgradeable/utils/math/SafeMathUpgradeable.sol";

contract RegalERC20 is Initializable, ERC20PausableUpgradeable, CashBack {

using SafeMathUpgradeable for uint256;


    uint256 constant private MAX_UINT256 = 2**256 - 1;
    mapping (address => uint256) public balances;
    mapping (address => mapping (address => uint256)) public allowed;
    uint256 public initialSupply;
    uint256 constant private startPriceETH = 0.0001 ether;
    uint256 private startPriceWEI;
    uint8 public _decimals;
    uint256 public _totalSupply;
    address _owner;
  
  /*
    string public name = "Regal";                  
    uint8 public decimals = 4;                
    string public symbol = "RGX";                
    uint public _initialAmount = 1e13;
*/

  


    function initialize() public virtual initializer {
         startPriceWEI = startPriceETH * 10 ** decimals();
        __cashback_init(true, 10);
        __init_Regal_ERC20("REGAL EMPIRE", "REGAL", 1000000000 * 10 ** decimals(), msg.sender, 4);
 

      
    }

    function __init_Regal_ERC20(
        string memory name,
        string memory symbol,
        uint256 _initialSupply,
        address owner,
        uint8 decimal
    ) internal initializer {
        _owner = owner;
        _decimals = decimal;
        _totalSupply = 1000000000 * 10 ** decimals();
         initialSupply = _initialSupply;
       __ERC20_init_unchained(name, symbol);
       
        
        _mint(owner, initialSupply);
       balances[owner] += initialSupply;
    


    }

function decimals() public view virtual override returns (uint8) {
  return 4;
}


function getCashback(uint val) public virtual returns (uint) {
     uint cbVal = getCashbackValue(val);
     
     return cbVal * 10 ** decimals();
}

function _mintCashback() public virtual payable returns(bool) {
    _mint(msg.sender, getCashback(msg.value));
    return true;
}

function _buyToken(address payable spender, uint256 amount) public virtual payable returns(bool) {

    require(amount > 0);

    transferFrom(_owner, spender, amount * getCurrentPrice() + getCashback(amount));

    return true;

}


    function transfer(address _to, uint256 _value) public override returns (bool success) {
        require(balances[msg.sender] >= _value, "token balance is lower than the value requested");
        balances[msg.sender] -= _value;
        balances[_to] += _value;
        emit Transfer(msg.sender, _to, _value); //solhint-disable-line indent, no-unused-vars
        return true;
    }

    function transferFrom(address _from, address _to, uint256 _value) public override returns (bool success) {
        uint256 _allowance = allowed[_from][msg.sender];
        require(balances[_from] >= _value && _allowance >= _value, "token balance or allowance is lower than amount requested");
        balances[_to] += _value;
        balances[_from] -= _value;
        if (_allowance < MAX_UINT256) {
            allowed[_from][msg.sender] -= _value;
        }
        emit Transfer(_from, _to, _value); //solhint-disable-line indent, no-unused-vars
        return true;
    }

    function balanceOf(address __owner) public override view returns (uint256 balance) {
        return balances[__owner];
    }

    function getCurrentPrice() public view returns (uint256 amount) {
        return startPriceWEI;
    }

    function approve(address _spender, uint256 _value) public override returns (bool success) {
        allowed[msg.sender][_spender] = _value;
        emit Approval(msg.sender, _spender, _value); //solhint-disable-line indent, no-unused-vars
        return true;
    }

    function allowance(address __owner, address _spender) public override view returns (uint256 remaining) {
        return allowed[__owner][_spender];
    }

   function _beforeTokenTransfer(
        address from,
        address to,
        uint256 amount
    ) internal virtual override(ERC20PausableUpgradeable) {
        
        //uint reqAmt = (amount * startPriceWEI);
        //require(amount == reqAmt);


        super._beforeTokenTransfer(from, to, amount);

   
       
    }
}

