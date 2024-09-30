// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "./SimpleStorage.sol";



contract StorageFactory{
    // SimpleStorage public simpleStorage;
    SimpleStorage[] public simpleStorageArray;
    function createSimpleStorageContract() public  {
        /*
        What are we doing here: "We are deploying a smart contract using the some other 
        smart contract to do so we need to know about importing the smart contracts"
        Here our StorageFactory is deploying SimpleStorage to use it's memory,
        it has imported the SimpleStorage smart contract into it's memory and deployed it 
        to a new memory address
         How does storageFactory know what simple storage is:
        */
        // simpleStorage = new SimpleStorage();
        SimpleStorage simpleStorage = new SimpleStorage();
        simpleStorageArray.push(simpleStorage);
    }
    function sfStore(uint256 _simpleStorageIndex,uint256 _simpleStorageNumber) public {
        /*
        So in the above function we can see that we have deployed the simpleStorageContract using the StorageFactory
        but we cannot interact with the deployed contract at the time of creating a function 
        Inorder to interact with the deployed contract we need to know about::::
        1.Address,
        2.ABI:(Application Binary Interface)
        ABI is nothing but an array of structs, each struct has 3 properties, 1) 
        function name, 2) input parameters, 3) return parameters,
        We can use the ABI to interact with the deployed contract, inorder to interact with the deployed contract we need to know about::::
        ABI, Address, and the contract's address
        */
        // SimpleStorage simpleStorage = simpleStorageArray[_simpleStorageIndex];
        // simpleStorage.store(_simpleStorageNumber);
        simpleStorageArray[_simpleStorageIndex].store(_simpleStorageNumber);
    }
    function sfGet(uint256 _simpleStorageIndex) public view returns (uint256){
     return simpleStorageArray[_simpleStorageIndex].retrieve();
    }

   
}