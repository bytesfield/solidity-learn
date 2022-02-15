// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract Exceptions {
    function testAssert() public pure {
        assert(1 == 2);
    }

    function testRequire() public pure {
        require(2 == 1);
    }

    function testRevert() public pure {
        revert();
    }
}
