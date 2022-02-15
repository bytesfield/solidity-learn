// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

library Strings {
    function length(string calldata str) external pure returns (uint256) {
        return bytes(str).length;
    }

    //Using abi.encodePacked to convert strings to bytes, strings are array of intergers e.g uint[].
    function concat(string calldata str1, string calldata str2)
        external
        pure
        returns (string memory)
    {
        return string(abi.encodePacked(str1, str2));
    }

    function concatenate(string calldata _base, string calldata _value)
        internal
        pure
        returns (string memory)
    {
        bytes memory _baseBytes = bytes(_base);
        bytes memory _valueBytes = bytes(_value);

        string memory _tmpValue = new string(
            _baseBytes.length + _valueBytes.length
        );
        bytes memory _newValue = bytes(_tmpValue);

        uint256 i;
        uint256 j;

        for (i = 0; i < _baseBytes.length; i++) {
            _newValue[j++] = _baseBytes[i];
        }

        for (i = 0; i < _valueBytes.length; i++) {
            _newValue[j++] = _valueBytes[i];
        }

        return string(_newValue);
    }

    function strpos(string calldata _base, string calldata _value)
        internal
        pure
        returns (int256)
    {
        bytes memory _baseBytes = bytes(_base);
        bytes memory _valueBytes = bytes(_value);

        assert(_valueBytes.length == 1);

        for (uint256 i = 0; i < _baseBytes.length; i++) {
            if (_baseBytes[i] == _valueBytes[0]) {
                return int256(i);
            }
        }

        return -1;
    }

    function reverse(string calldata _str)
        external
        pure
        returns (string memory)
    {
        //converts string to bytes in memory
        bytes memory str = bytes(_str);
        //creates a new temporary string with same length
        string memory tmp = new string(str.length);
        //build a bytes variable based on temp
        bytes memory _reversed = bytes(tmp);

        //iterate on str which is the bytes string
        for (uint256 i = 0; i < str.length; i++) {
            _reversed[str.length - i - 1] = str[i];
        }

        return string(_reversed);
    }

    function compare(string calldata str1, string calldata str2)
        external
        pure
        returns (bool)
    {
        //coverts strings to bytes 32 and pass it to the keccak256 hash algorithm and compare the results
        return
            keccak256(abi.encodePacked(str1)) ==
            keccak256(abi.encodePacked(str2));
    }
}
