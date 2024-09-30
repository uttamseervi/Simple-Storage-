// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SimpleStorage{
    uint256  favoriteNumber; //Declare a variable of type 'uint'
    
    struct People{
        uint256 favoriteNumber;
        string name;
    }
    // array declaration of type People 
    // uint256[] public favoriteNumber; like this we define the array in solidity
    People[] public people;
    mapping(string => uint256) public nameToFavNumber;

    function store(uint256 _favoriteNumber) public virtual {
        favoriteNumber = _favoriteNumber;
    }
    // the color of the store is orange but the rest function is bluish bcz no gas is utilised in the executing the rest of the function 
    // view,pure 

    // and we use view method does not alter the state of the block chain rather it will just returns the value of the variable
    function retrieve() public view returns (uint256){
        return favoriteNumber;
    } 
    // we can use the pure method in order to make some mathematical calculations 
    function multilply(uint256 a) public pure returns (uint256) {
        return (a*a);
    }
    function addPeople(string memory _name,uint256 _favoriteNumber) public {
      
        people.push(People(_favoriteNumber,_name));
        nameToFavNumber[_name] = _favoriteNumber;
    }


    /*
    calldata,memory,storage
    Calldata: This is used for function arguments that are read-only and exist temporarily during the execution of a function.
    Variables stored in calldata are immutable and cannot be changed. It is often used for external function calls.
    Memory: This is a temporary storage used within functions. 
    Variables stored in memory exist only during the function execution. 
    Once the function is done executing, the memory is cleared. 
    It allows reading and writing of data during the function's lifecycle.
    Storage: This is the persistent storage on the blockchain. 
    Variables stored in storage will persist even after the function execution and across transactions.
     Storage is more expensive to use compared to memory and calldata.                            
    */

    /*
    Basic Solidity mappings
    In Solidity, mappings are used to create key-value pairs, similar to hash maps or dictionaries in other languages.
    They are often used to store and retrieve data efficiently by associating a unique key with a value.

    example: mapping(string=>uint256) public ( public is for visiblity) nameToFavNumbers
    */
    
}