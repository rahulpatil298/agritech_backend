const hre = require("hardhat");

async function main() {
  const FarmerMarketplace = await hre.ethers.getContractFactory("FarmerMarketplace"); // Ensure this matches your contract name
  const farmerMarketplace = await FarmerMarketplace.deploy(); // Deploy contract

  await farmerMarketplace.waitForDeployment(); // Correct method for Hardhat-Ethers v6+

  console.log("FarmerMarketplace deployed to:", await farmerMarketplace.getAddress());
}

// Run the deployment
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
