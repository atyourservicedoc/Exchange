const {expect} = require("chai");
const {ethers} = require("hardhat");
const erc20Abi = require('../artifacts/@openzeppelin/contracts/token/ERC20/IERC20.sol/IERC20.json');


describe("Swap", function () {
    const DAI_ADDRESS = "0x6b175474e89094c44da98b954eedeac495271d0f";
    const DAI_SLOT = 2;

    it('buy DAI with Eth', async() => {
        const provider = ethers.provider;
        const Dai = new ethers.Contract(DAI_ADDRESS, erc20Abi.abi, provider);
        const locallyManipulatedBalance = parseUnits("100000");

        const [owner, user] = await ethers.getSigners();

        userDaiBalance = await Dai.balanceOf(user.address());
        assert(userDaiBalance.isZero());

        // Get storage slot index
        /*const index = ethers.utils.solidityKeccak256(
            ["uint256", "uint256"],
            [user.address(), DAI_SLOT] // key, slot
        );*/

        // Manipulate local balance (needs to be bytes32 string)
        /*await setStorageAt(
            DAI_ADDRESS,
            index.toString(),
            toBytes32(locallyManipulatedBalance).toString()
        );*/
    });
})