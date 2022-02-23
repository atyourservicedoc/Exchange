# ERC20 Swap
This project demonstrates an on-chain exchange of eth for ERC20s.

This project makes use of the Uniswap router and transfer helper libraries to facilitate this exchange.

As a limitation of the swapRouter interface, ERC20's can only be exchanged for ERC20's. The contract uses Wrapped Ether (WETH), a stablecoin ERC20 with a 1-2-1 value equality relationship with Eth, as the equivalent of Eth for the purposes of purchasing medium, as described in their documentation.

It assumes a pool fee of 0.3% and a default list of DAI, and USDC as the default list of ERC20s to be purchased with WETH, though more tokens can be added.

The ability to add tokens is naive and doesn't confirm or validate the contract address is an ERC20. An improvement could be to check if the contract supports the ERC20 interface, similar to the supportInterface function implemented in the Royalty project.

The contract allows a user to purchase _amountIn of WETH worth of a specificed contract. The WETH is safetransfered to this contract, before approving the swapRouter specified in construction to sell the WETH for the new token.

It then purchases exactly X WETH of the new token, with the amount received being variable due to factors such as slippage.

The swapRouter interface does also implement a purchase function that returns an exact amount of the new token, where the amount of WETH spent is variable, but this is less commonly used and not implemented in this example.

It is possible, in the testing framework using hardhat ethers and chai, to directly manipulate the amounts of specificed ERC20s during a unit test run to reverify atomically the exchange mechanism at work here, but this has not been implemented.
