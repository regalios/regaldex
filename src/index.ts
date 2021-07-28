
import { ethers } from "ethers";
import regal from "../build/abi/RegalERC20.json";
const fs = require('fs');
const mnemonic = fs.readFileSync("./.secret").toString().trim();
const provider = new ethers.providers.JsonRpcProvider("https://ropsten.infura.io/v3/654adc0bbc0f4667a3a725b55d5e84ac");
const wallet = ethers.Wallet.fromMnemonic(mnemonic);
const key = wallet.privateKey;
const W = new ethers.Wallet(key, provider);

const RegalToken = new ethers.Contract("0x88d9dae342e4142e165a9b8caad9a44a6d4b7e80", regal, W);

const totalToken = async () => await RegalToken.totalSupply();
totalToken().then(total => {
  const t = new ethers.utils.BigNumber(total).toString();
  console.log(ethers.utils.formatUnits(t, 4) + " REGAL TOKENS");
});
