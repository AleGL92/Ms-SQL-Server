/* In this code, we'll see how JOINS work. They're used to combine columns from different
tables. It's a very important concept from SQL. There are different types of JOINS.
The syntax for a implicit join is:
SELECT col1, col2, etc
FROM TableA, table B
WHERE condition;
It's called implicit because we're not using the JOIN keyword. */
SELECT Purchasing.PurchaseOrderDetail.PurchaseOrderId,
		PurchaseOrderDetailId,
		OrderQty
		OrderDate,
		POH.ShipDate
FROM Purchasing.PurchaseOrderDetail, Purchasing.PurchaseOrderHeader AS POH 
WHERE Purchasing.PurchaseOrderDetail.PurchaseOrderId = POH.PurchaseOrderId;
-- When the name of the column appears in 2 or more tables, we have to specify the 
-- table before the column. It's useful to specify the alias, and it makes the code cleaner.

/* Another type of join is the INNER JOIN. It returns only the matching records for 
both tables. It's preferable to use an INNER JOIN instead of an implicit join. Although
both give the same result, inner join makes the code clearer. The syntax is:
SELECT tA.col1, tA.col2, tB.col1, tB.col2,...
FROM tableA ta
	INNER JOIN
table B tb
ON ta.col1 = tb.col1;

As we can see from the syntax, there has to be a primary key to join both tables correctly.
The primary key is a unique number or character for each row. It could be an ID number 
or a password. So each row in the table has one. If another table has the same primary key,
we could link these 2 tables with join, as if they were just one table.
Keys will be explained later in detail, but this is enough for now. 
A Venn diagram of the inner join has just the inner or matching part. */

SELECT POD.PurchaseOrderId,
		PurchaseOrderDetailId,
		OrderQty,
		OrderDate,
		POH.ShipDate
FROM Purchasing.PurchaseOrderDetail AS POD
	INNER JOIN
	--JOIN		-- Is valid aswell
Purchasing.PurchaseOrderHeader AS POH
ON POD.PurchaseOrderId = POH.PurchaseOrderId
WHERE YEAR(OrderDate) = 2014;

SELECT P.ProductId, P.Name, PC.ProductCategoryId, PC.Name, PSC.ProductSubCategoryId
FROM Production.Product AS P
	INNER JOIN
Production.ProductSubcategory AS PSC
ON PSC.ProductSubcategoryID = P.ProductSubcategoryID
	INNER JOIN
Production.ProductCategory AS PC
ON PC.ProductCategoryId = PSC.ProductCategoryId;
-- This way it's possible to join 2 more tables.

/* Let's see how LEFT JOINs work. They return all the records from the left table and only
the matching records from the right table. When the record doesn't match, the result given
is NULL. It's also called left outer join.
The syntax is similar to other joins:
SELECT tA.col1, tA.col2, tB.col1, tB.col2,...
FROM tableA tA
	LEFT JOIN
tableB tB
ON tA.col1 = tBcol1;
In the Venn diagram, we have all the left part and the inner part. */
SELECT C.CustomerId, PCC.BusinessEntityId, C.StoreId, PCC.CreditCardId
FROM Sales.Customer C
	LEFT JOIN
Sales.PersonCreditCard PCC
ON C.CustomerId = PCC.BusinessEntityID
--ORDER BY BusinessEntityId ASC;
ORDER BY C.CustomerId ASC;
-- We want to get all the records from the customer table, and from the PersonCreditCard
-- table, just those who match.

-- Now we want to compare PersonId against BusinessId, using the same columns
SELECT C.PersonId, PCC.BusinessEntityId, C.StoreId, PCC.CreditCardId
FROM Sales.Customer C
	LEFT JOIN
Sales.PersonCreditCard PCC
ON C.PersonId = PCC.BusinessEntityID;
-- As expected, we get NULL values in the joined columns whenever there's not a match.
-- But also if there are any NULLs in the left table, they appear aswell, but they wont 
-- have any match with the joined table.

-- In this queries we can see there are a lot of null values in PersonId ()
SELECT PersonID
FROM Sales.Customer
-- We have 19.820 rows

SELECT COUNT(PersonID)
FROM Sales.Customer
WHERE PersonId IS NOT NULL;
-- But here we have 19.119 rows, meaning there are 701 NULLs in person ID.
-- Note that the nulls can't be counted, so we counted the non nulls.

-- To directly avoid the nulls in the query.
SELECT C.PersonId, PCC.BusinessEntityId, C.StoreId, PCC.CreditCardId
FROM Sales.Customer C
	LEFT JOIN
Sales.PersonCreditCard PCC
ON C.PersonId = PCC.BusinessEntityID
WHERE C.PersonId IS NOT NULL;
-- And again, we get 19.119 rows
-- Reminder. In the LEFT JOIN the left table is the first one. Order is important.

/* Another way to join is the RIGHT JOIN. The syntax is the same as the LEFT JOIN, but this
time we're keeping all the columns of the right table, and only the matches from  the left
table. 
Note that it's the same as the left join but keeping the right table, so most times we don't
use the right join and we use left join. */

SELECT C.CustomerId, PCC.BusinessEntityId, C.StoreId, PCC.CreditCardId
FROM Sales.Customer C
	RIGHT JOIN
Sales.PersonCreditCard PCC
ON C.CustomerId = PCC.BusinessEntityId;

-- The combination of a LEFT JOIN and a RIGHT JOIN, is a FULL JOIN. This takes all the 
-- records in the left table, all the matches and all the records in the right table.
-- When there's not a match, the value will be NULL.
-- The syntax is as usual, but specifying FULL JOIN instead.
-- The Venn diagram would take be all the parts. FULL OUTER JOIN also works.

SELECT C.CustomerId, PCC.BusinessEntityId, C.StoreId, PCC.CreditCardId
FROM Sales.Customer C
	FULL JOIN
Sales.PersonCreditCard PCC
ON C.CustomerId = PCC.BusinessEntityId;
-- This time we have 28.981, as we got the all the possible records.

/* The last join is CROSS JOIN. It combines each record from one table, with each record
of another table. This means that the number of records in one table, is multiplied by
the number of rules from the other table. 
In practical scenarios it's preferable to avoid using cross join, specially when the tables
have a large amount of data. 
The syntax is:
SELECT * FROM table1, table2;
or
SELECT * FROM table 1 CROSS JOIN table2; */

SELECT *
FROM HumanResources.Employee;

SELECT COUNT(*)
FROM HumanResources.Employee;
-- 290 rows, which is not that much. We dont want to hung the computer.

SELECT COUNT(*)
FROM HumanResources.Department;

SELECT * FROM HumanResources.Employee, HumanResources.Department;
-- We combine each row of the first table, with each row of the second table.
-- 290*16 = 4640
SELECT * FROM HumanResources.Employee CROSS JOIN HumanResources.Department;