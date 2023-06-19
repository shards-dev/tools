require('dotenv').config()
let ejs = require('ejs');
const fs = require('fs');
const { exec } = require('child_process');

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
  const template = fs.readFileSync('templates/hardhat.config.js', 'utf8');
  const renderedHTML = ejs.render(template);

  try {
    fs.writeFileSync('builds/hardhat.config.js', renderedHTML);
    console.log('hardhat.config.js build Success');
  } catch (err) {
    console.log('hardhat.config.js buld Failure');
    console.error(err);
  };
}

function prepareOpstack() {
  buildGettingStarted();
  buildHardhatConfig();
  return (0);
}

prepareOpstack();