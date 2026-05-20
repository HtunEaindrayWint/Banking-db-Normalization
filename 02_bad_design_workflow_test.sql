-- Workflow Problem
-- Customer updates address only in the Account file.
-- Loan file and credit card file remain unchanged.
-- =========================================
-- WORKFLOW PROBLEM
-- Customer C001 changes address
-- Only account_file is updated
-- =========================================

SELECT * FROM account_file;

SELECT * FROM loan_file;


USE bad_bankingdb;

SET SQL_SAFE_UPDATES = 0;

UPDATE account_file
SET address = 'No.99, Inya Road, Yangon'
WHERE customer_id = 'C001';

-- Check inconsistency

SELECT 'ACCOUNT FILE' AS source, customer_id, customer_name, address
FROM account_file
WHERE customer_id = 'C001'
UNION ALL
SELECT 'LOAN FILE' AS source, customer_id, customer_name, address
FROM loan_file
WHERE customer_id = 'C001'
UNION ALL
SELECT 'CREDIT CARD FILE' AS source, customer_id, customer_name, address
FROM credit_card_file
WHERE customer_id = 'C001';
