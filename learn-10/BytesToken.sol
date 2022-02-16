// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

import "./Token.sol";
import "./IERC223.sol";
import "./IERC223Recipient.sol";
import "./utils/SafeMath.sol";
import "./utils/Address.sol";
import "./ERC20.sol";

contract BytesToken is Token("BYT", "Bytes Token", 18, 1000), ERC20 {
    using SafeMath for uint256;

    constructor() {
        _balanceOf[msg.sender] = _totalSupply;
    }

    error InsufficientBalance(
        uint256 requested,
        uint256 available,
        string message
    );

    /**
     * @dev Function that is called when a user or another contract wants to transfer funds
     *
     * @param _to   Receiver address.
     * @param _value Amount of tokens that will be transferred.
     * @param _data Extra data for the transaction.
     *
     * @return bool
     */
    function transfer(
        address _to,
        uint256 _value,
        bytes memory _data
    ) public override returns (bool) {
        if (Address.isContract(_to)) {
            return transferToContract(_to, _value, _data);
        }

        return transferToAddress(_to, _value, _data);
    }

    /**
     * @dev Standard function transfer similar to ERC20 transfer with no _data
     * Added due to backwards compatibility reasons
     *
     * @param _to   Receiver address.
     * @param _value Amount of tokens that will be transferred.
     *
     * @return bool
     */
    function transfer(address _to, uint256 _value)
        public
        override
        returns (bool)
    {
        bytes memory empty;

        if (Address.isContract(_to)) {
            return transferToContract(_to, _value, empty);
        }

        return transferToAddress(_to, _value, empty);
    }

    /**
     * @dev Private function to transfer token to an address
     *
     *
     * @param _to   Receiver address.
     * @param _value Amount of tokens that will be transferred.
     * @param _data Transaction metadata
     *
     * @return bool
     */
    function transferToAddress(
        address _to,
        uint256 _value,
        bytes memory _data
    ) private returns (bool) {
        uint256 senderBalance = _balanceOf[msg.sender];
        uint256 amount = _value;

        sufficientBalance(senderBalance, amount);

        if (!Address.isContract(_to)) {
            _balanceOf[msg.sender] = senderBalance.sub(amount);

            _balanceOf[_to] = _balanceOf[_to].add(amount);

            emit Transfer(msg.sender, _to, amount);

            emit TransferData(_data);

            return true;
        }

        return false;
    }

    /**
     * @dev Transfer the specified amount of tokens to the specified address.
     *      Invokes the `tokenFallback` function if the recipient is a contract.
     *      The token transfer fails if the recipient is a contract
     *      but does not implement the `tokenFallback` function
     *      or the fallback function to receive funds.
     *
     *
     * @param _to   Receiver address.
     * @param _value Amount of tokens that will be transferred.
     * @param _data Transaction metadata.
     *
     * @return bool
     */
    function transferToContract(
        address _to,
        uint256 _value,
        bytes memory _data
    ) private returns (bool) {
        uint256 senderBalance = _balanceOf[msg.sender];
        uint256 amount = _value;

        sufficientBalance(senderBalance, amount);

        if (Address.isContract(_to)) {
            _balanceOf[msg.sender] = senderBalance.sub(amount);

            _balanceOf[_to] = _balanceOf[_to].add(amount);

            IERC223Recipient _contract = IERC223Recipient(_to);
            _contract.tokenReceived(msg.sender, amount, _data);

            emit Transfer(msg.sender, _to, amount);

            emit TransferData(_data);

            return true;
        }

        return false;
    }

    /**
     * @dev Allows a smart contract to automate the transfer process and
     * send a given amount of the token on behalf of the owner
     *
     * @param _from  Sender address.
     * @param _to   Receiver address.
     * @param _value Amount of tokens that will be transferred.
     *
     * @return bool
     */
    function transferFrom(
        address _from,
        address _to,
        uint256 _value
    ) public returns (bool) {
        uint256 senderBalance = _allowances[_from][msg.sender];
        uint256 amount = _value;

        sufficientBalance(senderBalance, amount);

        if (senderBalance > 0 && _balanceOf[_from] >= amount) {
            _balanceOf[_from] = _balanceOf[_from].sub(amount);

            _balanceOf[_to] = _balanceOf[_to].add(amount);

            _allowances[_from][msg.sender] = senderBalance.sub(amount);

            emit Transfer(_from, _to, amount);

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
        _allowances[msg.sender][_spender] = _value;

        emit Approval(msg.sender, _spender, _value);

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
        return _allowances[_owner][_spender];
    }

    /**
     * @dev Checks if balance is sufficient.
     *
     * @param  _balance Address balance.
     * @param  _amount  amount.
     
     */
    function sufficientBalance(uint256 _balance, uint256 _amount) private pure {
        if (_amount > 0 && _amount > _balance)
            revert InsufficientBalance({
                requested: _amount,
                available: _balance,
                message: "Insufficient Balance"
            });
    }
}
