// SPDX-License-Identifier: GPL-2.0-or-later
pragma solidity =0.7.6;
pragma abicoder v2;

import './libraries/ISwapRouter.sol';
import './libraries/TransferHelper.sol';

contract Swap {

    ISwapRouter public immutable swapRouter; 

    address public constant DAI = 0x6B175474E89094C44Da98b954EedeAC495271d0F;
    address public constant WETH = 0xc778417E063141139Fce010982780140Aa0cD5Ab; 
    address public constant USDC = 0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48;

    address[] tokens;
    mapping(address => bool) public tokenExists;

    uint24 public constant poolFee = 3000;

    

    constructor(ISwapRouter _swapRouter) {
        swapRouter = _swapRouter;
        tokens.push(DAI);
        tokenExists[DAI] = true;
        tokens.push(USDC);
        tokenExists[USDC] = true;
    }

    function addToken(address _token) public {
        if (tokenExists[_token] != true) {
            tokens.push(_token);
            tokenExists[_token] = true;
        }
    }

    function swapExactInputSingle(uint256 _amountIn, address _tokenToBuy) external returns (uint256 amountOut) {

        addToken(_tokenToBuy);

        TransferHelper.safeTransferFrom(WETH, msg.sender, address(this), _amountIn);
        TransferHelper.safeApprove(WETH, address(swapRouter), _amountIn);
        
        ISwapRouter.ExactInputSingleParams memory params = 
            ISwapRouter.ExactInputSingleParams({
                tokenIn: WETH,
                tokenOut: _tokenToBuy,
                fee: poolFee,
                recipient: msg.sender,
                deadline: block.timestamp,
                amountIn: _amountIn,
                amountOutMinimum: 0,
                sqrtPriceLimitX96: 0
            });
        
        amountOut = swapRouter.exactInputSingle(params);
    }
}