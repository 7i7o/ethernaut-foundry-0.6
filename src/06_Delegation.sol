// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

contract Delegate {
    address public owner;

    constructor(address _owner) public {
        owner = _owner;
    }

    function pwn() public {
        owner = msg.sender;
    }
}

contract Delegation {
    address public owner;
    Delegate delegate;

    constructor(address _delegateAddress) public {
        delegate = Delegate(_delegateAddress);
        owner = msg.sender;
    }

    fallback() external {
        (bool result, ) = address(delegate).delegatecall(msg.data);
        if (result) {
            this;
        }
    }

    function msgdataSelector() public view returns (bytes memory) {
        return abi.encodeWithSelector(delegate.pwn.selector);
        // 0xdd365b8b
    }

    function msgdataBytes4() public pure returns (bytes4) {
        return bytes4(keccak256("pwn()"));
        // 0xdd365b8b
    }

    function msgdataBytes32() public pure returns (bytes32) {
        return keccak256("pwn()");
        // 0xdd365b8b
    }
}
