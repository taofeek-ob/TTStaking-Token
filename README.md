# BlockGames Task 5
## Create a simple user UI/Frontend that interacts with a staking/vesting contract

## Prerequisites:

  Understand the ERC-20 token interface and how to create a simple ERC-20 token
  Understand Solidity units and global variables.
  Understand how to instantiate transactions within smart contracts and make EVM calls.
  Understand Inheritance and libraries in Solidity
  Understand how to deploy and verify smart contracts on the Test-net.
 

## Objectives( What you are required to do):

Extend an ERC20 to support staking and rewards. Users can stake some of their tokens. When users stake their tokens, they are effectively locked and can't be transferred or spent.
Make your contract Ownable and assign the owner 1000 tokens initially. Create a function modifyTokenBuyPrice and restrict access only to the owner.
Create a function buyToken that can be called publicly to buy/mint new tokens.
Create a Rewards System, where users can earn 1% of their stake. They will be able to call a function to claim rewards which will increment their balance. They will only be eligible to claim rewards every week, and users who don't claim their rewards effectively lose them for that week.
Create a basic User Interface that makes use of web3.js or ethers.js to interact with your smart contract. User UI should show Users the number of tokens staked, give them the ability to stake tokens, give them the ability to view their token balance, and give them the ability to transfer tokens.
Note: Use any framework between hardhat and truffle. Any framework outside of these two is not accepted.

# Submission
TTStaking Contract address: https://rinkeby.etherscan.io/address/0x0d0b50C583053594b5E2dB6a8D9E3c30cd847658

Staking UI: https://stk-token-staking.netlify.app/
