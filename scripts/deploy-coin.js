const { ethers, upgrades } = require("hardhat");

async function main() {
  const ABCCoinInstance = await ethers.getContractFactory("ABCCoin");
  const ABCCoinContract = await ABCCoinInstance.deploy();
  console.log("ABCCoin Contract is deployed to:", ABCCoinContract.address);
}

main();
