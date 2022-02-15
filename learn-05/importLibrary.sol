// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

import "./library.sol"; //Imports a solidity file

contract Library {
    // Makes contracts usable by uint256, its can be any other datatypes, if you want all use *
    using IntExtended for uint256;

    function testIncrement(uint256 _base) public pure returns (uint256) {
        return IntExtended.increment(_base);
    }

    function testDecrement(uint256 _base) public pure returns (uint256) {
        return IntExtended.decrement(_base);
    }

    function testIncrementByValue(uint256 _base, uint256 _value)
        public
        pure
        returns (uint256)
    {
        return _base.incrementByValue(_value);
    }

    function testDecrementByValue(uint256 _base, uint256 _value)
        public
        pure
        returns (uint256)
    {
        return _base.decrementByValue(_value);
    }
}
