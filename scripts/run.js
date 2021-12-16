const main = async () => {
    // Compile contract and generates necessary files under the artifacts directory
    const nftContractFactory = await hre.ethers.getContractFactory('MyNFT');
    const nftContract = await nftContractFactory.deploy();
    // wait for contract to be deployed
    await nftContract.deployed();

    console.log("Contract deployed to : ", nftContract.address);
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