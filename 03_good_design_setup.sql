-- DBMS Solution: Centralized Database
-- redesign using normalization.
-- customers = single source of truth
-- accounts = account details only
-- loans = loan details only
-- credit_cards = credit card details only

CREATE DATABASE good_bankingdb;
USE good_bankingdb;
-- =========================================
-- GOOD DESIGN: CENTRALIZED DATABASE
-- =========================================

DROP TABLE IF EXISTS credit_cards;
DROP TABLE IF EXISTS loans;
DROP TABLE IF EXISTS accounts;
DROP TABLE IF EXISTS customers;

CREATE TABLE customers (
    customer_id VARCHAR(20) PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    address VARCHAR(255) NOT NULL,
    phone VARCHAR(30),
    email VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE accounts (
    account_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id VARCHAR(20) NOT NULL,
    account_type VARCHAR(50) NOT NULL,
    balance DECIMAL(12,2) NOT NULL DEFAULT 0,
    opened_date DATE,
    CONSTRAINT fk_accounts_customer
        FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

CREATE TABLE loans (
    loan_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id VARCHAR(20) NOT NULL,
    loan_type VARCHAR(50) NOT NULL,
    loan_amount DECIMAL(12,2) NOT NULL,
    outstanding_amount DECIMAL(12,2) NOT NULL,
    start_date DATE,
    CONSTRAINT fk_loans_customer
        FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

CREATE TABLE credit_cards (
    card_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id VARCHAR(20) NOT NULL,
    card_number VARCHAR(30) NOT NULL UNIQUE,
    card_type VARCHAR(50),
    credit_limit DECIMAL(12,2),
    expiry_date DATE,
    CONSTRAINT fk_cards_customer
        FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

-- =========================================
-- SAMPLE DATA: NORMALIZED DESIGN
-- =========================================

INSERT INTO customers
(customer_id, customer_name, address, phone, email)
VALUES
('C001', 'Aung Aung', 'No.10, Pyay Road, Yangon', '09-111111111', 'aung@example.com'),
('C002', 'Su Su', 'No.22, Hledan Street, Yangon', '09-222222222', 'susu@example.com'),
('C003', 'Kyaw Kyaw', 'No.45, Mandalay Road, Mandalay', '09-333333333', 'kyaw@example.com');

INSERT INTO accounts
(customer_id, account_type, balance, opened_date)
VALUES
('C001', 'Savings', 500000.00, '2024-01-10'),
('C002', 'Current', 1200000.00, '2024-02-15'),
('C003', 'Savings', 300000.00, '2024-03-01');

INSERT INTO loans
(customer_id, loan_type, loan_amount, outstanding_amount, start_date)
VALUES
('C001', 'Home Loan', 10000000.00, 7500000.00, '2024-04-01'),
('C002', 'Car Loan', 5000000.00, 2000000.00, '2024-05-10');

INSERT INTO credit_cards
(customer_id, card_number, card_type, credit_limit, expiry_date)
VALUES
('C001', '4111111111111111', 'Gold', 2000000.00, '2028-12-31'),
('C003', '4222222222222222', 'Classic', 1000000.00, '2027-11-30');
