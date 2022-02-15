// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract DataTypes {
    bool myBool = false;

    int8 myInt = -128; //Signed integer can be positive and negative
    uint8 myUInt = 255; //Unsigned integer declaration and assignment (positive numbers)

    string myString; //Strings are usually array of integers under the hood in solidity
    uint8[] myStringArr; // Declaring array of unsigned integers

    bytes1 myValue;
    bytes1 myBytes1;
    bytes32 myBytes32;

    address payable myAddress; //Address that can receive ethers

    enum Action {
        ADD,
        REMOVE,
        UPDATE
    }

    Action myAction = Action.ADD; //Accessing enum values

    uint256[] myIntArr = [1, 2, 3];

    function arrFunc() public {
        myIntArr.push(1);
        myIntArr.length;
        myIntArr[0];
    }

    uint256[10] myFixedArr; // Arrays with definite length

    struct Account {
        //Structs are like customed types
        uint256 balance;
        uint256 dailyLimit;
    }

    Account myAccount;

    function structFunc() public {
        myAccount.balance = 100;
    }

    mapping(address => Account) _accounts;

    // receive() receives ethers to the contract
    receive() external payable {
        _accounts[msg.sender].balance += msg.value;
    }

    function getBalance() public view returns (uint256) {
        return _accounts[msg.sender].balance;
    }
}
