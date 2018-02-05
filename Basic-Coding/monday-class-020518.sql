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

-- added a DEFAULT constraint

CREATE TABLE Customers
(
    CustomerNumber  int	
                CONSTRAINT PK_Customers_CustomerNumber PRIMARY KEY
                IDENTITY(100,1)  NOT NULL,
    FirstName       varchar(50)		NOT NULL,
    LastName        varchar(60)		NOT NULL,
    [Address]       varchar(40)		NOT NULL,
    City            varchar(35)		NOT NULL,
    Province        char(2) 
                    CONSTRAINT DF_Customers_Province
					DEFAULT ('AB')
                    CONSTRAINT CK_Customers_Province
					CHECK ( Province = 'AB' OR
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
					Check (PostalCode LIKE '[A-Z][0-9][A-Z][0-9][A-Z][0-9]') -- checks if the data inserted follows the pattern
                	NOT NULL,	
    PhoneNumber     char(13)
					CONSTRAINT CK_Customers_PhoneNumber
					Check (PhoneNumber LIKE '([0-9][0-9][0-9])[0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]')
                    NULL	  
)

-- added FOREIGN KEY (WHY DO THESE THINGS HAVE SUPER LONG NAMES)
-- Foreign Key constraints ensure that when a row of data is being inserted or updated, 
-- there is a row in the referenced table that has the same value as its Primary Key

-- added CHECK constraint
-- CHECK constraints ensure that a value is correct

CREATE TABLE Orders
(
    OrderNumber     int
                CONSTRAINT PK_Orders_OrderNumber PRIMARY KEY
                IDENTITY(200,1)		NOT NULL,
    CustomerNumber  int	
                CONSTRAINT FK_Orders_CustomerNumber_Customers_CustomerNumber FOREIGN KEY REFERENCES Customers(CustomerNumber)
        		NOT NULL,
    [Date]          datetime	NOT NULL,
    Subtotal        money
                CONSTRAINT CK_Orders_Subtotal
				CHECK (Subtotal > 0)
                NOT NULL,
    GST             money
                CONSTRAINT CK_Orders_GST
                CHECK (GST >= 0)
                NOT NULL,
    Total           AS Subtotal + GST -- this is now a computed column
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


/*
        constraints:
            - null/not null
            - Primary Key
            - Foreign Key
            - Check Key
            - Default Key
*/