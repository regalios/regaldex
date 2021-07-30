<template>
  <v-app id="inspire">
    <v-system-bar app>
      <v-spacer></v-spacer>

      <v-icon>mdi-square</v-icon>

      <v-icon>mdi-circle</v-icon>

      <v-icon>mdi-triangle</v-icon>
    </v-system-bar>

    <v-app-bar
      app
      clipped-left
      flat
    >
      <v-avatar
        v-for="n in 1"
        :key="`avatar--${n}`"
        class="mr-3"
        color="grey lighten-1"
        size="36"
      >
      <Gravatar email="nicknailers69@gmail.com" alt="" size="50" v-on:click="showLeftMenu()" /> </v-avatar>

      <div class="mx-2">NICK</div>
      <v-spacer></v-spacer>
      <v-btn
        v-for="n in 4"
        :key="n"
        class="mr-3"
        color="grey lighten-1"
        depressed
        min-width="96"
        rounded
        small
      >
      </v-btn>

      <v-spacer></v-spacer>

    </v-app-bar>

    <v-navigation-drawer
      v-model="drawer"
      app
      class="pa-2"
      clipped
      width="300"
    >
      <div class="d-flex align-center pa-1">

        <v-btn rounded depressed color="grey lighten-3" class="grow"></v-btn>

        <v-btn
          min-width="0"
          depressed
          class="ml-3"
          color="grey lighten-3"
        ></v-btn>
      </div>

      <div class="d-flex align-center pa-1">
        <v-btn rounded depressed color="grey lighten-3" class="grow"></v-btn>

        <v-btn
          v-for="n in 1"
          :key="`btn--${n}`"
          class="ml-3"
          color="grey lighten-1"
          fab
          x-small
          depressed
        ></v-btn>
      </div>

      <div class="pa-1 mb-4">
        <v-text-field
          dense
          flat
          hide-details
          rounded
          solo-inverted
        ></v-text-field>
      </div>
    </v-navigation-drawer>

   
     <vue-metamask 
            userMessage="msg" 
            @onComplete="onComplete"
        >
        </vue-metamask>
       
        <v-main class="grey lighten-1">
         <v-container>
        <v-row>
          <v-col cols="10" xl="10" md="10" class="ma-auto">
                       <Balance :newBalance=balance :currentPrice=priceWei />

    <router-view/>
    </v-col>
        </v-row>
        </v-container>

  </v-main>
  </v-app>
</template>

<script>

    import VueMetamask from 'vue-metamask';
    import ABI from '../../../build/contracts/RegalERC20.json';
    import UserABI from '../../../build/contracts/UserRegistry.json';
   import * as web3 from 'web3';
   import Balance from "./components/Balance";
   import Gravatar from "vue-gravatar";
    export default {
        components: {
            VueMetamask,
            Balance,
            Gravatar
        },
        data(){
            return {
               drawer: null,
                msg: "This is demo net work",
                contract: null,
                userContract:null,
                needRegistration: false,
                balance: 0,
                priceWei: 0.0000000000,
                 links: [
        'Dashboard',
        'Messages',
        'Profile',
        'Charts',
        'Assets'
      ],
            }
        },
        methods:{
            onComplete(data){
              
              const Web3 = new web3(data.web3.currentProvider);
              this.$store.dispatch('initialize', Web3);
              this.$store.dispatch('registerData', data);
              this.contract = new Web3.eth.Contract(ABI.abi, '0x9c457d952bde3ece97f71b3149206d45362a7c94');
              this.userContract = new Web3.eth.Contract(UserABI.abi, "0x4939ef0867fE6A1c96959F997daF1150A3188484", {
                from: data.metaMaskAddress
              });

              this.$store.dispatch('registerContracts', {
                regal: this.contract,
                users: this.userContract,
                tokens: null
              });

              this.userContract.methods.exists().call().then((ex) => {
                console.log("user exists?" + ex);
                this.needRegistration = !!ex;
                if(ex !== false) {
                  this.userContract.methods.loadCurrentUser().call().then((us) => {
                    console.log(us);
                  });
                }
              })
             this.contract.methods.balanceOf(data.metaMaskAddress).call().then(bal => {
               this.balance = bal / 10000;
            
             });
             this.contract.methods.getCurrentPrice().call().then(p => {
             
               let price = web3.utils.toBN(p).div(web3.utils.toBN(10000));
               this.priceWei = parseFloat(web3.utils.fromWei(price, 'ether'));
             });
              console.log();
                console.log('data:', data);
            },
            showLeftMenu() {

              this.drawer = !this.drawer;

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
