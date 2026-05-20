Database Redundancy and Inconsistency Demonstration (Banking Context)
This project demonstrates the real-world issues of Data Redundancy (duplicated data) and Data Inconsistency (conflicting data) commonly found in traditional file systems or unnormalized database designs. It also showcases how to resolve these issues using RDBMS (Relational Database Management System) techniques and Database Normalization.

The Problem (Unnormalized Design)
In bad_bankingdb, customer details (Name, Address, Phone) are repeatedly stored across separate tables: account_file, loan_file, and credit_card_file.

[Bad Banking Database Diagram](bad banking db.png)

When a customer updates their address, the change is only applied to one file (e.g., account_file). Because the other tables remain unchanged, the database falls into a state of Data Inconsistency, where the same customer has different addresses across different departments.

The Solution (Normalized RDBMS Design)
In good_bankingdb, the architecture is redesigned using Database Normalization (up to 3NF) principles.

[Good Banking Database Diagram](good banking db.png)

Customer details are isolated into a single customers table, serving as the Single Source of Truth. Other financial entities (accounts, loans, credit_cards) reference this central table using FOREIGN KEY constraints. Now, a profile update happens in exactly one place, ensuring absolute data consistency across the entire ecosystem automatically.

How to Run the Demonstration
Step 1: Setup Bad Design

Run 01_bad_design_setup.sql to initialize the problematic database and populate it with duplicated sample data.

Step 2: Test Inconsistency

Run 02_bad_design_workflow_test.sql. This simulates a customer updating their address in their account profile only. The UNION ALL query query will expose the resulting data discrepancy.

Step 3: Setup Good Design

Run 03_good_design_setup.sql to deploy the normalized, centralized structure utilizing relational integrity.

Step 4: Test Single Source of Truth

Run 04_good_design_workflow_test.sql. Update the customer address once, and observe how JOIN queries and VIEW structures instantly reflect the correct, unified data across all banking profiles.

Tech Stack & Concepts Covered
Database Engine: MySQL

Architecture: Database Normalization (1NF, 2NF, 3NF)

Data Integrity: Foreign Key Constraints & Cascading Updates (ON UPDATE CASCADE)

Abstractions: Database Views (CREATE VIEW)