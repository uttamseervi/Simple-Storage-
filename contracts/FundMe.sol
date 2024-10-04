// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;
import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";
import "./PriceConverter.sol";

// 0xB690803D85716Dccae7FbaaE2e4Ef1Adec55D04d test net address
error NotOwner();


contract FundMe {

    /*so we can improve our code by using the constant and immutable keyword in solidity like for the MINIMUM_USD it can be changed ,but i want to keep unchanged so we can use constant keyword
    even the reqiure statement also consumes some amount of gas so we can replace them with solidity custom errros
    */
    using PriceConverter for uint256;
    uint256 public constant MINIMUM_USD = 50 * 1e18;
    address[] public funders;
    mapping(address => uint256) public addressToAmountFunded;
    address public immutable i_owner;

    constructor() {
        // msg.sender represents the person who deploys the contract
        i_owner = msg.sender;
    }

    function fund() public payable {
        require(msg.value.getConversionRate() >= MINIMUM_USD, "Didn't send enough!");
        addressToAmountFunded[msg.sender] += msg.value;
        funders.push(msg.sender);
    }

    function withdraw() public onlyOwner {
        // Reset the funders array to save gas
        funders = new address[](0) ;
        // Withdraw the funds using the call method
        (bool callSuccess,) = payable(msg.sender).call{value: address(this).balance}("");
        require(callSuccess, "Call failed");
    }

    modifier onlyOwner() {
        // require(msg.sender == i_owner, "Sender is not the owner!");
        if(msg.sender != i_owner) {
            revert NotOwner();
        }
        _;
    }

    // What happens if someone tries sending eth wihtout calling fund function  we can make use of  ("recive" and "fallback")
    receive() external payable {
        fund();
     }
    fallback() external payable { 
        fund();
    }
}



// pragma solidity ^0.8.0; complete code for notes purpose its just the same code as above 
// import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";
// import "./PriceConverter.sol";
// /*
//     Things we are doing in this contract:
//     Send funds.
//     Withdraw funds.
//     Set Minimum funding value in USD
// */
// contract FundMe{
//     using PriceConverter for uint256;

//     uint256 public MINIMUM_USD = 50 * 1e18;
//     address[] public funders;
//     mapping(address=>uint256) public addressToAmountFunded; 
//     address public owner;
//     constructor(){
//         // the the msg.sender represents the person who deploys the contract
//         owner = msg.sender;
//     }


//     function fund() public payable  {
//         /* Here i want to able to set the minimum fund in USD
//             1.How do we send Eth to this contract. "There's a value field in the EVM from there we can enter the amount of Eth
//             that need to be sent"
//             In order to access the value we can use "msg.value" here we can get the amount of Eth that the User is sending
//             We can also set a limit that minimum of this amount of Eth should be sent by using the function require(msg.value>1e18) something like this.
//             it checks the amount if it satisties the requirement the okay otherwise the whole function is reverted back and undo the whole process and,
//             send the remaining gas back...
//             2.Inorder to get the price of 1 Eth in USD we have to use some decentralised network like chainlink or the oracle.
//         */
//         // msg.value.getConversionRate();
//         require(msg.value.getConversionRate() >= MINIMUM_USD, "Didn't send enough");
//         addressToAmountFunded[msg.sender] += msg.value;
//         funders.push(msg.sender);
//     }

    
//     function withdraw() public  onlyOwner{
//         /* require(msg.sender == owner, "Sender is not owner!");  this line make sure that only owner can call the withdraw function
//         may be there are lot of function where we reqiure the owner so in order to keep a check on it there something called modifiers in solidity 
//         we can make use of modifiers in order to verify the user
//         */

//         for(uint256 funderIndex = 0; funderIndex < funders.length;funderIndex++){
//             funders[funderIndex]  ;
//             addressToAmountFunded[funders[funderIndex]] = 0;
//         }
//         // reset the array..
//         funders = new address[](0);
//         /* withdraw the funds
//         There are actually three different ways to it        
//         transfer (2300 gas, throws error)
//         send (2300 gas, returns bool)
//         call (forward all gas or set gas, returns bool): this is the most powerfull tool among the three to use 
//         for more reference click : https://solidity-by-example.org/

//         */
//         //here address of this represents the address of this contract and we need to type cast the to payable form then we can transform the funds
//     // //    payable ( msg.sender).transfer(address(this).balance);
//     //    bool sendSuccess = payable (msg.sender).send(address(this).balance);
//     // //    require(sendSuccess,"Send Failed");
//     //     (bool callSuccess,bytes memory/*since bytes objects are arrays they need to be put in memory 
//     //     since here we are not calling any function so we dont need to care about the data returned
//     //     */ dataReturned) = payable(msg.sender).call{value:address(this).balance}("");
    
//         (bool callSuccess,) = payable(msg.sender).call{value:address(this).balance}("");
//         require(callSuccess,"Call failed");
//     }
//     modifier  onlyOwner(){
//         require(msg.sender == owner, "Sender is not owner!");
//         _;
//         // the function where this modifier is added that function first check what is in the modifier and if is correct then 
//         // the _; is executed this means the rest of the code (if the msg.sender is owner then execute rest of the code else return the message)
//     }
// }
