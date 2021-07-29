const { deployProxy } = require('@openzeppelin/truffle-upgrades');
const { deploy } = require('@openzeppelin/truffle-upgrades/dist/utils');
const Web3 = require("web3");

const Box = artifacts.require('RegalERC20');
const DEX = artifacts.require('RegalDEX');
const PR = artifacts.require('ProxyRegistry');
//const TF = artifacts.require('TokenRegistry');
//const UF = artifacts.require('UserRegistry')

/*
async function deployProxy(
    Contract: ContractClass,
    args: unknown[] = [],
    opts: {
        deployer: Deployer,
        initializer: string | false,
        unsafeAllow: ValidationError[],
        kind: 'uups'',
    } = {},
): Promise<ContractInstance>*/

const web3 = new Web3();

module.exports = async function (Deployer) {
   /*
const UR = await Deployer.deploy(UF);
const TR = await Deployer.deploy(TF);
*/
const add = web3.utils.toChecksumAddress("0x14d6d9ac17C6934a95e4fCE19c93cc91f8147986");
const add2 = web3.utils.toChecksumAddress("0x4939ef0867fE6A1c96959F997daF1150A3188484");
const ProxyRegistryInstance = await Deployer.deploy(PR,add,add2);


   const instance = await deployProxy(Box, [], {  deployer: Deployer,
        unsafeAllow: ["external-library-linking","state-variable-immutable"]});


        console.log('Deployed', instance.address);
      const addr = web3.utils.toChecksumAddress(instance.address);
       const dex = await deployProxy(DEX, [addr], {  deployer: Deployer,
        unsafeAllow: ["external-library-linking","state-variable-immutable"]});

                console.log(dex.address);

        
            
    


};