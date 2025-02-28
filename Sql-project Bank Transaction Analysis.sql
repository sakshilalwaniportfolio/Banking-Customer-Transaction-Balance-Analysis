Create database BANK;

Use Bank;
CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(100),
    age INT,
    city VARCHAR(50),
    account_id INT
);

CREATE TABLE Accounts (
    account_id INT PRIMARY KEY,
    customer_id INT,
    account_type VARCHAR(20),
    balance DECIMAL(10,2),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

CREATE TABLE Transactions (
    transaction_id INT PRIMARY KEY AUTO_INCREMENT,
    account_id INT,
    transaction_type ENUM('Deposit', 'Withdrawal'),
    amount DECIMAL(10,2),
    transaction_date DATE,
    FOREIGN KEY (account_id) REFERENCES Accounts(account_id)
);
INSERT INTO Customers (customer_id, name, age, city, account_id) VALUES
(1, 'Alice Johnson', 32, 'New York', 101),
(2, 'Bob Smith', 45, 'Los Angeles', 102),
(3, 'Charlie Brown', 28, 'Chicago', 103),
(4, 'David Wilson', 35, 'Houston', 104),
(5, 'Eva Davis', 40, 'San Francisco', 105),
(6, 'Frank White', 50, 'Miami', 106),
(7, 'Grace Miller', 29, 'Seattle', 107),
(8, 'Henry Scott', 38, 'Boston', 108),
(9, 'Isabel Thomas', 41, 'Denver', 109),
(10, 'Jack Harris', 33, 'Atlanta', 110),
(11, 'Kelly Adams', 36, 'Dallas', 111),
(12, 'Liam Brown', 47, 'Austin', 112),
(13, 'Mia Moore', 27, 'San Diego', 113),
(14, 'Noah Parker', 39, 'Las Vegas', 114),
(15, 'Olivia Clark', 42, 'Portland', 115),
(16, 'Paul Turner', 34, 'Philadelphia', 116),
(17, 'Quinn Carter', 30, 'San Jose', 117),
(18, 'Ryan Hill', 43, 'Nashville', 118),
(19, 'Sophia Green', 31, 'Minneapolis', 119),
(20, 'Thomas Baker', 49, 'Indianapolis', 120);


INSERT INTO Transactions (account_id, transaction_type, amount, transaction_date) VALUES
(101, 'Deposit', 2000.00, '2024-01-10'),
(101, 'Withdrawal', 500.00, '2024-01-15'),
(102, 'Deposit', 5000.00, '2024-01-12'),
(102, 'Withdrawal', 1200.00, '2024-01-18'),
(103, 'Deposit', 1500.00, '2024-01-05'),
(103, 'Withdrawal', 750.00, '2024-01-20'),
(104, 'Deposit', 4000.00, '2024-01-08'),
(104, 'Withdrawal', 2000.00, '2024-01-22'),
(105, 'Deposit', 1000.00, '2024-01-14'),
(105, 'Withdrawal', 500.00, '2024-01-25'),
(106, 'Deposit', 3000.00, '2024-01-16'),
(106, 'Withdrawal', 600.00, '2024-01-28'),
(107, 'Deposit', 4500.00, '2024-01-19'),
(107, 'Withdrawal', 1800.00, '2024-01-30'),
(108, 'Deposit', 2500.00, '2024-01-21'),
(108, 'Withdrawal', 950.00, '2024-02-01'),
(109, 'Deposit', 7000.00, '2024-01-23'),
(109, 'Withdrawal', 2200.00, '2024-02-03'),
(110, 'Deposit', 2000.00, '2024-01-25'),
(110, 'Withdrawal', 1000.00, '2024-02-05');

#Questions
-- Q1: Retrieve all customer names and their cities
SELECT name, city FROM Customers;

-- Q2: Show all transactions with types and amounts
SELECT transaction_type, amount FROM Transactions;

-- Q3: Retrieve unique account types
SELECT DISTINCT account_type FROM Accounts;

-- Q4: List all customers above 35 years
SELECT * FROM Customers WHERE age > 35;

-- Q5: Retrieve the top 5 highest balances
SELECT * FROM Accounts ORDER BY balance DESC LIMIT 5;

-- Q6: Get the 3 most recent transactions
SELECT * FROM Transactions ORDER BY transaction_date DESC LIMIT 3;

-- Q7: Find customers whose names start with 'A'
SELECT * FROM Customers WHERE name LIKE 'A%';

-- Q8: Retrieve withdrawals > $1,000
SELECT * FROM Transactions WHERE transaction_type = 'Withdrawal' AND amount > 1000;

-- Q9: Get customer names and their account types
SELECT c.name, a.account_type FROM Customers c JOIN Accounts a ON c.account_id = a.account_id;

-- Q10: List all transactions with the account balance after each transaction
SELECT t.account_id, t.transaction_type, t.amount, a.balance FROM Transactions t JOIN Accounts a ON t.account_id = a.account_id;

-- Q11: Find all deposits by customers from 'New York'
SELECT c.name, t.transaction_type, t.amount FROM Customers c
JOIN Accounts a ON c.account_id = a.account_id
JOIN Transactions t ON a.account_id = t.account_id
WHERE c.city = 'New York' AND t.transaction_type = 'Deposit';

-- Q12: Count the total number of transactions
SELECT COUNT(*) AS total_transactions FROM Transactions;

-- Q13: Find total amount deposited
SELECT SUM(amount) AS total_deposits FROM Transactions WHERE transaction_type = 'Deposit';

-- Q14: Find the average account balance
SELECT AVG(balance) AS avg_balance FROM Accounts;

-- Q15: Get the highest and lowest withdrawal amounts
SELECT MAX(amount) AS max_withdrawal, MIN(amount) AS min_withdrawal FROM Transactions WHERE transaction_type = 'Withdrawal';

-- Q16: Count total accounts per account type
SELECT account_type, COUNT(*) AS total_accounts FROM Accounts GROUP BY account_type;

-- Q17: Show total transactions per customer
SELECT c.name, COUNT(t.transaction_id) AS total_transactions FROM Customers c
JOIN Accounts a ON c.account_id = a.account_id
JOIN Transactions t ON a.account_id = t.account_id
GROUP BY c.name;

-- Q18: Find customers who deposited more than $10,000
SELECT c.name, SUM(t.amount) AS total_deposits FROM Customers c
JOIN Accounts a ON c.account_id = a.account_id
JOIN Transactions t ON a.account_id = t.account_id
WHERE t.transaction_type = 'Deposit'
GROUP BY c.name HAVING SUM(t.amount) > 10000;

-- Q19: Find customers with the highest balance
SELECT name, balance FROM Customers c
JOIN Accounts a ON c.account_id = a.account_id
WHERE balance = (SELECT MAX(balance) FROM Accounts);

-- Q20: Retrieve customers who have never made a withdrawal
SELECT c.name FROM Customers c
JOIN Accounts a ON c.account_id = a.account_id
LEFT JOIN Transactions t ON a.account_id = t.account_id AND t.transaction_type = 'Withdrawal'
WHERE t.transaction_id IS NULL;
