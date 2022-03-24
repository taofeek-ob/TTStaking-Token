//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "hardhat/console.sol";

contract TTStaking is ERC20, Ownable {
    using SafeMath for uint256;
    uint256 salePrice = 1000;
event newStaking(uint amount);
    constructor() ERC20("TTStaking", "STK") {
        _mint(msg.sender, 1000 * 10**decimals());
      
    }

    function modifyTokenPrice(uint _salePrice)
        public
        onlyOwner
        returns (uint256)
    {
        require(_salePrice > 0, "cannot set price as zero");
        require(salePrice != _salePrice);
        salePrice = _salePrice;
        return salePrice;
    }

    function buyToken(address receiver) external payable {
        require(msg.value > 0, "please enter ether value");
        uint amount = (msg.value / 1000000000000000000) * salePrice;
        _mint(receiver, amount);
    }

    address[] internal stakeholders;


    function isStakeholder(address _address)
        public
        view
        returns (bool, uint256)
    {
        for (uint256 s = 0; s < stakeholders.length; s += 1) {
            if (_address == stakeholders[s]) return (true, s);
        }
        return (false, 0);
    }

    function addStakeholder(address _stakeholder) internal  {
        (bool _isStakeholder, ) = isStakeholder(_stakeholder);
        if (!_isStakeholder) stakeholders.push(_stakeholder);
    }

    function removeStakeholder(address _stakeholder) public {
        (bool _isStakeholder, uint256 s) = isStakeholder(_stakeholder);
        if (_isStakeholder) {
            stakeholders[s] = stakeholders[stakeholders.length - 1];
            stakeholders.pop();
        }
    }

    mapping(address => uint256) internal stakes;

    function stakeOf(address _stakeholder) public view returns (uint256) {
        return stakes[_stakeholder];
    }

    function totalStakes() public view returns(uint256) {
        uint256 _totalStakes = 0;
        for (uint256 s = 0; s < stakeholders.length; s += 1) {
            // _totalStakes = _totalStakes.add(stakes[stakeholders[s]]);
            _totalStakes += stakes[stakeholders[s]];
           
        }
        return _totalStakes;
    }

    mapping(address => uint256) internal rewards;

    function rewardOf(address _stakeholder) public view returns (uint256) {
        return rewards[_stakeholder];
    }

    function totalRewards() public view returns (uint256) {
        uint256 _totalRewards = 0;
        for (uint256 s = 0; s < stakeholders.length; s += 1) {
            _totalRewards = _totalRewards.add(rewards[stakeholders[s]]);
        }
        return _totalRewards;
    }

    mapping(address => uint) balances;
    mapping(address => uint) rewardDueDate;

    function stakeAmount(address _stakeholder) public view returns (uint) {
        return stakes[_stakeholder];
    }

    function stakeToken(uint _stake) public {
        uint amount = _stake * 10**decimals();
        require(balances[msg.sender] <= amount);
        rewardDueDate[msg.sender] = block.timestamp + 7 days;
        _burn(msg.sender, amount);
        stakes[msg.sender] = stakes[msg.sender].add(amount);
        emit newStaking(amount);
        if (stakes[msg.sender] >= 0) addStakeholder(msg.sender);
    }

    function removeStake(uint256 _stake) public {
        require(stakes[msg.sender] > 0, "you didn't stake");
        uint amount = _stake * 10**decimals();
        stakes[msg.sender] = stakes[msg.sender].sub(amount);
        if (stakes[msg.sender] == 0) removeStakeholder(msg.sender);
        _mint(msg.sender, amount);
    }

    function claimReward() public {
        require(stakes[msg.sender] > 0, "you didn't stake");
        require(
            block.timestamp >= rewardDueDate[msg.sender],
            "wait for a week to claim!"
        );
        rewardDueDate[msg.sender] = block.timestamp + 7 days;
        balances[msg.sender] += ((stakes[msg.sender] * 1) / 100);
    }
}
