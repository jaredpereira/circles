import "CircleToken.sol";

contract CircleTokenFactory {

    mapping(address => address[]) public created;
    mapping(address => bool) public isHumanToken; //verify without having to do a bytecode check.
    bytes public circleByteCode;
    uint yearZero;

    function CircleTokenFactory() {
      yearZero = now;
    }

    function createCircleToken(string _name, uint8 _decimals, string _symbol) returns (address) {

        CircleToken newToken = (new CircleToken( _name, _decimals, _symbol, yearZero));
        created[msg.sender].push(address(newToken));
        isHumanToken[address(newToken)] = true;
        newToken.transfer(msg.sender, _initialAmount); //the factory will own the created tokens. You must transfer them.
        return address(newToken);
    }
}
