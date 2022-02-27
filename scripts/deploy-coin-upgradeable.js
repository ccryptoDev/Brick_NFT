const { ethers, upgrades } = require("hardhat");

async function main() {
  const ABCCoinInstance = await ethers.getContractFactory("ABCCoinUpgradeable");
  const ABCCoinContract = await upgrades.deployProxy(ABCCoinInstance);
  await ABCCoinContract.deployed();
  console.log("ABCCoinUpgradeable Contract is deployed to:", ABCCoinContract.address);
}

main();
