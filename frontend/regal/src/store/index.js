import Vue from 'vue'
import Vuex from 'vuex'
//import web3 from '../plugins/web3';

//import ABI from "../../../../build/contracts/RegalERC20.json";
import  Web3 from "web3";




Vue.use(Vuex)

/*const vm = new Vue({
  web3: function() {
    return {
    
        contract: RegalERC20
      
    }
  }
})*/

const provider = new Web3.providers.HttpProvider("https://ropsten.infura.io/v3/654adc0bbc0f4667a3a725b55d5e84ac");

const getWeb3 = function()  {
    const web3 = new Web3(provider);
    
    if(!web3) {
      return undefined;
    }

   return new Promise((resolve, reject) => {

    web3.eth.net.isListening().then(conn => {
      web3.eth.net.getId().then(id => {
        web3.eth.getAccounts().then(acc => {
          resolve({
            networkId: id,
            web3Instance: conn,
            accounts: acc
          })
        });
      });
    }).catch(err => reject(err));

   }); 
 
 
};

//Vue.use(VueWeb3, { web3: new Web3(Web3.givenProvider)});

//vm.use(VueWeb3, { web3: new Web3(Web3.givenProvider)});




export default new Vuex.Store({
  state: {
    web3: {
      impl: async () => { let a = await getWeb3(); if(a) {return a;}}
    },
    web3Copy: {}

  },
  mutations: {
    registerWeb3Instance(state, payload) {
        console.log('registerWeb3instance Mutation being executed')
 let result = payload
 let web3Copy = state.web3Copy;
 web3Copy.coinbase = "";
 web3Copy.networkId = result.networkId;
 web3Copy.balance = 0;
 web3Copy.isInjected = result.web3Instance.injectedWeb3
 web3Copy.web3Instance = result.web3Instance;
 state.web3Copy = web3Copy
    }
    },
  actions: {
    registerWeb3({commit})  {
      console.log('registerWeb3 Action being executed')
      this.state.web3.impl().then(result => {
        console.log('committing result to registerWeb3Instance mutation')
        
        commit('registerWeb3Instance', result)
      }).catch(e => {
        console.log('error in action registerWeb3', e)
      })

  }
  },
  modules: {
  }
})
