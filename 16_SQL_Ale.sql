/* Here we'll see about VIEWS. It's a visual table, dependant on the main table. 
Normally we use them to encapsulate the Main table, protecting it, as a security mecanism,
also to run a query multiple times or to avoid storing permanent data. */

SELECT ISS.ItemId, ISS.ItemQty, PD.ProductName, PD.ProductCode, PD.ProductListPrice
FROM retail.ItemStatus ISS
	INNER JOIN
retail.ProductDetails PD
ON ISS.ItemId = PD.ProductId;
-- We get 2 records.

-- But we want to use the previous query to find just those records that have a NULL value
-- in the ItemStatus table. So first of all, we'll update to have a NULL.
SELECT * FROM retail.ItemStatus;
-- There are 7 records in total, we change ItemId to have a NULL

UPDATE retail.ItemStatus
SET ItemStatus = NULL
WHERE ItemId = 6;

-- We run the query again, this time using the WHERE clause to filter.
SELECT ISS.ItemId, ISS.ItemQty, PD.ProductName, PD.ProductCode, PD.ProductListPrice
FROM retail.ItemStatus ISS
	INNER JOIN
retail.ProductDetails PD
ON ISS.ItemId = PD.ProductId
WHERE ISS.ItemStatus IS NULL;

-- If we want to repeat many times this query to find Items that are inactive or missing
-- then we can create a VIEW. It's also useful to hide the query from certain type of users.
CREATE VIEW vwMissingItems AS
SELECT ISS.ItemId, ISS.ItemQty, PD.ProductName, PD.ProductCode, PD.ProductListPrice
FROM retail.ItemStatus ISS
	INNER JOIN
retail.ProductDetails PD
ON ISS.ItemId = PD.ProductId
WHERE ISS.ItemStatus IS NULL;

-- Once the VIEW is created, we can run it directly.
SELECT itemId FROM vwMissingItems;
-- Or we could get all the columns in it.
SELECT * FROM vwMissingItems;

-- To see the views, we go to the Object Explorer -> Views folder. By default the views are
-- created on the dbo schema, but we could change it when creating them.
-- CREATE VIEW vwMissingItems AS

-- To delete a VIEW, we use DROP VIEW.
DROP VIEW vwMissingItems;

-- The CREATE OR ALTER VIEW is used to create a new one if the views it doesn't exist and, 
-- if it exists, it will be modified.
CREATE OR ALTER VIEW vwMissingItems AS
SELECT ISS.ItemId, ISS.ItemQty, PD.ProductName, PD.ProductCode, PD.ProductListPrice
FROM retail.ItemStatus ISS
	INNER JOIN
retail.ProductDetails PD
ON ISS.ItemId = PD.ProductId
WHERE ISS.ItemStatus IS NOT NULL;
-- This VIEW gets the NOT NULLs insted of NULLs

SELECT * FROM vwMissingItems;

/* The SELECT INTO statement is used to create a new table from an existing table.
The syntax is
SELECT * INTO newTable FROM oldTable;
and if we dont want all the columns, we can select some of them
SELECT Col1, Col2,... INTO newTable FROM oldTable;
It's possible to add WHERE clauses, to give a condition
SELECT * INTO newTable FROM oldTable WHERE Condition;
SELECT Col1, Col2,... INTO newTable FROM oldTable WHERE Condition; */

SELECT * FROM retail.StoreProds2;
SELECT * INTO retail.NewStoreProds FROM retail.StoreProds2;
-- Note that PKs aren't copied, neither indexes.

-- If we give a wrong condition, the table will be created empty. It can be useful.
SELECT * INTO retail.NewStoreProdsEmpty FROM retail.StoreProds2
WHERE 1 = 0;

-- To copy just some records
SELECT * INTO retail.NewStoreProdsCond FROM retail.StoreProds2
WHERE StoreId = 123;

SELECT * FROM retail.NewStoreProdsCond;

-- It's also possible to copy from multiple tables.
SELECT iss.ItemId, pd.ProductName INTO retail.NewTableMultiTables
FROM retail.ItemStatus iss
	LEFT JOIN
retail.ProductDetails pd
ON iss.ItemId = pd.ProductId;

SELECT * FROM retail.NewTableMultiTables;

-- We can also copy from different databases
SELECT * INTO retail.Department FROM
AdventureWorks2019.HumanResources.Department;

SELECT * FROM retail.Department;

/* If we want to insert (copy) records from a table to an existing table, we can use
INSERT into with SELECT statement. Before we inserted to a new table, now to an existing
table. We could also add a condition, like we did with INSERT INTO. */

SELECT * FROM retail.NewStoreProdsEmpty;
SELECT * FROM retail.NewStoreProds;
SELECT * FROM retail.ProductDetails;

-- Let's try to insert into NewStoreProdsEmpty
INSERT INTO retail.NewStoreProdsEmpty SELECT * FROM retail.NewStoreProds;
-- If we check after running the line, we'll see the records have been copied.

INSERT INTO retail.ProductDetails (ProductName, ProductCode, ProductStdCost, 
ProductListPrice)
SELECT ProductName, ProductCode, ProductStdCost, ProductListPrice 
FROM retail.ProductDetails;