// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

library PriceConverter{
    /*
    Libraries dont have ability to change the state or to send the ether it can only does mathematical calculations
    */
    function getPrice() internal  view returns (uint256) {
        /*
        Since this function is instance of us interating with the contract outside of our project so we need the Address and ABI
        in order to interact with the external data.
         Address(to convert the Eth to USD): 0x694AA1769357215DE4FAC081bf1f309aDC325306
         NOTE: ABI is required to interact with the external data solidity also provides us an option to call functions from another contract without haiving the ABI,
         i.e by using the interfaces like  "AggregatorV3Interface(0xYourPriceFeedAddress);" this.
        */
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        // (uint256 roundId, int price, uint startedAt, uint timeStamp, uint80 answeredInRound) = priceFeed.latestRoundData();
        (,int256 price,,,) = priceFeed.latestRoundData();
        return uint256(price * 1e10); // price is 8 decimals, converting it to 18 decimals
    }

    function getVersion() internal view returns (uint256){
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        return priceFeed.version();
    }

    function getConversionRate(uint256 ethAmt) internal view returns (uint256){
        uint256 ethPrice = getPrice(); // ETH/USD price with 18 decimals
        uint256 EthAmmountInUSD = (ethPrice * ethAmt) / 1e18; // Converts ETH amount to USD (18 decimals)
        return EthAmmountInUSD;
    }

}