// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SimpleStorage {
    uint256 private storedData;

    // 値を設定する関数
    function set(uint256 x) public {
        storedData = x;
    }

    // 値を取得する関数
    function get() public view returns (uint256) {
        return storedData;
    }
}
