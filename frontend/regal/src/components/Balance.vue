<template>

    <v-card elevation="10" class="pa-10" style="margin-top:90px;" dark>
        <v-card-header>
          
          <v-card-header-text>
              
        <v-card-title class="mb-2">  <v-card-avatar>
                <v-avatar size="55" color="red darken-4" class="mr-2 pa-0">
                    <v-img src="/logo.png" alt="" size="50" />
                </v-avatar>
            </v-card-avatar><h1>REGAL EMPIRE</h1></v-card-title>
        <v-card-subtitle><p>
            Blockchain: <strong>Ethereum</strong> | Type: <strong>ERC-20</strong> | Symbol: <strong>REGAL</strong> | Price (ETH / REGAL) : <strong> {{currentPrice}} ETHER </strong> (${{priceUSD()}}) | Total Supply (cap): <strong>1,000,000,000 REGALS</strong> 
            </p></v-card-subtitle></v-card-header-text></v-card-header>
            <v-divider />
        <v-card-text><div><h2><strong>I OWN:</strong> <span style="color:#ffffff">{{formatPrice(newBalance)}}</span> <v-avatar size="25" color="grey darken-4" class="mr-2">
                    <v-img src="/logo.png" alt="" size="50" />
                </v-avatar>REGALS</h2>  (USD:${{formatPrice(valUsd())}}) <br/> </div>
        </v-card-text>
        <v-footer>
            <v-btn class="mr-2">Buy / Sell REGAL</v-btn>
            <v-btn class="mr-2">Exchange REGAL</v-btn>
             <v-btn class="mr-2">Stake REGAL</v-btn>
              <v-btn class="mr-2">View charts</v-btn>
            </v-footer></v-card>
  
  
</template>


<script>

export default ({
   name:"Balance",
   props: {
       newBalance: Number,
       currentPrice: (Number || String)
   },
   data()  {
    return {
          valUsd: () => {
              return (this.newBalance * (2311.67 * parseFloat(this.currentPrice)));},
              priceUSD: () => {
                 return parseFloat(2311.67) * parseFloat(this.currentPrice)
              }
    }
   },
   methods: {
    formatPrice(value) {
        let val = (value/1).toFixed(2);
        return val.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",")
    }
}

})
</script>
