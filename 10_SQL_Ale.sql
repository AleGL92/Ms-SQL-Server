/* Unions can append two or more tables in a single one. It allows to combine multiple 
SELECT statements and, optionally, remove duplicates, combining rows of both tables.
The syntax is: 
SELECT col1, col2, ... FROM table A WHERE condition1
UNION
SELECT col1, col2, ... FROM table B WHERE condition2;
It's important that both SELECT statements have the same number of columns and, in the
same order. 
UNION ALL doest not remove duplicates while UNION does. */

SELECT PurchaseOrderId
FROM Purchasing.PurchaseOrderDetail
	UNION
SELECT PurchaseOrderId
FROM Purchasing.PurchaseOrderHeader
-- Both datatypes are compatible. In this case it's the same datatype.

SELECT PurchaseOrderDetailID 
FROM Purchasing.PurchaseOrderDetail
	UNION
SELECT TaxAmt
FROM Purchasing.PurchaseOrderHeader
ORDER BY PurchaseOrderDetailID ASC;
-- This time, the first has int type, and the second money type. But they are compatible
-- types, as they're both floating comma numbers.

-- Reminder. UNION combines rows and JOIN combines columns.
SELECT BusinessEntityId
FROM HumanResources.Employee
	UNION
SELECT BusinessEntityId
FROM Person.Person
	UNION
SELECT BusinessEntityId
FROM Purchasing.ProductVendor
	UNION
SELECT CustomerId
FROM Sales.Customer
	UNION
SELECT BusinessEntityId
FROM Sales.SalesPerson
-- This will return a massive list containing a different Ids, which would be really useful
-- but for an example is allright. They are all integers, so they are compatible.

-- Now we'll try to combine strings with UNION
SELECT NationalIdNumber
FROM HumanResources.Employee
	UNION
SELECT FirstName
FROM Person.Person

SELECT FirstName + MiddleName + LastName AS FullName
FROM Person.Person
	UNION
SELECT Name
FROM Purchasing.Vendor
ORDER BY FullName;	
-- But we can't order by Name, just by FullName.

-- To order by Name
SELECT Name
FROM Purchasing.Vendor
	UNION
SELECT FirstName + MiddleName + LastName AS FullName
FROM Person.Person
ORDER BY Name DESC;
-- It has to be in the first SELECT to use ORDER BY.

-- This query is repeated. It has 4.012 rows, and we know it has some PurchaseOrderIds
-- that appear in both PurchaseOrderDetail and PurchaseOrderHeader, so using UNION, they
-- were removed from the results.
SELECT PurchaseOrderId
FROM Purchasing.PurchaseOrderDetail
	UNION ALL
SELECT PurchaseOrderId
FROM Purchasing.PurchaseOrderHeader
ORDER BY PurchaseOrderId DESC;
-- But if we use now UNION ALL, we have 12.857 rows, as there are many duplicates.


/* INTERSECT combines distinct rows from multiple tables that are common to both tables.
When using UNION we combine all the the unique rows, but they dont have to be common to both
so if a unique row appears in one table, it will appear in the UNION. With INTERSECT only 
those distinct rows, that are common to both, would appear.
Reminder. DISTINCT clause is used to get all the unique values. If a result is repeated, 
it would only appear once. */
SELECT ProductSubCategoryId
FROM Production.Product
	INTERSECT
SELECT ProductSubCategoryId
FROM Production.ProductSubcategory;
-- We got 37 rows, which are the common to both tables, but also there aren't any duplicates
-- as we just got the distinct results. NULLs will be ignored.
-- When using INTERCEPT, all the queries must have the same number of columns, as if we were
-- working with the UNION clause. For the EXCEPT operator, that will be explained next it
-- has to be the same way.

/* The EXCEPT operator compares multiple tables and returns only distinct results from 
the first query that are not present in the other remaining queries. If we imagine the 
Venn diagram, the intersection between the 2 circles would be empty, as we don't get those
common results. */
SELECT SalesOrderId
FROM Sales.SalesOrderDetail
	EXCEPT
SELECT CustomerId
FROM Sales.Customer;