// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract Transaction {
    event SenderLogger(address);
    event ValueLogger(uint256);

    address private owner;

    modifier isOwner() {
        require(owner == msg.sender);
        _;
    }

    modifier validValue() {
        assert(msg.value >= 1 ether);
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    receive() external payable isOwner validValue {
        emit SenderLogger(msg.sender);
        emit ValueLogger(msg.value);
    }
}
