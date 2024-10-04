// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract FallbackExample{
    uint256 public result;
    //we cannot send the calldata or any sort of data with the receive() method. in order to send the callback data we need to have a fallback function
    receive() external payable {
        result=1;
    }
    fallback() external payable {
        result=2;
     }
}