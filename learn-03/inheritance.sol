// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

interface Regulator {
    function checkValue(uint256 amount) external returns (bool);

    function loan() external returns (bool);
}

contract Bank is Regulator {
    //This Contract implements the Regulatory interface, the contract must implements functions of the interface
    uint256 private value;

    // Contsructor declaration
    constructor(uint256 amount) {
        value = amount;
    }

    function deposit(uint256 amount) public {
        value += amount;
    }

    function withdraw(uint256 amount) public {
        if (checkValue(amount)) {
            value -= amount;
        }
    }

    function balance() public view returns (uint256) {
        return value;
    }

    function checkValue(uint256 amount) public view returns (bool) {
        return value >= amount;
    }

    function loan() public view returns (bool) {
        return value > 0;
    }
}

contract BranchContract is Bank(10) {
    //This Contract inherits the Bank contract, all functions and state variables and accessible in the contract

    string private name;
    uint256 private age;

    function setName(string memory newName) public {
        name = newName;
    }

    function getName() public view returns (string memory) {
        return name;
    }

    function setAge(uint256 newAge) public {
        age = newAge;
    }

    function getAge() public view returns (uint256) {
        return age;
    }
}
