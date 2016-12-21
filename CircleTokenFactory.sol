pragma solidity ^0.4.0;
import "CircleToken.sol";

contract CircleTokenFactory {

    mapping(address => address[]) public created;
    mapping(address => bool) public isCircleToken; //verify without having to do a bytecode check.
    bytes public circleByteCode;
    uint yearZero;

    function CircleTokenFactory() {
      yearZero = now;
    }

    function createCircleToken(string _name) returns (address) {

        CircleToken newToken = (new CircleToken( _name, yearZero, msg.sender));
        created[msg.sender].push(address(newToken));
        isCircleToken[address(newToken)] = true;
        return address(newToken);
    }
}
