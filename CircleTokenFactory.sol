import "CircleToken.sol";

contract CircleTokenFactory {

    mapping(address => address[]) public created;
    mapping(address => bool) public isCircleToken; //verify without having to do a bytecode check.
    bytes public circleByteCode;
    uint yearZero;

    function CircleTokenFactory() {
      yearZero = now;
    }

    function createCircleToken(string _name, uint8 _decimals, string _symbol) returns (address) {

        CircleToken newToken = (new CircleToken( _name, _decimals, _symbol, yearZero, msg.sender));
        created[msg.sender].push(address(newToken));
        isHumanToken[address(newToken)] = true;
        return address(newToken);
    }
}
