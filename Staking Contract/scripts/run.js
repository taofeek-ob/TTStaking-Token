const main = async () => {
    const TTStakingContractFactory = await hre.ethers.getContractFactory("TTStaking");
    const TTStaking = await TTStakingContractFactory.deploy();
    await TTStaking.deployed();
    console.log("Contract deployed to:", TTStaking.address);
  };
  
  const runMain = async () => {
    try {
      await main();
      process.exit(0); 
    } catch (error) {
      console.log(error);
      process.exit(1); 
    }
    
  };
  
  runMain();