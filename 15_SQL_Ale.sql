/* Now we learnt how to make queries, then how to create tables, and now we'll see how 
to insert records into the table, with the INSERT statement. The syntax is
INSERT INTO tableName(col1, col2, etc) VALUES(val1, val2, etc)
To insert in all the columns of a table
INSERT INTO VALUES(val1, val2, etc)

We had created before the table retail.Stores, where the StoreId col was filled with the
IDENTITY numbers. We can right click on the table -> proporties, and see that the field
Identity is marked as true. */

INSERT INTO retail.Stores 
(
	StoreNumber,
	PhoneNumber,
	Email,
	Address,
	City,
	State,
	ZipCode
)
VALUES
(
	'St1234',
	'+34 659305932',
	'lendel96@gmail.com',
	'South Street, 123',
	'Madrid',
	'C. Madrid',
	28027
);

-- Checking the created record
SELECT * 
FROM retail.Stores;

-- If we want to add data just for a few columns
INSERT INTO retail.Stores 
(
	StoreNumber,
	Address,
	City,
	ZipCode
)
VALUES
(
	'St12354',
	'East Street, 223',
	'Madrid',
	28027
);

/* Reminder. To insert records for all the columns,  we could
INSERT INTO retail.Stores 
VALUES
(
	'St1234',
	'+34 659305932',
	'lendel96@gmail.com',
	'South Street, 123',
	'Madrid',
	'C. Madrid',
	28027
); */

-- This time we'll try to insert in a table with constraints.
-- Reminder. The table StoreProds has StoreName and ProdId wich can't be NULLs. 
-- The first column has to be Varchar and the second one INT. Also, they are both
-- PKs.

INSERT INTO retail.StoreProds2(StoreId, StoreName, ProdId, Threshold)
VALUES (123, 'Ale Store', 666, 10);

SELECT * FROM retail.StoreProds2
-- Is we try to insert the same values, we get error, because we can't repeat records
-- in the primary key.
-- Note that we dont have to specify the columns after the INSERT TO, in the same order
-- they were created.

/* Now we'll insert records in the Child table. If we remember the conditions before,
the record we want to insert, must be present in the Parent table first, in order to 
create it in the Child table.
To see an example, we'll use the ItemStatus table, which was the Parent and, ProductDetails
which was the child. ItemId was the PK in the PT and ProductId was FK in the CT.
Note that ProductDescription was defined wrong, and has a length of 1. We could DROP the 
table and CREATE it again, or it can be directly modified, but we'll see that later.
*/

INSERT INTO retail.ItemStatus (ItemQty, ItemStatus)
VALUES (160, 0)
SELECT * FROM retail.ItemStatus
-- ItemStatus is BIT, so it can accept 1, 0 or null.

INSERT INTO retail.ProductDetails 
(ProductName, ProductCode, ProductStdCost, ProductDescription, ProductListPrice)
VALUES
('Product 1', 'P-001', 150, 'Its a great product', 200);
SELECT * FROM retail.ProductDetails
-- The FK (ProductId) was created with the IDENTITY command. So when we INSERT all the data
-- there's a ProductId = 1 (CT), matching the ItemId = 1 (PT).

INSERT INTO retail.ProductDetails 
(ProductName, ProductCode, ProductStdCost, ProductDescription, ProductListPrice)
VALUES
('Product 2', 'P-002', 200, 'Its an awesome product', 250);
-- But here we get an error, because the FK in the CT doesn't match any of the records in 
-- the PK of the PT.
-- To fix this, we'll create a second record in the PT, and then we can insert Product2.

-- Another important thing to note is that failed attempts count in the ProductId. It has 
-- IDENTITY, so each failed attempt will sum 1 to the column. If we try to INSERT object 2
-- before creating it in the PT, then we'll have to execute twice in the PT, because the 
-- next ProductId in the CT will be 3 and not 2 (2 was the failed attempt).

/* After inserting the records, we might want to change something. This can be done with
the UPDATE statement. The syntax is
UPDATE tableName
SET 
col1 = val1,
col2 = val2,
...
WHERE optionalCondition; */

SELECT * FROM retail.Stores;
-- We have 3 records.

UPDATE retail.Stores
SET
StoreNumber = 'Ale333'
WHERE StoreId = 2; 

UPDATE retail.Stores
SET
Address = 'Southeast Street, 333'
WHERE StoreId = 3;

SELECT * FROM retail.ItemStatus;

UPDATE retail.ItemStatus
SET
ItemQty = 300
WHERE ItemId = 4;

UPDATE retail.ItemStatus
SET 
ItemQty = ItemQty + 1;
-- If we don't specify a rule, the UPDATE affects all the columns