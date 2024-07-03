// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract RiskyDonation {
    address owner;
    uint256 public bonus = 0;
    mapping(address => uint256[]) public balances;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }

    function donate(address _to) public payable {
        balances[_to].push(msg.value + bonus*1e18);
    }

    function balanceOf(address _who) public view returns (uint256 balance) {
        for(uint i = 0; i < balances[_who].length; i++) {
            balance += balances[_who][i];
        }
        return balance;
    }

    function increment() public onlyOwner {
        unchecked {
            bonus++;
        }
    }

    function withdraw(uint256 _amount) public {
        if (balanceOf(msg.sender) >= _amount) {
            (bool result, ) = msg.sender.call{value: _amount}("");
            require(result, "Transfer failed.");
            _withdraw(_amount);
        }
    }

    function _withdraw(uint256 _amount) private {
        uint256 remaining = _amount;
        for(uint i = 0; i < balances[msg.sender].length; i++) {
            remaining -= balances[msg.sender][i];
            if (remaining > balances[msg.sender][i]) {
                balances[msg.sender][i] = 0;
                remaining -= balances[msg.sender][i];
            } else {
                balances[msg.sender][i] -= remaining;
                remaining = 0;
            }
        }
    }

    receive() external payable {}
    fallback() external payable {}
}
