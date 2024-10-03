// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SafeMathTester{
    uint8 public bigNumber = 254;
    function add() public {
        bigNumber= bigNumber+1; 
    //    unchecked{ bigNumber= bigNumber+1;} 
    }

}