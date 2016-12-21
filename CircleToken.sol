/*
This Token Contract implements the standard token functionality (https://github.com/ethereum/EIPs/issues/20) as well as the following OPTIONAL extras intended for use by humans.

In other words. This is intended for deployment in something like a Token Factory or Mist wallet, and then used by humans.
Imagine coins, currencies, shares, voting weight, etc.
Machine-based, rapid creation of many tokens would not necessarily need these extra features or will be minted in other manners.

1) Initial Finite Supply (upon creation one specifies how much is minted).
2) In the absence of a token registry: Optional Decimal, Symbol & Name.
3) Optional approveAndCall() functionality to notify a contract if an approval() has occurred.

.*/

import "StandardToken.sol";

contract CircleToken is StandardToken {

    function () {
        //if ether is sent to this address, send it back.
        throw;
    }

    string public name;                   //fancy name: eg Simon Bucks
    uint8 public decimals;                //How many decimals to show. ie. There could 1000 base units with 3 decimals. Meaning 0.980 SBX = 980 base units. It's like comparing 1 wei to 1 ether.
    uint yearZero;
    address owner;
    uint lastMonth;

    function CircleToken(
        string _tokenName,
        uint8 _decimalUnits,
        uint _yearZero
        address _owner
        ) {
        owner = _owner;
        name = _tokenName;                                   // Set the name for display purposes
        decimals = _decimalUnits;                            // Amount of decimals for display purposes
        yearZero = _yearZero;
        balances[owner] = 1000 * ((10047 ** ((now - yearZero)/1 month))/(1000 ** ((now - yearZero)/1 month)));
        lastMonth = ((now - yearZero)/1 month)
    }

    function payout(){
      for(uint i==0; i =< (((now - yearZero)/1 month) - lastMonth); i++){
        balances[owner] += 1000 * ((10047 ** ((now - yearZero)/1 month))/(1000 ** ((now - yearZero)/1 month)))
      }
      lastMonth = (now - yearZero)/1 month
    }

    /* Approves and then calls the receiving contract */
    function approveAndCall(address _spender, uint256 _value, bytes _extraData) returns (bool success) {
        allowed[msg.sender][_spender] = _value;
        Approval(msg.sender, _spender, _value);

        //call the receiveApproval function on the contract you want to be notified. This crafts the function signature manually so one doesn't have to include a contract in here just for this.
        //receiveApproval(address _from, uint256 _value, address _tokenContract, bytes _extraData)
        //it is assumed that when does this that the call *should* succeed, otherwise one would use vanilla approve instead.
        if(!_spender.call(bytes4(bytes32(sha3("receiveApproval(address,uint256,address,bytes)"))), msg.sender, _value, this, _extraData)) { throw; }
        return true;
    }
}
