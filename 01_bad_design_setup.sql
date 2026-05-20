-- Data redundancy and inconsistency (Banking)
-- Bad design tables to simulate separate files
-- Sample data population
-- Workflow problem script showing inconsistency
-- DBMS solution tables with centralized customer data
-- Workflow script showing single source of truth
-- Test case scripts for training/demo 
-- bad design
-- =========================================
-- BAD DESIGN: SEPARATE FILES
-- =========================================
CREATE DATABASE bad_bankingdb;
USE bad_bankingdb;
DROP TABLE IF EXISTS account_file;
DROP TABLE IF EXISTS loan_file;
DROP TABLE IF EXISTS credit_card_file;

CREATE TABLE account_file (
    account_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id VARCHAR(20) NOT NULL,
    customer_name VARCHAR(100) NOT NULL,
    address VARCHAR(255) NOT NULL,
    phone VARCHAR(30),
    account_type VARCHAR(50),
    balance DECIMAL(12,2)
);

CREATE TABLE loan_file (
    loan_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id VARCHAR(20) NOT NULL,
    customer_name VARCHAR(100) NOT NULL,
    address VARCHAR(255) NOT NULL,
    phone VARCHAR(30),
    loan_type VARCHAR(50),
    loan_amount DECIMAL(12,2),
    outstanding_amount DECIMAL(12,2)
);

CREATE TABLE credit_card_file (
    card_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id VARCHAR(20) NOT NULL,
    customer_name VARCHAR(100) NOT NULL,
    address VARCHAR(255) NOT NULL,
    phone VARCHAR(30),
    card_number VARCHAR(30),
    card_type VARCHAR(50),
    credit_limit DECIMAL(12,2)
);

-- =========================================
-- SAMPLE DATA: DUPLICATED CUSTOMER DATA
-- =========================================

INSERT INTO account_file
(customer_id, customer_name, address, phone, account_type, balance)
VALUES
('C001', 'Aung Aung', 'No.10, Pyay Road, Yangon', '09-111111111', 'Savings', 500000.00),
('C002', 'Su Su', 'No.22, Hledan Street, Yangon', '09-222222222', 'Current', 1200000.00),
('C003', 'Kyaw Kyaw', 'No.45, Mandalay Road, Mandalay', '09-333333333', 'Savings', 300000.00);

INSERT INTO loan_file
(customer_id, customer_name, address, phone, loan_type, loan_amount, outstanding_amount)
VALUES
('C001', 'Aung Aung', 'No.10, Pyay Road, Yangon', '09-111111111', 'Home Loan', 10000000.00, 7500000.00),
('C002', 'Su Su', 'No.22, Hledan Street, Yangon', '09-222222222', 'Car Loan', 5000000.00, 2000000.00);

INSERT INTO credit_card_file
(customer_id, customer_name, address, phone, card_number, card_type, credit_limit)
VALUES
('C001', 'Aung Aung', 'No.10, Pyay Road, Yangon', '09-111111111', '4111111111111111', 'Gold', 2000000.00),
('C003', 'Kyaw Kyaw', 'No.45, Mandalay Road, Mandalay', '09-333333333', '4222222222222222', 'Classic', 1000000.00);
