// scripts/upgrade-box.js
const { ethers, upgrades } = require("hardhat");

const BOX_ADDRESS = "0xf15F1AD2D6769F0ec782D864728E5C744A36CA06";

async function main() {
  const BoxV2 = await ethers.getContractFactory("ABCCoinV2");
  const box = await upgrades.upgradeProxy(BOX_ADDRESS, BoxV2);
  console.log("Box upgraded", box.address);
}

main();
