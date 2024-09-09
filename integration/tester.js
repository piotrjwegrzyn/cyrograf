// To run this script use:
// export RPC_URL="https://rpc.sepolia.org/"
// export ACCOUNT_ADDRESS="ADDRESS" &&\
// export PRIVATE_KEY="KEY" &&\
// node --no-deprecation ./tester.js

const { Web3 } = require('web3');
const fs = require('node:fs/promises');

(async ()=>{

  const web3 = new Web3(process.env.RPC_URL);

  const contractInfo = await readFileContent('./sc_connector.json');
  const contractAddress = contractInfo['contract_address'];
  const contractABI = contractInfo['contract_abi'];

  const cyrografContract = new web3.eth.Contract(contractABI, contractAddress);

  const account = process.env.ACCOUNT_ADDRESS;
  const privateKey = process.env.PRIVATE_KEY;
  web3.eth.accounts.wallet.add(privateKey);

  async function getBackground() {
    try {
      const background = await cyrografContract.methods.getBackground().call();
      const { x: xNW, y: yNW, z: zNW } = background.northWest;
      const { x: xSE, y: ySE, z: zSE } = background.southEast;
      
      console.log(`Got NorthWest/SouthEast: rgb(${xNW}, ${yNW}, ${zNW}) / rgb(${xSE}, ${ySE}, ${zSE})`);
    } catch (error) {
      console.error("Error getting background:", error);
    }
  }

  async function setBackground(xNW, yNW, zNW, xSE, ySE, zSE) {
    const accounts = await web3.eth.getAccounts();

    try {
      await cyrografContract.methods.setBackground(
        {x: xNW, y: yNW, z: zNW},
        {x: xSE, y: ySE, z: zSE}
      ).send({from: account});
      console.log(`Set NorthWest/SouthEast: rgb(${xNW}, ${yNW}, ${zNW}) / rgb(${xSE}, ${ySE}, ${zSE})`);
    } catch (error) {
      console.error("Error setting background:", error);
    }
  }

  await getBackground();
  await setBackground(0, 0, 0, 255, 255, 255);
  await getBackground();
  await setBackground(21, 37, 69, 128, 64, 32);
  await getBackground();
})()

async function readFileContent(filePath) {
  try {
    const content = await fs.readFile(filePath, 'utf8');
    return JSON.parse(content);
  } catch (error) {
    console.error('Failed to read file:', error);
    throw error;
  }
}