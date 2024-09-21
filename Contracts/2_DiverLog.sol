// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

contract DiverLog {

    struct DiveLogType {
        uint diveCount;
        string[] places;
    }

    address owner;
    mapping(address=>bool) diveMaster;
    mapping(address=>DiveLogType) diveLog;

    constructor() {
        owner = msg.sender;
    }

    event DiveLog(address indexed diver, uint newDiveCount);

    function logDive(address diver, string memory placeId) public {
        require(diveMaster[msg.sender], "You are not authorized!");
        DiveLogType storage diveLogType = diveLog[diver];
        diveLogType.diveCount++;
        diveLogType.places.push(placeId);

        emit DiveLog(diver, diveLogType.diveCount);
    }

    function getDiveLog(address diver) public view returns(DiveLogType memory) {
        return diveLog[diver];
    }

    function setDiveMaster(address diveMasterAddress) external {
        require(msg.sender == owner, "You are not authorized!");
        diveMaster[diveMasterAddress] = true;
    }
}