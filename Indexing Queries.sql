CREATE DATABASE INDEXING_SQL
USE INDEXING_SQL

--index is a database object that improves the speed of data retrieval operations on a table by providing a structured way to,
--quickly locate and access rows based on the values of one or more columns, without having to scan the entire table.

Create Table SBI_Customers
(
Customer_ID INT PRIMARY KEY,
Customer_Name VARCHAR(50),
Account_Type VARCHAR(20),
Branch_Name VARCHAR(50),
Balance DECIMAL(15,2),
Date_Opened DATE,
Status VARCHAR(15)
)
INSERT INTO SBI_Customers VALUES(1, 'Amit Sharma', 'Savings', 'Mumbai', 50000.00, '2021-01-10', 'Active'),
(2, 'Sunita Patil', 'Current', 'Pune', 150000.00, '2019-05-18', 'Active'),
(3, 'Rajesh Gupta', 'Savings', 'Delhi', 25000.00, '2020-11-20', 'Inactive'),
(4, 'Pooja Mehta', 'Fixed Deposit', 'Mumbai', 200000.00, '2018-07-24', 'Active'),
(5, 'Rahul Kumar', 'Savings', 'Chennai', 40000.00, '2021-02-15', 'Active'),
(6, 'Sneha Reddy', 'Current', 'Hyderabad', 75000.00, '2019-08-10', 'Active'),
(7, 'Arjun Singh', 'Savings', 'Bangalore', 100000.00, '2020-10-11', 'Inactive'),
(8, 'Nikita Joshi', 'Fixed Deposit', 'Pune', 120000.00, '2017-04-15', 'Active'),
(9, 'Suresh Yadav', 'Savings', 'Delhi', 55000.00, '2021-03-22', 'Active'),
(10, 'Anita Nair', 'Current', 'Chennai', 95000.00, '2019-12-10', 'Inactive')

SELECT * FROM SBI_Customers

--Basic to Advanced Index Queries

--1. Creating a Basic Index on a Single Column
-- This index on the branch_name column will speed up queries that filter records based on the branch name.

CREATE INDEX idx_Branch_Name ON SBI_Customers(Branch_Name)

--With the index on branch_name, the query will retrieve records from the 'Mumbai' branch faster than without an index.

SELECT * FROM SBI_Customers WHERE Branch_Name = 'Mumbai'

--2. Creating a Composite Index on Multiple Columns
--This index will improve performance for queries that filter on both account_type and status.

CREATE INDEX idx_Account_Status ON SBI_Customers(Account_Type, Status)

--The composite index on account_type and status will make this query faster by allowing direct lookup.

SELECT * FROM SBI_Customers WHERE Account_Type = 'Savings' AND Status = 'Active'

--3. Creating a Unique Index
--Customer_id is already a primary key, this index enforces uniqueness. Unique indexes also enhance search performance for,
--these columns

CREATE UNIQUE INDEX idx_Unique_Customer_ID ON SBI_Customers(Customer_ID)

--This query will be optimized by the unique index on customer_id, speeding up the search.

SELECT * FROM SBI_Customers WHERE Customer_ID = 2

--4.Using a Partial Index
--A partial index is an index on a subset of rows that meet a specific condition, which saves space and improves performance,
--for conditional queries.

--This index only includes rows where status is 'Active'. Queries searching for balances in active accounts will benefit,
--from this index.

CREATE INDEX idx_Active_Balance ON SBI_Customers(Balance) WHERE Status = 'Active'

SELECT * FROM SBI_Customers WHERE Balance > 50000 AND Status = 'Active'

--The partial index will optimize the performance of queries looking for balances in active accounts specifically.

--5. Dropping an Index
--If an index is no longer needed, it can be dropped to free up space and prevent unnecessary maintenance overhead.

DROP INDEX idx_Branch_Name ON SBI_Customers

SELECT * FROM SBI_Customers

-- Dropping an index will delete it from the database, freeing up resources and potentially improving update and insert,
--speeds for this column.

--6. Using Index Hints To Force Index Usage
--Index hints can direct the database to use a specific index when multiple indexes are available

SELECT * FROM sbi_customers WITH(INDEX(idx_account_status))
WHERE account_type = 'Savings' AND status = 'Active'



