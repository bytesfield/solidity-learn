// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

import "./IERC223.sol";

abstract contract Token is IERC223 {
    string internal _symbol;
    string internal _name;
    string internal _standard;
    uint8 internal _decimals;
    uint256 internal _totalSupply = 1000;

    mapping(address => uint256) internal _balanceOf;
    mapping(address => mapping(address => uint256)) internal _allowances;

    constructor(
        string memory __symbol,
        string memory __name,
        uint8 __decimals,
        uint256 __totalSupply
    ) {
        _symbol = __symbol;
        _name = __name;
        _standard = "erc233";
        _decimals = __decimals;
        _totalSupply = __totalSupply;
    }

    /**
     * @dev Returns the name of the token.
     */
    function name() public view override returns (string memory) {
        return _name;
    }

    /**
     * @dev Returns the symbol of the token, usually a shorter version of the
     * name.
     */
    function symbol() public view override returns (string memory) {
        return _symbol;
    }

    /**
     * @dev ERC223 tokens must explicitly return "erc223" on standard() function call.
     */
    function standard() public view override returns (string memory) {
        return _standard;
    }

    /**
     * @dev Returns the number of decimals used to get its user representation.
     * For example, if `decimals` equals `2`, a balance of `505` tokens should
     * be displayed to a user as `5,05` (`505 / 10 ** 2`).
     *
     * Tokens usually opt for a value of 18, imitating the relationship between
     * Ether and Wei. This is the value {ERC223} uses, unless {_setupDecimals} is
     * called.
     *
     * NOTE: This information is only used for _display_ purposes: it in
     * no way affects any of the arithmetic of the contract, including
     * {IERC223-balanceOf} and {IERC223-transfer}.
     */
    function decimals() public view override returns (uint8) {
        return _decimals;
    }

    function totalSupply() public view override returns (uint256) {
        return _totalSupply;
    }

    /**
     * @dev Returns balance of the `_addr`.
     *
     * @param _addr   The address whose balance will be returned.
     * @return balance Balance of the `_addr`.
     */
    function balanceOf(address _addr)
        public
        view
        override
        returns (uint256 balance)
    {
        return _balanceOf[_addr];
    }
}
