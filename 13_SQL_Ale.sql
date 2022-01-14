/* Until now we have created table without any constraints. Let's see how to do it when 
using some constraints. Constraints are restrictions or limitations on a table/column.
The syntax is.
CREATE TABLE tableName
(
column1 dataType1 constraint1,
column2 dataType2 constraint2,
..
)
There are many types.
a. NOT NULL
b. UNIQUE		-- The column would have only distinct values
c. CHECK		-- It's used to apply a condition to the records in that column
d. DEFAULT		-- If there's no other value, by default it will have the one indicated
e. PRIMARY KEY	-- Relation between tables
d. FOREIGN KEY	-- Relation between tables

Now we'll see them with more detail. */

-- NOT NULL. If we dont want to have NULLS in the column, then we should add this constraint.
-- If we open Object Explorer and look for the column StoreId, we can see it has int type
-- but also, not null as constraint.
-- This is because we created the column with auto increment (Identity), and in this cases
-- the columns are created automatically NOT NULL. All the others can contain NULLs.

-- We'll create the table again, using restrictions this time.
CREATE TABLE retail.NotNullStores
(
  StoreId INT IDENTITY,
  StoreNumber Varchar(50) NOT NULL,
  PhoneNumber CHAR(14) NOT NULL,
  Email Varchar(50) NOT NULL,
  Address Varchar(120)  NOT NULL,
  City Varchar(40)  NOT NULL,
  State Varchar(10) NOT NULL,
  ZipCode INT NOT NULL
);
-- If any records are inserted, they can't have NULL values.

-- CHECK constraint applies a condition, and the values only appear if the condition is
-- satisfied. In this way, when the table is created or modified, some values only appear
-- depending on the condition.

CREATE TABLE retail.CheckItems
(
	ItemId INT IDENTITY,
	ItemName Varchar(255) NOT NULL UNIQUE,
	MinQty INT CHECK (MinQty >= 10)
);

-- If we want to apply a condition to more than one column
CREATE TABLE retail.CheckItems2
(
	ItemId INT IDENTITY,
	ItemName Varchar(255) NOT NULL UNIQUE,
	MinQty INT,
	CONSTRAINT CHK_CheckItems2_MinQty_ItemName CHECK(MinQty >= 10 
	AND ItemName <> 'General Store')
);
-- Note that the name of the CONSTRAINT CHK_CheckItems2_MinQty could be any other word,
-- but, as in all queries, it's always better to give meaningful names.

-- The UNIQUE constraint is used to have only unique values on the column.
CREATE TABLE retail.UniqueStores
(
  StoreId INT IDENTITY,
  StoreNumber Varchar(50) NOT NULL UNIQUE,
  PhoneNumber CHAR(14) NOT NULL,
  Email Varchar(50) NOT NULL,
  Address Varchar(120)  NOT NULL,
  City Varchar(40)  NOT NULL,
  State Varchar(10) NOT NULL,
  ZipCode INT NOT NULL
);

CREATE TABLE retail.UniqueStores
(
  StoreId INT IDENTITY,
  StoreNumber Varchar(50) NOT NULL UNIQUE,
  PhoneNumber CHAR(14) NOT NULL UNIQUE,
  Email Varchar(50) NOT NULL,
  Address Varchar(120)  NOT NULL,
  City Varchar(40)  NOT NULL,
  State Varchar(10) NOT NULL,
  ZipCode INT NOT NULL,
  CONSTRAINT Mail_City_Uniques UNIQUE (Email, City)
  --UNIQUE (Email, City) 
);
-- We can have several columns with the UNIQUE constraint, but also write the columns as
-- a list, giving it a name if we want.

DROP TABLE retail.UniqueStores		
-- If we want to try different constraints creating the table, we have to delete the existing.
-- To see the unique keys created from these constraints, we have to access to the keys folder
-- in the object explorer. It's better to declare the constraint using the CONSTRAINT constraintName
-- (col1, col2, etc), because it let's name it, and then we can see the name from the key folder.

-- Here we will see how the DEFAULT constraint works. It adds a default value for a column when
-- no value is inserted for that column.
CREATE TABLE retail.DefaultItems
(
	ItemId INT IDENTITY,
	ItemName Varchar(255) NOT NULL DEFAULT 'AleItem',
	MinQty INT
);

CREATE TABLE retail.DefaultStore
(
	StoreId INT NOT NULL,
	StoreName Varchar(255) NOT NULL,
	StoreOrderDate datetime DEFAULT getdate()
);
-- getdate functions get's the default date from the system.