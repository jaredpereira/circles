contract circlesRegistry
{
  mapping (address => address[]) public trusted;
  mapping (address => mapping (address => Trust)) public isTrusted

  struct Trust {
    bool trusted;
    uint index;
  }

  function circlesRegistry() {
  }

  function trust (address user){
    if (isTrusted[msg.sender][user].trusted != true){
      isTrusted[msg.sender][user].index = isTrusted[msg.sender].length;
      isTrusted[msg.sender][user].trusted = true;
      isTrusted[msg.sender].push[user];
    }
  }
  function revokeTrust (address user) {
    if (isTrusted[msg.sender][user].trusted){
      isTrusted[msg.sender][user].trusted = false;
      trusted[isTrusted[msg.sender][user].index] = 0x0;
    }
  }

  function checkTrust (address[] path) returns(bool) {
    for(uint i = 0; i>path.length - 1; i++){
      if(isTrusted[path[i+1]][path[i].trusted != true])
      {
        return false;
      }
    }
    return true;
  }
}
