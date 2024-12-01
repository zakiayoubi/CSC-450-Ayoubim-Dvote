# CSC 450: Update Requirements and Software Development<sup>1</sup>

## **Software Requirements Specification (SRS)**

### **1. Requirements Overview**  
This document specifies the requirements for a blockchain-based voting system built using the Internet Computer Protocol (ICP). The system allows users to vote securely and transparently while ensuring that vote data is immutable.

---

### **2. Requirements Table**

| **Number** | **Statement** | **Evaluation Method** | **Dependency** | **Priority** | **Requirement Revision History** |
|------------|---------------|------------------------|----------------|--------------|-----------------------------------|
| **R-001**  | The system must allow users to vote for one of two candidates. | Perform a functional test by voting for each candidate and verifying the vote count updates accordingly. | None | Essential | `2024-12-01`: Added to specify the primary voting feature. |
| **R-002**  | Votes must be stored on the ICP blockchain to ensure immutability. | Check the blockchain ledger to confirm votes are recorded correctly and are tamper-proof. | R-001 | Essential | `2024-12-01`: Ensures secure vote storage. |
| **R-003**  | The frontend must display real-time vote counts for both candidates. | Verify the user interface updates immediately after a vote is cast. | R-001 | High | `2024-12-01`: Added for user transparency. |
| **R-004**  | The system must prevent duplicate votes from the same user. | Attempt to vote multiple times with the same user ID and confirm that only the first vote is recorded. | R-002 | High | `2024-12-01`: Added for voting integrity. |
| **R-005**  | The system must provide a user-friendly frontend for casting votes. | Conduct user testing to confirm the frontend is intuitive and easy to navigate. | None | Middle | `2024-12-01`: Added for usability enhancement. |
| **R-006**  | The system must generate unique user IDs and track used IDs to prevent reuse. | Verify that IDs are unique and cannot be reused by inspecting the `OrderedSet` used in the implementation. | None | High | `2024-12-01`: Ensures secure user identification. |
| **R-007**  | Ensure the voting application works cross-platform (tested on WSL, Ubuntu, and Windows). | Test the application in multiple environments and confirm functionality. | R-001, R-002, R-005 | Middle | `2024-12-01`: Added for platform compatibility. |
| **R-008**  | Provide detailed error messages for invalid user actions (e.g., duplicate voting attempts). | Simulate invalid actions and check for appropriate error messages in the frontend and backend logs. | R-004 | Low | `2024-12-01`: Added for better debugging and user feedback. |
| **R-009**  | The system must log votes with a timestamp on the blockchain. | Inspect the blockchain ledger and confirm that each vote entry includes a timestamp. | R-002 | If time permits | `2024-12-01`: Added for auditability. |
| **R-010**  | Implement basic security measures to prevent unauthorized access to the voting system. | Conduct security tests by simulating unauthorized access attempts. | R-001, R-002 | Middle | `2024-12-01`: Added for enhanced security. |

---

### **3. Core Requirements for Initial Development**
- **Essential**: R-001, R-002, R-003, R-004  
- **High**: R-006, R-005  
These requirements form the foundational features of the voting system and must be implemented first.

---

### **4. Revision History**

| **Date**      | **Change Description**                         | **Reason**                           |
|---------------|-----------------------------------------------|--------------------------------------|
| `2024-12-01`  | Added core functional requirements (R-001 to R-004). | Establish basic functionality.       |
| `2024-12-01`  | Added usability and security requirements (R-005 to R-010). | Enhance user experience and ensure system security. |

---
