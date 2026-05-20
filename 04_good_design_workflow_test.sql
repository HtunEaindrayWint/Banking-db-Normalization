-- Workflow Script for DBMS Solution
-- =========================================
-- DBMS WORKFLOW
-- Update customer address in one place only
-- =========================================

UPDATE customers
SET address = 'No.99, Inya Road, Yangon'
WHERE customer_id = 'C001';

-- Check consistent result through joins
SELECT 
    c.customer_id,
    c.customer_name,
    c.address,
    a.account_type,
    a.balance,
    l.loan_type,
    l.outstanding_amount,
    cc.card_number,
    cc.card_type
FROM customers c
LEFT JOIN accounts a ON c.customer_id = a.customer_id
LEFT JOIN loans l ON c.customer_id = l.customer_id
LEFT JOIN credit_cards cc ON c.customer_id = cc.customer_id
WHERE c.customer_id = 'C001';

DROP VIEW IF EXISTS vw_customer_banking_profile;

-- View for Easy Demonstration
CREATE VIEW vw_customer_banking_profile AS
SELECT
    c.customer_id,
    c.customer_name,
    c.address,
    c.phone,
    a.account_id,
    a.account_type,
    a.balance,
    l.loan_id,
    l.loan_type,
    l.loan_amount,
    l.outstanding_amount,
    cc.card_id,
    cc.card_number,
    cc.card_type,
    cc.credit_limit
FROM customers c
LEFT JOIN accounts a ON c.customer_id = a.customer_id
LEFT JOIN loans l ON c.customer_id = l.customer_id
LEFT JOIN credit_cards cc ON c.customer_id = cc.customer_id;

SELECT * FROM vw_customer_banking_profile WHERE customer_id = 'C001';

-- Test Cases
-- Reset old data for C001

USE bad_bankingdb;

UPDATE account_file
SET address = 'No.10, Pyay Road, Yangon'
WHERE customer_id = 'C001';

UPDATE loan_file
SET address = 'No.10, Pyay Road, Yangon'
WHERE customer_id = 'C001';

UPDATE credit_card_file
SET address = 'No.10, Pyay Road, Yangon'
WHERE customer_id = 'C001';

-- Update only account file
UPDATE account_file
SET address = 'No.99, Inya Road, Yangon'
WHERE customer_id = 'C001';

-- Verify inconsistency
SELECT 'ACCOUNT FILE' AS source, address
FROM account_file
WHERE customer_id = 'C001'
UNION ALL
SELECT 'LOAN FILE' AS source, address
FROM loan_file
WHERE customer_id = 'C001'
UNION ALL
SELECT 'CREDIT CARD FILE' AS source, address
FROM credit_card_file
WHERE customer_id = 'C001';

-- Test Case 2: Consistency in DBMS design
USE good_bankingdb;
-- Reset centralized data
UPDATE customers
SET address = 'No.10, Pyay Road, Yangon'
WHERE customer_id = 'C001';

-- Update once
UPDATE customers
SET address = 'No.99, Inya Road, Yangon'
WHERE customer_id = 'C001';

-- Verify consistency
SELECT 
    c.customer_id,
    c.customer_name,
    c.address,
    a.account_type,
    l.loan_type,
    cc.card_type
FROM customers c
LEFT JOIN accounts a ON c.customer_id = a.customer_id
LEFT JOIN loans l ON c.customer_id = l.customer_id
LEFT JOIN credit_cards cc ON c.customer_id = cc.customer_id
WHERE c.customer_id = 'C001';
