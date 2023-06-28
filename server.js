require('dotenv').config()
let ejs = require('ejs');
const fs = require('fs');
const { exec } = require('child_process');
const { Web3 } = require('web3');

/*
Builds the file "Getting Started.json" that contains necessary data to start an opstack rollup
*/ 
function buildGettingStarted() {
  const template = fs.readFileSync('templates/getting-started.json', 'utf8');
  const renderedHTML = ejs.render(template);

  try {
    fs.writeFileSync('builds/getting-started.json', renderedHTML);
    console.log('getting-started build success');
  } catch (err) {
    console.log('getting-started.json build failed');
    console.error(err);
  };
}

/*
Injects the correct chainID in the hardhat config file
*/

function buildHardhatConfig() {
  const template = fs.readFileSync('templates/hardhat.config.ts', 'utf8');
  const renderedHTML = ejs.render(template);

  try {
    fs.writeFileSync('builds/hardhat.config.ts', renderedHTML);
    console.log('hardhat.config.ts build Success');
  } catch (err) {
    console.log('hardhat.config.ts buld Failure');
    console.error(err);
  };
}


async function getLatestFinalizedBlockNumber() {
  try {
    // Connect to an Ethereum node
    const web3 = new Web3('https://eth-mainnet.g.alchemy.com/v2/');

    // Get the latest finalized block number
    const block = await web3.eth.getBlockNumber('latest', true);

    
    console.log(parseInt(block, 16));

    if (block && block.finality) {
      const blockNumber = block.number;
      console.log('Latest Finalized Block Number:', parseInt(blockNumber, 16));
    } else {
      console.log('Failed to retrieve the latest finalized block.');
    }
  } catch (error) {
    console.error('Error:', error);
  }
}

function prepareOPStack() {
  buildGettingStarted();
  buildHardhatConfig();
  return (0);
}

prepareOPStack();

// Call the function to retrieve the latest finalized block number
//getLatestFinalizedBlockNumber();