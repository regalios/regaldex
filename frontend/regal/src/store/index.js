import Vue from 'vue'
import Vuex from 'vuex'
//import web3 from '../plugins/web3';

//import ABI from "../../../../build/contracts/RegalERC20.json";
//import  Web3 from "web3";




Vue.use(Vuex)

/*const vm = new Vue({
  web3: function() {
    return {
    
        contract: RegalERC20
      
    }
  }
})*/

//const provider = new Web3.providers.HttpProvider("https://ropsten.infura.io/v3/654adc0bbc0f4667a3a725b55d5e84ac");



//Vue.use(VueWeb3, { web3: new Web3(Web3.givenProvider)});

//vm.use(VueWeb3, { web3: new Web3(Web3.givenProvider)});




export default new Vuex.Store({
  state: {
   
    myEthAddress: "",
    metamaskConnected: false,
    web3: null,
    profile_info: {},
    contracts: {
      regal:null,
      tokens:null,
      users:null
    }


  },
  mutations: {
    
    setWeb3(state, payload) {
      state.web3 = payload;
    },
    setEthAddress(state, payload) {
      state.myEthAddress = payload;
    },
    setMetamaskConnected(state, payload) {
      state.metamaskConnected = payload;
    },
    setContracts(state, payload) {
      state.contracts = payload;
    },
    setProfileInfo(state, payload) {
      state.profile_info = payload;
    }

    },
  actions: {
    
    initialize: ({commit}, payload) => {
      commit('setWeb3', payload);
      if(typeof payload !== 'undefined') {
        commit('setMetamaskConnected', true);
      }
    },
    registerData: ({commit}, payload) => {
      commit('setEthAddress', payload.metaMaskAddress);
    },
    registerContracts: ({commit}, payload) => {
      commit('setContracts', payload);
    }
   
  },
  getters: {
    getWeb3(state) {
      return state.web3;
    },
    getMyAddress(state) {
      return state.myEthAddress;
    },
    getUserContract(state) {
      return state.contracts.users;
    },
    getTokenContract(state) {
      return state.contracts.tokens;
    },
    getRegalERC20Contract(state) {
      return state.contracts.regal;
    }

  },
  modules: {
  }
})
