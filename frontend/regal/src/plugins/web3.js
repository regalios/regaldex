//Web3 connector
import * as Web3 from "web3";


//const provider = "https://ropsten.infura.io/v3/654adc0bbc0f4667a3a725b55d5e84ac";
//const provider = new Web3.providers.WebsocketProvider('wss://ropsten.infura.io/ws');

//Vue.use(VueWeb3, { web3: new Web3(Web3.givenProvider)});

export default Web3;

//export default new VueWeb3();

/*
 
      
let getWeb3 = new Promise((resolve, reject) => {

  
    if (typeof this.$web3 !== 'undefined') {
   
web3.eth.net.isListening().then((r) => {
    console.log("is connected = "+ r);
    resolve({
        injectedWeb3: r,
        web3: web3
      })
}).catch(err => reject(err));
      
      } else {
        // web3 = new Web3(new Web3.providers.HttpProvider(provider));
        reject(new Error('Unable to connect to Metamask'))
      }
    

}).then(result => {
    return new Promise(function (resolve, reject) {
      // Retrieve network ID

      result.web3.eth.net.getId((err, networkId) => {
        if (err) {
          // If we can't find a networkId keep result the same and reject the promise
          reject(new Error('Unable to retrieve network ID'))
        } else {
          // Assign the networkId property to our result and resolve promise
          //result = Object.assign({}, result, {networkId})
          result["network"] = networkId; 
          console.log(result);
          resolve(result)
        }
      })
    })
  })
  .then(result => {
    return new Promise(function (resolve) {
      // Retrieve coinbase
     
      result["coinbase"] = result.web3.eth.get_balance;
     //result.web3.eth.getCoinbase().then((cb) => {
       //  result["coinbase"] = cb;
         resolve(result);
     //}).catch(err => {
      //   reject(err);
     //})
  

    /*((err, coinbase) => {
        if (err) {
          reject(new Error('Unable to retrieve coinbase'))
        } else {
          result = Object.assign({}, result, { coinbase })
          resolve(result)
        }
      })*//*
    }
    )
  }).then(result => {
    return new Promise(function (resolve, reject) {
      // Retrieve balance for coinbase
      web3.eth.get_balance(result.coinbase, (err, balance) => {
        if (err) {
          reject(new Error('Unable to retrieve balance for address: ' + result.coinbase))
        } else {
          result = Object.assign({}, result, { balance })
          resolve(result)
        }
      })
    })
  });

  export default getWeb3;*/
