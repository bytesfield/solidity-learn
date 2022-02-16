// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

abstract contract ERC223ReceivingContract {
    function tokenFallback(
        address _from,
        uint256 _value,
        bytes memory _data
    ) public virtual;
}
