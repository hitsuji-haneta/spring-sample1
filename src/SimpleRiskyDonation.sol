// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract Donation {
    address owner;
    uint256 public bonus = 0;
    mapping(address => uint256) public balance;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }

    function donate(address _to) public payable {
        balance[_to] = msg.value;
    }

    function balanceOf(address _who) public view returns (uint256) {
        return balance[_who];
    }

    function withdraw(uint256 _amount) public {
        if (balanceOf(msg.sender) >= _amount) {
            (bool result, ) = msg.sender.call{value: _amount}("");
            require(result, "Transfer failed.");
            _withdraw(_amount);
        }
    }

    function _withdraw(uint256 _amount) private {
        if (balance[msg.sender] >= _amount) {
            balance[msg.sender] -= _amount;
        } else {
            revert("Insufficient balance.");
        }
    }

    receive() external payable {}

    fallback() external payable {}
}
