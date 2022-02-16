// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

interface ERC20 {
    function transferFrom(
        address _from,
        address _to,
        uint256 _value
    ) external returns (bool);

    function approve(address _spender, uint256 _value) external returns (bool);

    function allowance(address _owner, address _spender)
        external
        returns (uint256);

    event Approval(
        address indexed _owner,
        address indexed _spender,
        uint256 _value
    );
}
