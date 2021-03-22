pragma solidity 0.8.0;
pragma abicoder v2;

contract PlayingAround {

    //@NOTICE this is a basic training, training to addContent and remove content, also querying by Id and full array;


    //@dev creating a list of owners;
    address[] public owners;

    //@dev Same task;
    constructor (address[] memory _owners){
        owners = _owners;
    }

    //@notice Creating our struct and info needed;
    struct Hodlers {
        address from;
        uint amount;
        uint id;
    }

    Hodlers[] hodl;

    //@notice creating the onlyOwners modifier;
    modifier onlyOwners() {
        bool owner = false;
        for(uint i = 0; i < owners.length; i++){
            if(owners[i] == msg.sender){
                owner = true;
            }
        }
        require(owner = true);
        _;
    }

    event NewHolder(address from, uint amount);


    //@notice adding  new Hodler;
    function createHodler(address _from, uint _amount) public onlyOwners{
        hodl.push(Hodlers(_from, _amount, hodl.length));
        emit NewHolder(_from, _amount);
    }

    //@notice getting the hodler array with ALL the hodlers;
    function getHolders() public view onlyOwners returns(Hodlers[] memory){
        return hodl;
    }

        //@notice getting the Hodlers by their specific Index;
      function getHolderById(uint _index) public view onlyOwners returns(uint, address){
          Hodlers memory hodlerToReturn = hodl[_index];
          return (hodlerToReturn.amount, hodlerToReturn.from);
      }

      //@dev testing removing the last holder of the array;
      function removeHolder() public onlyOwners {
          hodl.pop();
      }
