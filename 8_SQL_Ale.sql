/* There are some useful functions in MS SQL Server that are interesting to know. 
COALESCE() returns the first NON-null value from the given list */
SELECT COALESCE(NULL, NULL, 'NOT Null', NULL, 'ALE');
SELECT COALESCE(NULL, NULL, NULL, NULL, 'ALE');

SELECT Title, MiddleName, COALESCE(Title, MiddleName)
FROM Person.Person;
-- It returns the first value of both given (considering them in each row). If both are null
-- then it's a null value.

-- NULLIF() tests 2 expression and returns null if both are equal. If not, it returns 
-- the first one. The syntax is NULLIF(expression1, expression 2)
SELECT NULLIF(14, 12)
SELECT NULLIF(14,14)	--Null
SELECT NULLIF('ALE', 'ALE')	--	Null
SELECT NULLIF('ALE', 'Miguel')

-- CONVERT() is used to convert a value to one type to another. It can be very usefull.
SELECT StandardCost, CONVERT(int, StandardCost) AS ConvType
FROM Production.Product;
-- The data type is money, which has 2 decimals. We convert it to integer.

SELECT StandardCost, CONVERT(nvarchar(20), StandardCost) AS ConvType
FROM Production.Product;	-- Now as a string.

-- IIF() takes 3 arguments and tests the first. If it's true retuns the 2nd argument, if 
-- it's not, returns the 3rd. IIF(test_condition, arg2, arg3).
SELECT ProductId, StandardCost, ListPrice, IIF(ListPrice >= StandardCost, 'Profit', 'Losses') 
FROM Production.Product;

/* Finally, we'll see how the HAVING clause works. This is a very import clause. It's used 
mostly to filter records of aggregate functions where the GROUPBY clause is used. */

SELECT MAX(StandardCost) AS MaxCost
FROM Production.Product;
-- WHERE MAX(StandardCost) > 0; 
/* Error message: An aggregate may not appear in the WHERE clause unless it is 
in a subquery contained in a HAVING clause or a select list, and the column being 
aggregated is an outer reference.

So we can't use WHERE with an aggregator. We need to use HAVING instead. */
SELECT MAX(StandardCost) AS MaxCost
FROM Production.Product
HAVING MAX(StandardCost) > 0; 

SELECT DueDate, SUM(OrderQty) AS TotalOrdPerDate
FROM Purchasing.PurchaseOrderDetail
WHERE YEAR(DueDate) > 2011 AND MONTH(DueDate) > 9
GROUP BY DueDate
ORDER BY DueDate DESC;
-- We are not applying the WHERE clause to the aggregator, so it works fine.
-- If we had WHERE YEAR(DueDate) > 2011 AND MONTH(DueDate) > 9 AND SUM(OrderQty) > 6000
-- then it wouldn't work

SELECT DueDate, SUM(OrderQty) AS TotalOrdPerDate
FROM Purchasing.PurchaseOrderDetail
GROUP BY DueDate
HAVING YEAR(DueDate) > 200
ORDER BY DueDate DESC;
-- But we could have also used HAVING instead of WHERE.

-- Another option for the first query is combining HAVING and WHERE clauses.
SELECT DueDate, SUM(OrderQty) AS TotalOrdPerDate
FROM Purchasing.PurchaseOrderDetail
WHERE YEAR(DueDate) > 2011 AND MONTH(DueDate) > 9
GROUP BY DueDate
HAVING SUM(OrderQty) < 6000
ORDER BY DueDate DESC;