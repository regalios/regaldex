const os = require('os');
const HDWalletProvider = require('@truffle/hdwallet-provider');
let apiKey;
const infuraURL = "https://ropsten.infura.io/v3/654adc0bbc0f4667a3a725b55d5e84ac";
const fs = require('fs');
const mnemonic = fs.readFileSync(".secret").toString().trim();




module.exports = {



  networks: {

    ropsten: {
      provider: () => new HDWalletProvider(mnemonic, infuraURL),
      gas: 5000000,
      gasPrice: 20000000000,
      network_id: 3,
      skipDryRun: true,
      timeoutBlocks: 500000,
      networkCheckTimeout: 500000
    },

    ganache: {
      host: "127.0.0.1",
      port: 7545,
      gas: 5000000,
      gasPrice: 20000000000,
      network_id: 5777,
      skipDryRun: true,
      timeoutBlocks: 500000,
      networkCheckTimeout: 500000
    }

  },

  compilers: {
    solc: {
      version: "0.8.2",
      settings: {
        optimizer: {
          enabled : true,
          runs: 200
        }
        //evmVersion: "istanbul"
      }
    }
  }
}
