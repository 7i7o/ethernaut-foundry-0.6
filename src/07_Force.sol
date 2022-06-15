// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

contract SeekAndDestroy {
    // function pay() public payable {
    //     this;
    // }

    fallback() external payable {}

    function destroyAndSendFundsTo(address to) public {
        selfdestruct(payable(address(to)));
    }
}

contract Force {
    /*
                   MEOW ?
         /\_/\   /
    ____/ o o \
  /~____  =ø= /
 (______)__m_m)

*/
}
