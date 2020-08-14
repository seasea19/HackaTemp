pragma solidity ^0.4.22;
contract Election {
    struct Candidate{
        string name;
        uint voteCount;
        
    }
    
   struct Voter {
       bool authorized;
       bool voted;
       uint vote;
   } 
    
    
    address public owner; //whoever deploys the contract is its owner
    string public electionName;
     uint Numcandidate;
    
    mapping(address=> Voter)  public voters;  //like a dictionnary
    Candidate[] public candidates;
    uint public totalVotes;
    
    modifier ownerOnly() {   //only the owner of the contract can add and modify
      require(msg.sender== owner) ;
         _; // this represents the rest of the function body
    }
    
    function Election(string _name) public {  //the constructor's name same as contract's
        owner = msg.sender; //msg object is a Solidity global variable that says send the deployer's address to the owner variable
        electionName = _name;    
        
    } 
    
    function addCandidate(string _name) ownerOnly public {
        candidates.push(Candidate(_name, 0));
        
    }
    
    function getNumCandidate() public view returns (uint){//returns used to return smth
      Numcandidate=candidates.length;
        return Numcandidate ;
    } 
    
    function authorize(address _person) ownerOnly public {
        voters[_person].authorized= true;
    }
    
    function vote(uint _voteIndex) public {
        require(!voters[msg.sender].voted); //he didn't vote yet
        require(!voters[msg.sender].authorized==true); //he's authorized t vote
        
        voters[msg.sender].vote = _voteIndex;
        voters[msg.sender].voted = true;
        
        candidates[_voteIndex].voteCount+=1;
        totalVotes+=1;
    }
    
    function end() ownerOnly public {
        selfdestruct(owner);
    }
    
    
}


