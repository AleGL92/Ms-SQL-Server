/* To uniquely identify each record in a table, in order to declare all the Entity
Relationships, meaning the relations between all the tables in the DB.

For instance, we could identify all our clients in a table, where the primary key would 
be an ID Client Number.

Then we could have a table for clients purchases, where the primary key is an 
ID Purchase Number, specific and unique, for each purchase. In this table, all the 
purchases are recognised by this ID Purchase Number. But also, each purchase is related
to the clients through a column, that contains ID Client Number. In this Purchase table, 
ID Client Number would be a foreign key, that can be repeated in different rows (a client
that has more than one purchare order).

Finally we could have another table for all the salesmen working with us. These sales reps
could have, among other columns, the same ID Client Number, specifying the client they 
are working for. Here again, the PK for the clients table, would be a FK.
There should also be a PK, to identify uniquely each sales rep.

Primary keys don't allow NULL values neither repeated values. In each table, there can
only be one PK.*/

CREATE TABLE retail.SinglePKStoreProds
(
StoreID INT PRIMARY KEY,
StoreName Varchar(40) NOT NULL,
ProdID INT NOT NULL
);

CREATE TABLE retail.MultiPKStoreProds
(
StoreID INT,
StoreName Varchar(40) NOT NULL,
ProdID INT,
Threshold SMALLINT,
-- PRIMARY KEY (StoreId, ProdId)
CONSTRAINT PK_Store_Prod PRIMARY KEY (StoreId, ProdId)
);
-- Note that there aren't really 2 PKs in the table. Actually there's just one PK formed
-- by StoredId and ProdId.
-- As we did before, it's better to name the PK constraint.
-- From the Columns folder, we can check the PKs.

/* We continue now with foreign keys. As said before, it refers to a PK in another table,
referencing or linking the child table with the parent table. We need to create first
the PK in the parent table. Then
FOREIGN KEY (col1, col2, etc) REFERENCES parentTable (col1, col2, etc)
There's also another syntax, where we can specify NO ACTION, CASCADE, SET NULL OR
SET DEFAULT, when the action ON DELETE or ON UPDATE has taken place. We'll see more
about them later.

There are some rules that are important in the relation PK-FK
a. If we wish to insert a record in the Child table, then that record must exist
in the Parent table.
b. If we wish to delete a record from the Parent table, which has a linked record in the
child table, then we have to delet first the record from the Child table first.
c. NULLs are allowed in foreign keys. */

-- Let's see an example. First we'll create a Parent table, with a PK, then we'll create
-- a Child table, with a FK.
CREATE TABLE retail.ItemStatus
(
ItemId INT IDENTITY PRIMARY KEY,
ItemQty INT NOT NULL,
ItemStatus BIT	-- BIT contains 1-0 or NULL
);
-- Note that if the key symbol in the Object Explorer is pointing to the left, it means
-- it's a PK. If it's pointing to the right side, it's a FK.

-- Let's create another table and link both. It will have product details.
-- We would also like to link ProductId with ItemId from ItemStatus.
CREATE TABLE retail.ProductDetails
(
ProductId INT IDENTITY,
ProductName VARCHAR(40) NOT NULL,
ProductCode CHAR(10) NOT NULL,
ProductStdCost Money NOT NULL,
ProductDescription VARCHAR(40),
ProductListPrice Money NOT NULL,
CONSTRAINT FK_ProductDetails_ItemStatus_ItemId FOREIGN KEY(ProductId)
REFERENCES retail.ItemStatus(ItemId)
);
-- CONSTRAINT FK_ChildT_ParentT_ParentT PK Column Name FOREIGN KEY (FK in this table)

-- We can also add a PK to the child table
CREATE TABLE retail.ProductDetails2
(
ProductId INT IDENTITY PRIMARY KEY,
ProductName VARCHAR(40) NOT NULL,
-- ProductName VARCHAR(40) PRIMARY KEY,			-- Or maybe we prefer the PK here
ProductCode CHAR(10) NOT NULL,
ProductStdCost Money NOT NULL,
ProductDescription VARCHAR(40),
ProductListPrice Money NOT NULL,
CONSTRAINT FK_ProductDetails_ItemStatus_ItemId FOREIGN KEY(ProductId)
REFERENCES retail.ItemStatus(ItemId)
);

-- Before we saw an example where there is one PK. Now we'll see an example that has 2 PKs.
CREATE TABLE retail.StoreProds
(
StoreId INT,
StoreName Varchar(40) NOT NULL,
ProdId INT NOT NULL UNIQUE,
Threshold SMALLINT,
CONSTRAINT PK_StoreProds PRIMARY KEY (StoreId, ProdId)
);
--DROP TABLE retail.StoreProds

-- Now we create another table and we link a column to one of the previous PKs
CREATE TABLE retail.ProducDemands
(
ProductId INT IDENTITY,
ProductName Varchar(40) NOT NULL,
DemandQty INT,
CONSTRAINT FK_ProductDemands_StoreProds_ProdId FOREIGN KEY(ProductId)
REFERENCES retail.StoreProds(ProdId)
);
-- NOTE that when we use the CONSTRAINT name PRIMARY KEY() syntax, the child table 
-- will give error, trying to link the FK to the PK, unless we specify that the PK column
-- is NOT NULL and UNIQUE, which were necessary characteristics of a PK.

/* Now we'll see more about the UNIQUE INDEX. Indexes are used to select records faster.
It imposes that no duplicate values are allowed for a column.
In the example before, we could't have a PK that wasn't defined ad NOT NULL and UNIQUE.
Another way to avoid that error is using the UNIQUE INDEX. */
CREATE TABLE retail.StoreProds2
(
StoreId INT,
StoreName Varchar(40) NOT NULL,
ProdId INT NOT NULL,
Threshold SMALLINT,
CONSTRAINT Pk_StoreProds_ProdId PRIMARY KEY (ProdId)
);

CREATE UNIQUE INDEX UIDX_ProdId ON retail.StoreProds2(ProdId);

CREATE TABLE retail.ProductDemands2
(
ProductId INT IDENTITY,
ProductName Varchar(40) NOT NULL,
DemandQty INT,
CONSTRAINT FK_ProductDemands2_StoreProds2_ProdId FOREIGN KEY(ProductId)
REFERENCES retail.StoreProds2(ProdId)
);
-- To check for an UNIQUE INDEX, in the Object Explorer, we check the Indexes folder.

-- Sometimes it's not necessary to create an UNIQUE INDEX, and instead, we use an INDEX.
-- We know that indexes are useful to select records faster in the table. The difference
-- is that the second one will allow duplicates.
CREATE INDEX IDX_checkItems_ItemName ON CheckITems(ItemName);