<template>
    <div>MY BALANCE: {{formatPrice(newBalance)}} REGALS <br/> Value USD:${{formatPrice(valUsd())}} <br/> Price (ETH / RGL) : {{currentPrice}} ETHER</div>
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
              return (this.newBalance * (2311.67 * parseFloat(this.currentPrice)));}
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
