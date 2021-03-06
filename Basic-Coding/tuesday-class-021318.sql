/* **********************************************
 * Simple Table Creation - Columns and Primary Keys
 *
 * Emergency Service & Product
 * Specification Document 1
 * Version 1.0.0
 *
 * Author: Dan Gilleland
 ********************************************** */

-- Select the CREATE DATABASE stement below to create the demo database.
-- CREATE DATABASE [ESP-A01]

USE [ESP-A01] -- this is a statement that tells us to switch to a particular database
-- Notice in the database name above, it is "wrapped" in square brackets because 
-- the name had a hypen in it. 
-- For all our other objects (tables, columns, etc), we won't use hypens or spaces, so
-- the use of square brackets are optional.
GO  -- this statement helps to "separate" various DDL statements in our script
    -- so that they are executed as "blocks" of code.

/* DROP TABLE statements (to "clean up" the database for re-creation)  */
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'OrderDetails')
    DROP TABLE OrderDetails
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'InventoryItems')
    DROP TABLE InventoryItems
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Orders')
    DROP TABLE Orders
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Customers')
    DROP TABLE Customers

-- drop LIFO(last in first out)

-- To create a database table, we use the CREATE TABLE statement.
-- Note that the order in which we create/drop tables is important
-- because of how the tables are related via Foreign Keys.
CREATE TABLE Customers
(
    -- The body of a CREATE TABLE will identify a comma-separated list of
    -- Column Declarations and Table Constraints.
    CustomerNumber  int
        -- The following is a PRIMARY KEY constraint that has a specific name
        -- Primary Key constraints ensure a row of data being added to the table
        -- will have to have a unique value for the Primary Key column(s)
        CONSTRAINT PK_Customers_CustomerNumber
            PRIMARY KEY
        -- IDENTITY means the database will generate a unique whole-number
        -- value for this column
        IDENTITY(100, 1) -- The first number is the "seed",
                         -- and the last number is the "increment"
                                        NOT NULL, -- NOT NULL means the data is required
    FirstName       varchar(50)         NOT NULL,
    LastName        varchar(60)         NOT NULL,
    [Address]       varchar(40)         NOT NULL,
    City            varchar(35)         NOT NULL,
    Province        char(2)
        CONSTRAINT DF_Customers_Province
            DEFAULT ('AB')
        CONSTRAINT CK_Customers_Province
            CHECK (Province = 'AB' OR
                   Province = 'BC' OR
                   Province = 'SK' OR
                   Province = 'MB' OR
                   Province = 'QC' OR
                   Province = 'ON' OR
                   Province = 'NT' OR
                   Province = 'NS' OR
                   Province = 'NB' OR
                   Province = 'NL' OR
                   Province = 'YK' OR
                   Province = 'NU' OR
                   Province = 'PE')
                                    NOT NULL,
    PostalCode      char(6)
        CONSTRAINT CK_Customers_PostalCode
            CHECK (PostalCode LIKE '[A-Z][0-9][A-Z][0-9][A-Z][0-9]')
                                    NOT NULL,
    PhoneNumber     char(13)
        CONSTRAINT CK_Customers_PhoneNumber
            CHECK (PhoneNumber LIKE '([0-9][0-9][0-9])[0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]')
                                        NULL  -- NULL means the data is optional
)

CREATE TABLE Orders
(
    OrderNumber     int
        CONSTRAINT PK_Orders_OrderNumber
            PRIMARY KEY
        IDENTITY(200, 1)                NOT NULL,
    CustomerNumber  int
        -- Foreign Key constraints ensure that when a row of data is being
        -- inserted or updated, there is a row in the referenced table
        -- that has the same value as its Primary Key
        CONSTRAINT FK_Orders_CustomerNumber_Customers_CustomerNumber
            FOREIGN KEY REFERENCES
            Customers(CustomerNumber)   NOT NULL,
    [Date]          datetime            NOT NULL,
    Subtotal        money
        CONSTRAINT CK_Orders_Subtotal
            CHECK (Subtotal > 0)        NOT NULL,
    GST             money
        CONSTRAINT CK_Orders_GST
            CHECK (GST >= 0)            NOT NULL,
    Total           AS Subtotal + GST   -- This is now a Computed Column
)

CREATE TABLE InventoryItems
(
    ItemNumber          varchar(5)
        CONSTRAINT PK_InventoryItems_ItemNumber
        PRIMARY KEY                         NOT NULL,
    ItemDescription     varchar(50)         NULL,
    CurrentSalePrice    money
        CONSTRAINT CK_InventoryItem_CurrentSalePrice
            CHECK (CurrentSalePrice > 0)    NOT NULL,
    InStockCount        int                 NOT NULL,
    ReorderLevel        int                 NOT NULL
)

CREATE TABLE OrderDetails
(
    OrderNumber         int
        CONSTRAINT  FK_OrderDetails_OrderNumber_Orders_OrderNumber
            FOREIGN KEY REFERENCES
            Orders(OrderNumber)             NOT NULL,
    ItemNumber          varchar(5)
        CONSTRAINT  FK_OrderDetails_ItemNumber_InventoryItems_ItemNumber
            FOREIGN KEY REFERENCES
            InventoryItems(ItemNumber)      NOT NULL,
    Quantity			int
		CONSTRAINT DF_OrderDetails_Quantity
			DEFAULT (1)
		CONSTRAINT CK_OrderDetails_Quantity
			CHECK (Quantity > 0)			NOT NULL,
	SellingPrice		money
		CONSTRAINT CK_OrderDetails_SellingPrice
			CHECK (SellingPrice  >=0)		NOT NULL,
	Amount AS Quantity * SellingPrice,


    CONSTRAINT PK_OrderDetail_OrderNumber_ItemNumber
        PRIMARY KEY (OrderNumber, ItemNumber) -- specify all the columns in the PK
)

/**
    change requests for spec 1
        perform table changes through ALTER statements
        syntax for ALTER TABLE can be found at
    http://msdn.microsoft.com/en-us/library/ms190273.aspx
    ALTER TABLE statements allow us to change an existing table without 
    having to drop it or lose information in the table
**/

-- A) allow address, city, province, and postal code to be NULL

ALTER TABLE Customers
    ALTER COLUMN [Address] varchar (40) NULL
GO -- this statement helps to "separate" various DDL statements in our script. it's oprional

ALTER TABLE Customers
    ALTER COLUMN City varchar (35) NULL
GO

ALTER TABLE Customers
    ALTER COLUMN Province char (2) NULL
GO

ALTER TABLE Customers
    ALTER COLUMN PostalCode char(6) NULL
GO

-- B) add a check constraint on the first and last name to require at least two letters.
--		% is a wildcard for zero or more characters (letter, digit or other character)
--		_ is a wildcard for a single character (letter, digit or other character)
--		[] are used to represent a range or set of characters that are allowed

IF OBJECT_ID ('CK_Customers_FirstName', 'C') IS NOT NULL
	ALTER TABLE Customers DROP CONSTRAINT CK_Customers_FirstName
	
ALTER TABLE Customer
	ADD CONSTRAINT CK_Customers_FirstName
		CHECK (FirstName LIKE '[A-Z][A-Z]%')	 

--	C) add a default constraint on the orders.date column to use the current date
--		GETDATE() is a global function in the SQL server database
--		GETDATE() will obtain the current date/time on the database server

IF OBJECT_ID ('DF_Orders_Date', 'C') IS NOT NULL
	ALTER TABLE Orders DROP CONSTRAINT DF_Orders_Date
	
ALTER TABLE Orders
	ADD CONSTRAINT DF_Orders_Date
		DEFAULT GETDATE() FOR [Date]
GO

-- D) Change the InventoryItems.ItemDescription column to be NOT NULL
--		but: we have described the ItemDescription as allowing NULL values.
--		That means we might have data in the table where the ItemDescription doesn't exist/
--		If we try to make that column NOT NULL, what will we do about
--		the existing data in the database where it is "empty">>
--		we can fix that by updating the data in the database
--		where that description is missing.

UPDATE		InventoryItems
	SET		ItemDescription = '-missing-'
	WHERE	ItemDescription IS NULL
GO

-- now we can change the ItemDescription to be required (NOT NULL)
ALTER TABLE InventoryItems
	ALTER COLUMN ItemDescription varchar (50) NOT NULL
GO

--	E) add indexes to the customer's first and last name columns
--	as well as to the item's description column
--	indexes improve the performance of the database when retrieving information
CREATE NONCLUSTERED INDEX IX_Customer_FirstName
	ON	Customers(FirstName)
CREATE NONCLUSTERED INDEX IX_Customer_LastName
	ON	Customers(LastName)
CREATE NONCLUSTERED INDEX IX_InventoryItems_ItemDescription
	ON	InventoryItems(ItemDescription)
GO -- End of a batch of instructions



-- next class: we will move the INSERT statements to another part of the script 



-- Let's insert a few rows of data for the tables
PRINT 'Inserting customer data'
INSERT INTO Customers(FirstName, LastName, [Address], City, PostalCode)
    VALUES ('Clark', 'Kent', '344 Clinton Street', 'Metropolis', 'S0S0N0')
INSERT INTO Customers(FirstName, LastName, [Address], City, PostalCode)
    VALUES ('Jimmy', 'Olsen', '242 River Close', 'Bakerline', 'B4K3R1')


PRINT 'Inserting an order'
INSERT INTO Orders(CustomerNumber, [Date], Subtotal, GST)
    VALUES (100, GETDATE(), 17.45, 0.87)