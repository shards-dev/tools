require('dotenv').config()
let ejs = require('ejs');
const fs = require('fs');
const { exec } = require('child_process');


// build getting-started.json
const template = fs.readFileSync('templates/getting-started.json', 'utf8');
const renderedHTML = ejs.render(template);

try {
    fs.writeFileSync('builds/getting-started.json', renderedHTML);
    console.log('Env write Success');
  } catch (err) {
    console.log('Env write Failure');
    console.error(err);
};