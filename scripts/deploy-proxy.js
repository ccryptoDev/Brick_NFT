const { ethers, upgrades } = require("hardhat");

async function main() {
  const InstanceV2 = await ethers.getContractFactory(
    "TransparentUpgradeableProxy"
  );
  const contract = await InstanceV2.deploy(
    "0xc946dd91f549b9bcdfdfc758d95526cb57100bcc",
    "0x1Dd037cf671af4cd461CCf86100016CAAa5c5255",
    []
  );
  console.log("Box upgraded", contract.address);
}

main();
