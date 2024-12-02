import { dvote_backend } from 'declarations/dvote_backend';
import './index.scss';

document.querySelector("form").addEventListener("submit", async function (event) {
    event.preventDefault();
    // console.log("submitted.");
    const candidate = document.querySelector('input[name="candidate"]:checked')?.value;
    if (!candidate) {
        alert("Please select a candidate before submitting your vote.");
        return; // Prevent submission if no candidate is selected
    };
    const bNumber = document.getElementById("b-number").value;

    // await dvote_backend.registerCandidate("trump");
    // await dvote_backend.registerCandidate("kamala");

    // Register the vote for the selected candidate
    if (candidate) {
        try {
            const result = await dvote_backend.voteForCandidate(bNumber, candidate);
            // Check if the result is an array (indicating an error message)
            if (Array.isArray(result) && result[0] === "Voter has already voted!") {
                // If the backend returns a denial message, display it to the user
                alert(result[0]);
            } else {
                console.log("Vote registered successfully:", result);
                updateVoteCounts();
            }
        } catch (error) {
            console.error("Error during voting:", error);
        }
    }
});

window.addEventListener("load", async function() {
    await updateVoteCounts();
});

async function updateVoteCounts() {
    try {
        const trumpVotes = await dvote_backend.getVoteCount('trump');
        const kamalaVotes = await dvote_backend.getVoteCount('kamala');
        document.getElementById('trump-votes').textContent = trumpVotes.toString();
        document.getElementById('kamala-votes').textContent = kamalaVotes.toString();
    } catch (error) {
        console.error("Error updating vote counts:", error);
    };
};