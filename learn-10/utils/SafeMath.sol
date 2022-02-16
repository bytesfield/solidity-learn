// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

library SafeMath {
    uint256 public constant MAX_UINT256 =
        0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF;

    function add(uint256 x, uint256 y) internal pure returns (uint256 z) {
        require(x < MAX_UINT256 - y);

        return x + y;
    }

    function sub(uint256 x, uint256 y) internal pure returns (uint256 z) {
        require(x > y);

        return x - y;
    }

    function mul(uint256 x, uint256 y) internal pure returns (uint256 z) {
        if (y == 0) return 0;
        require(x < MAX_UINT256 / y);

        return x * y;
    }

    function div(uint256 x, uint256 y) internal pure returns (uint256 z) {
        require(y > 0);

        return x / y;
    }
}
