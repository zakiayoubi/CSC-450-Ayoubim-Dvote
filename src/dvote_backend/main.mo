import HashMap "mo:base/HashMap";
import Text "mo:base/Text";
import Set "mo:base/OrderedSet"; 

actor VotingSystem {

    // Creating a HashMap to store candidate names (keys) and their vote counts (values)
    var candidatesMap = HashMap.HashMap<Text, Nat>(5, Text.equal, Text.hash);

    // Create an OrderedSet to track voter IDs (unique voter identification)
    let voterSet = Set.Make<Text>(Text.compare); //: Operations<Nat>
    
    // Create an empty set for tracking voters
    stable var usedVoters : Set.Set<Text> = voterSet.empty();  // Set to store voter IDs
    
    // Register a candidate with initial vote count of 0
    public func registerCandidate(candidateName: Text) : async () {
        // Check if the candidate is already registered
        if (candidatesMap.get(candidateName) != null) {
            return ();  // Candidate already exists, no need to register again
        };
        // Register the candidate with 0 votes initially
        candidatesMap.put(candidateName, 0);
    };

    // Vote for a candidate
    public func voteForCandidate(voterId: Text, candidateName: Text) : async ?Text {
        // Check if the voter has already voted by looking in the usedVoters set
        let hasVoted = voterSet.contains(usedVoters, voterId);
        if (hasVoted) {
            return ?("Voter has already voted!");  // Deny vote if voter has already voted
        };

        // Retrieve the candidate's current vote count
        let result = candidatesMap.get(candidateName);
        
        // Use switch to handle the optional value
        switch result {
            case (?currentVotes) {
                // If candidate is found, increment their vote count
                candidatesMap.put(candidateName, currentVotes + 1);
                
                // Add the voter ID to the set to track that they have voted
                usedVoters := voterSet.put(usedVoters, voterId);  // Correctly update usedVoters

                return null;  // Voting was successful
            };
            case null {
                // If candidate is not found, return an error message
                return ?("Candidate not found!");
            };
        };
    };

    // Get the current vote count for a candidate
    public func getVoteCount(candidateName: Text) : async ?Nat {
        // Retrieve the current vote count for the candidate
        let result = candidatesMap.get(candidateName);
        if (result == null) {
            return null;  // Candidate not found, return null
        } else {
            return result;  // Return the current vote count
        }
    };
};
