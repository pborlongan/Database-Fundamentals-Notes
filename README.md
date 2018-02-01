# Database-Fundamentals-Notes
notes for my database class


-- CREATE DATABASE [ESP-A01]

USE [ESP-A01]


GO -- THIS STATEMENT HELPS TO "SEPARATE" VARIOUS DDL STATEMENTS IN OUR SCRIPT
	-- SO THAT THEY ARE EXECUTED AS "BLOCKS" OF CODE

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = "Orders")
	DROP TABLE Orders
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = "Customers")
	DROP TABLE Customers



-- TO CREATE A DATABSE TABLE, WE USE THE CREATE TABLE STATEMENT
-- NOTE THAT THE ORDER IN WHICH WE CREATE/DROP TAVLE S IS IMPORTANT
-- BECAUSE OF HOW THE TABLES ARE RELATED VIA FOREIGN KEYS


CREATE TABLE Customers
(
	-- The body of A CREATE TABLE will identify a comma-separated list of 
	-- Column Declarations and Table Constraints.

	CustomerNumber int,
	FirstName varchar(50),
	LastName varchar(60),
	[Address] varchar(40),
	City varchar(35),
	Province char(2),
	PostalCode char(6),
	PhoneNumber char(13)
)


CREATE TABLE Orders
(
	OrderNumber int,
	CustomerNumber int,
	Date datetime, 
	Subtotal money,
	GST money,
	Total money
)
