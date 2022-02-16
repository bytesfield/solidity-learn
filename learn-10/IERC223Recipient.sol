// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

/**
 * @title Contract that will work with ERC223 tokens.
 */

abstract contract IERC223Recipient {
    struct ERC223TransferInfo {
        address token_contract;
        address sender;
        uint256 value;
        bytes data;
    }

    ERC223TransferInfo private token;

    /**
     * @dev Standard ERC223 function that will handle incoming token transfers.
     *
     * @param _from  Token sender address.
     * @param _value Amount of tokens.
     * @param _data  Transaction metadata.
     */
    function tokenReceived(
        address _from,
        uint256 _value,
        bytes memory _data
    ) public virtual {
        /**
         * @dev Note that inside of the token transaction handler the actual sender of token transfer is accessible via the tkn.sender variable
         * (analogue of msg.sender for Ether transfers)
         *
         * token.value - is the amount of transferred tokens
         * token.data  - is the "metadata" of token transfer
         * token.token_contract is most likely equal to msg.sender because the token contract typically invokes this function
         */
        token.token_contract = msg.sender;
        token.sender = _from;
        token.value = _value;
        token.data = _data;
    }
}
