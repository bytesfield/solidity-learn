// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

import "./ERC20.sol";

contract BytesToken is ERC20 {
    string public constant symbol = "BFT";
    string public constant name = "Bytes Token";
    uint8 public constant decimals = 18;

    uint256 private constant __totalSupply = 1000;

    mapping(address => uint256) private __balanceOf;
    mapping(address => mapping(address => uint256)) private __allowances;

    constructor() {
        __balanceOf[msg.sender] = __totalSupply;
    }

    event ReceivedFund(address from, uint256 amount);
    event WithdrawFund(address from, uint256 amount);
    event TransferFund(address from, address to, uint256 amount);

    error InsufficientBalance(
        uint256 requested,
        uint256 available,
        string message
    );

    /**
     * @dev Token's the current total supply in circulation
     *
     */
    function totalSupply() public pure returns (uint256 _totalSupply) {
        _totalSupply = __totalSupply;
    }

    /**
     * @dev Returns balance of an address (keeps track of the balance in each user wallet).
     *
     * @param _addr   The address whose balance will be returned.
     * @return balance Balance of the address.
     */
    function balanceOf(address _addr) public view returns (uint256 balance) {
        return __balanceOf[_addr];
    }

    /**
     * @dev Owner Transfer a specified amount of tokens to a specified address.
     *
     * @param _to    Receiver address.
     * @param _value Amount of tokens that will be transferred.
     * @return  success
     */
    function transfer(address _to, uint256 _value)
        public
        returns (bool success)
    {
        address sender = msg.sender;

        sufficientBalance(_value, balanceOf(sender)); //check sender balance is sufficient
        require(balanceOf(_to) + _value >= balanceOf(_to)); //check for overflows

        __balanceOf[sender] -= _value; //substract value from sender
        __balanceOf[_to] += _value; //add value to receiver

        emit TransferFund(sender, _to, _value);

        return true;
    }

    /**
     * @dev Allows a smart contract to automate the transfer process and 
     * send a given amount of the token on behalf of the owner
     *
     * @param _from   Sender address.
     * @param _to    Receiver address.
     * @param _value Amount of tokens that will be transferred.
     
     * @return  success
     */
    function transferFrom(
        address _from,
        address _to,
        uint256 _value
    ) public returns (bool success) {
        address sender = msg.sender;

        if (
            _value > 0 &&
            __allowances[_from][sender] > 0 &&
            __allowances[_from][sender] >= _value &&
            __balanceOf[_from] >= _value
        ) {
            __balanceOf[_from] -= _value;
            __balanceOf[_to] += _value;

            __allowances[_from][sender] -= _value;

            emit TransferFund(_from, _to, _value);

            return true;
        }
        return false;
    }

    /**
     * @dev Owner address approves an address with a value to spend
     *
     * @param _spender   Spender address.
     * @param _value Amount of tokens that will be transferred.
     
     * @return  success
     */
    function approve(address _spender, uint256 _value)
        public
        returns (bool success)
    {
        __allowances[msg.sender][_spender] = _value;
        return true;
    }

    /**
     * @dev An owner address adds an address to allowance
     *
     * @param _owner   Owner address.
     * @param _spender   Spender address.
     
     * @return remaining
     */
    function allowance(address _owner, address _spender)
        public
        view
        returns (uint256 remaining)
    {
        return __allowances[_owner][_spender];
    }

    /**
     * @dev Checks if balance is sufficient.
     *
     * @param  _amount  amount.
     * @param  _balance Address balance.
     
     */
    function sufficientBalance(uint256 _amount, uint256 _balance) private pure {
        if (_amount > 0 && _amount > _balance)
            revert InsufficientBalance({
                requested: _amount,
                available: _balance,
                message: "Insufficient Balance"
            });
    }
}
