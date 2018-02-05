CREATE DATABASE [ESP-A01]
USE [ESP-A01]
GO


IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Orders')
    DROP TABLE Orders
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Customers')
    DROP TABLE Customers

-- added not null and null constraints
-- NOT NULL means that the data is required
-- NULL means that the data is optional

-- added PRIMARY KEY constraints
-- PRIMARY KEY contraints ensure a row of data being added to the table
-- will have to have a unique value for the PRIMARY KEY column(s)

-- added IDENTITY 
-- IDENTITY means the database will generate a unique whole-number value for each column

CREATE TABLE Customers
(
    CustomerNumber  int	
                CONSTRAINT PK_Customers_CustomerNumber PRIMARY KEY
                IDENTITY(100,1)  NOT NULL,
    FirstName       varchar(50)		NOT NULL,
    LastName        varchar(60)		NOT NULL,
    [Address]       varchar(40)		NOT NULL,
    City            varchar(35)		NOT NULL,
    Province        char(2)			NOT NULL,
    PostalCode      char(6)			NOT NULL,	
    PhoneNumber     char(13)		NULL	  
)

-- added FOREIGN KEY (WHY DO THESE THINGS HAVE SUPER LONG NAMES)
-- Foreign Key constraints ensure that when a row of data is being inserted or updated, 
-- there is a row in the referenced table that has the same value as its Primary Key

CREATE TABLE Orders
(
    OrderNumber     int
                CONSTRAINT PK_Orders_OrderNumber PRIMARY KEY
                IDENTITY(200,1)		NOT NULL,
    CustomerNumber  int	
                CONSTRAINT FK_Orders_CustomerNumber_Customers_CustomerNumber FOREIGN KEY REFERENCES Customers(CustomerNumber)
        		NOT NULL,
    [Date]          datetime	NOT NULL,
    Subtotal        money		NOT NULL,
    GST             money		NOT NULL,
    Total           money		NULL
)

GO -- END of a batch of instructions

-- insert data to the tables
PRINT 'INSERTING CUSTOMER DATA'

INSERT INTO Customers(FirstName, LastName, [Address], City, Province, PostalCode)
	VALUES ('Clark', 'Kent', '344 Clinton Street', 'Metropolis', 'DE', 'S0S0S0')
INSERT INTO Customers(FirstName, LastName, [Address], City, Province, PostalCode)
	VALUES ('Jimmy', 'Olsen', '242 River Close', 'Bakerline', 'DE', 'B4k3R1')


PRINT 'INSERTING AN ORDER'

INSERT INTO Orders(CustomerNumber, [Date], Subtotal, GST)
    VALUES (100, GETDATE(), 17.45, 0.87)