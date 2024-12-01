// import HashMap "mo:base/HashMap";
// import Text "mo:base/Text";

// actor learnHashMap {

//     // Creating a HashMap to store Text (keys) and Nat (values)
//     let map = HashMap.HashMap<Text, Nat>(5, Text.equal, Text.hash);

//     public func addKeyValue(key: Text, value: Nat) : async () {
//         // Insert a key-value pair into the map
//         map.put(key, value);
//     };

//     public func getValue(key: Text) : async ?Nat {
//         // Retrieve a value by its key from the map using if-else
//         let result = map.get(key);
//         if (result == null) {
//             return null;  // Key not found, return null
//         } else {
//             return result;  // Found the key, return the value
//         }
//     };
// };
////////////////////////////////////////////////////////////////////////////

// import HashMap "mo:base/HashMap";
// import Text "mo:base/Text";

// actor VotingSystem {

//     // Creating a HashMap to store candidate names (keys) and their vote counts (values)
//     let candidatesMap = HashMap.HashMap<Text, Nat>(5, Text.equal, Text.hash);

//     // Register a candidate with initial vote count of 0
//     public func registerCandidate(candidateName: Text) : async () {
//         // Check if the candidate is already registered
//         if (candidatesMap.get(candidateName) != null) {
//             return ();  // Candidate already exists, no need to register again
//         };
//         // Register the candidate with 0 votes initially
//         candidatesMap.put(candidateName, 0);
//     };

//     public func voteForCandidate(candidateName: Text) : async ?Text {
//         // Retrieve the candidate's current vote count
//         let result = candidatesMap.get(candidateName);
        
//         // Use switch to handle the optional value
//         switch result {
//             case (?currentVotes) {
//                 // If candidate is found, increment their vote count
//                 candidatesMap.put(candidateName, currentVotes + 1);
//                 return null;  // Voting was successful
//             };
//             case null {
//                 // If candidate is not found, return an error message
//                 return ?("Candidate not found!");
//             };
//         };
//     };
//     // Get the current vote count for a candidate
//     public func getVoteCount(candidateName: Text) : async ?Nat {
//         // Retrieve the current vote count for the candidate
//         let result = candidatesMap.get(candidateName);
//         if (result == null) {
//             return null;  // Candidate not found, return null
//         } else {
//             return result;  // Return the current vote count
//         }
//     };

//     // Get the total number of votes (sum of all candidates' votes)
//     // public func getTotalVotes() : async Nat {
//     //     // Iterate over the map and sum all the votes
//     //     var totalVotes : Nat = 0;
//     //     for (candidateName, voteCount) in candidatesMap.entries() {
//     //         totalVotes += voteCount;
//     //     }
//     //     return totalVotes;
//     // };
// };
//////////////////////////////////////////////////////////////////////

import HashMap "mo:base/HashMap";
import Text "mo:base/Text";
import Set "mo:base/OrderedSet";  // Importing the OrderedSet module

actor VotingSystem {

    // Creating a HashMap to store candidate names (keys) and their vote counts (values)
    let candidatesMap = HashMap.HashMap<Text, Nat>(5, Text.equal, Text.hash);
    
    // Create an OrderedSet to track voter IDs (unique voter identification)
    let voterSet = Set.Make<Text>(Text.compare); // Set of voter IDs (Text)
    
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
