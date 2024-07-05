// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.15;

contract Counter {
    uint256 public number;

    constructor(uint256 _initialNumber) {
      number = _initialNumber;
    }

    function setNumber(uint256 newNumber) public {
        number = newNumber;
    }

    function increment() public {
        number++;
    }
}
