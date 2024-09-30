// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "./SimpleStorage.sol";


contract ExtraStorage is SimpleStorage{
    /*
    So the above statement means that the ExtraStorage is inheriting all the properties of SimpleStorage.
    And we can add some extra functionalites here and also if we want to modify the function we can modify 
    them by overriding the particular function like lets say the store function in SimpleStorage which simply store the value,
    but here i want to add some number and store that value, which i can implement by overriding the function 
    NOTE:-> Inorder to override a function first make sure it is virtual inorder to override the function,First 
    the function should be virtual inorder to make the overriding possible.
    */
     function store(uint256 _favNumber) public override {
        _favNumber = _favNumber + 5; // Add 5 to the input
        super.store(_favNumber); // Call the parent store function to store the modified value
    }
}

