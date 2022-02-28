const { ethers, upgrades } = require("hardhat");

async function main() {
  const NftInstance = await ethers.getContractFactory("NFTUpgradeable");
  const ERC721Contract = await upgrades.deployProxy(NftInstance, ["0x1Dd037cf671af4cd461CCf86100016CAAa5c5255", "0x0Db65114C65C2452F726D8B1a850C4400EDb3078"]);
  await ERC721Contract.deployed();
  console.log("ERC721Upgradeable Contract is deployed to:", ERC721Contract.address);
}

main();