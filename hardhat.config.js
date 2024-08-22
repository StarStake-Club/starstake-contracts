require('hardhat-abi-exporter')
require('dotenv').config()
require('@openzeppelin/hardhat-upgrades');

module.exports = {
  solidity: {
    version: "0.8.20",
    settings: {
      optimizer: {
        enabled: true,
        runs: 200
      },
      evmVersion: "paris"
    }
  },

  abiExporter: {
    path: './abis',
    clear: true,
    flat: true
  },

  networks: {
  	// polygon : {
    //   chainId: 137,
    //   url: process.env.POLYGON_HTTP,
    //   accounts: [`0x${process.env.PRIVATE_KEY_POLYGON}`],
    //   gasPrice: 300000000000
    // },
  }

  // etherscan: {
  //   apiKey: process.env.ETHERSCAN_API_KEY
  // }
};
