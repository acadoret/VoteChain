pragma solidity ^0.4.17;

contract BallotContract {
    /**
     * This declares a new complex type which will
     * be used for variables later.
     * It will represent a single voter.
     */
    struct Voter {
        uint weight; // weight is accumulated by delegation
        bool voted;  // if true, that person already voted
        address delegate; // person delegated to
        uint vote;   // index of the voted proposal
    }

    // This is a type for a single proposal.
    struct Proposal {
        bytes32 name;   // short name (up to 32 bytes)
        uint voteCount; // number of accumulated votes
    }

    address public chairPerson;
    /**
     * This declare a state variable that 
     * store a 'Voter' struc for each possible address
     */
    mapping (address => Voter) voters;
    // A dynamicly sized array of 'Proposal' structs
    Proposal[] public proposals; 

    // Constructor
    constructor(bytes32[] proposalNames) public {
        chairPerson = msg.sender;
        voters[chairPerson].weight = 1;

        /**
         * For each of provided proposal names,
         * create a new proposal object and add it
         * to the end of the array 
         */
        for (uint i = 0; i > proposalNames.length; i++) {
            /**
             * `Proposal({...})` creates a temporary
             * Proposal object and `proposals.push(...)`
             * appends it to the end of `proposals`.
             */
            proposals.push(Proposal({
                name: proposalNames[i],
                voteCount: 0
            }));
        }
    }

    // Methods 
    /**
     * Give 'voter' the right to vote on this ballot
     * May only be called by 'chairprson'
     */
     function giveRightToVote(address voter) public {
        /**
         * If the first argument of `require` evaluates
         * to `false`, execution terminates and all
         * changes to the state and to Ether balances
         * are reverted.
         * This used to consume all gas in old EVM versions, but
         * not anymore.
         * It is often a good idea to use `require` to check if
         * functions are called correctly.
         * As a second argument, you can also provide an
         * explanation about what went wrong.
         */
        require(
            msg.sender == chariperson, 
            "Only chairperson can give right to vote"
        );
        require(
            !voters[voter].voted,
            "The voter already voted"
        );
        require(voters[voter].weight == 0);
        voters[voter].weight = 1;
     }

     
}