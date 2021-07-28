// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

import "../../node_modules/@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import "../../node_modules/@openzeppelin/contracts-upgradeable/token/ERC20/extensions/ERC20PausableUpgradeable.sol";
import "../../node_modules/@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";


contract CashBack is Initializable, ERC20PausableUpgradeable {




    bool private enableCashback;
    
    // cashback rate here upgradeable by owner only
    uint cbRate;
    uint _cashbackValueToSend;

    event EmitCashback(uint txValue, address to, uint256 cashbackValue);
    event CashbackInitialized(bool success);

    function __cashback_init(bool enable, uint rate) public virtual initializer {
        enableCashback = enable;
        cbRate = rate;

     
            __enableCashback();
            __setCbRate(rate);

            emit CashbackInitialized(true);
        
     

    }


    function __enableCashback() public  {
        enableCashback = true;
    }

    function __disableCashback() public {
        enableCashback = false;
    }

    function __setCbRate(uint rate) internal  {
        
        //require(rate > 0 && rate < 40);
        cbRate = rate;
    }

    function __calculateRate(uint amount) public virtual payable returns(uint) {

       // require(cbRate > 0 && enableCashback != false);

        uint percent = (cbRate / 100);
        uint txValue = amount;
        _cashbackValueToSend = (percent * txValue);
       //  emit EmitCashback(_cashbackValueToSend, to, _cashbackValueToSend);
        return _cashbackValueToSend ** 10 * decimals();
       
    }

    function getCashbackValue(uint amount) public virtual payable returns(uint) {
         __calculateRate(amount);
        return _cashbackValueToSend;
    }



}