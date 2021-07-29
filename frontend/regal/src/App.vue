<template>
  <div id="app">
    <div id="nav">
      <router-link to="/">Home</router-link> |
      <router-link to="/about">About</router-link>
    </div>
     <vue-metamask 
            userMessage="msg" 
            @onComplete="onComplete"
        >
        </vue-metamask>
        <Balance :newBalance=balance :currentPrice=priceWei />
    <router-view/>
  </div>
</template>

<script>
    import VueMetamask from 'vue-metamask';
    import ABI from '../../../build/contracts/RegalERC20.json';
   import * as web3 from 'web3';
   import Balance from "./components/Balance";
    export default {
        components: {
            VueMetamask,
            Balance
        },
        data(){
            return {
                msg: "This is demo net work",
                contract: null,
                balance: 0,
                priceWei: 0.0000000000
            }
        },
        methods:{
            onComplete(data){
              
              const Web3 = new web3(data.web3.currentProvider);
              this.contract = new Web3.eth.Contract(ABI.abi, '0x9c457d952bde3ece97f71b3149206d45362a7c94');
             this.contract.methods.balanceOf(data.metaMaskAddress).call().then(bal => {
               this.balance = bal / 10000;
               console.log(this.balance);
             });
             this.contract.methods.getCurrentPrice().call().then(p => {
               console.log(p);
               let price = web3.utils.toBN(p).div(web3.utils.toBN(10000));
               this.priceWei = parseFloat(web3.utils.fromWei(price, 'ether'));
             });
              console.log();
                console.log('data:', data);
            }
        }
    }
</script>



<style lang="scss">
#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
}

#nav {
  padding: 30px;

  a {
    font-weight: bold;
    color: #2c3e50;

    &.router-link-exact-active {
      color: #42b983;
    }
  }
}
</style>
