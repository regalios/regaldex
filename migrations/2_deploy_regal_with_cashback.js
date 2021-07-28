const { deployProxy } = require('@openzeppelin/truffle-upgrades');
const { deploy } = require('@openzeppelin/truffle-upgrades/dist/utils');
const Web3 = require("web3");

const Box = artifacts.require('RegalERC20');
const DEX = artifacts.require('RegalDEX');

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

module.exports = async function (Deployer) {
   
   const instance = await deployProxy(Box, [], {  deployer: Deployer,
        unsafeAllow: ["external-library-linking","state-variable-immutable"]});


        console.log('Deployed', instance.address);
      const addr = Web3.utils.toChecksumAddress(instance.address);
       const dex = await deployProxy(DEX, [addr], {  deployer: Deployer,
        unsafeAllow: ["external-library-linking","state-variable-immutable"]});

                console.log(dex.address);
            
    


};