-- When we find NULL values using the WHEN clause, we'll get error. We can avoid it.
SELECT ProductID, Name, Color
FROM Production.Product
WHERE Color IS NULL;

SELECT ProductID, Name, Color
FROM Production.Product
WHERE Color IS NOT NULL;

-- To get particular rows between range1 and range2, we can use BETWEEN operator with the
-- WHERE clause. Note both ranges will be included. NOT BETWEEN can also be used
SELECT ProductID, Name, Color
FROM Production.Product
WHERE ProductID BETWEEN 1 AND 497;

-- We should be careful when using BETWEEN with dates with timestamps
SELECT PurchaseOrderId, ModifiedDate
FROM Purchasing.PurchaseOrderDetail
WHERE ModifiedDate BETWEEN '20140202' AND '20150812'	--YYYYMMDD // Also '2015-08-12' would be right
-- We could also use NOT BETWEEN to get all but the selected dates.
-- The timestamps have hours sometimes, and they have a larger value than just the date.

-- To change a date format
SELECT BusinessEntityID, CAST(BirthDate AS datetime)
FROM HumanResources.Employee;

SELECT BusinessEntityID, CAST(BirthDate AS datetime) AS BirthDateTime
FROM HumanResources.Employee;

SELECT CAST('2020-06-12' AS datetime);		-- CAST can also convert other formats

SELECT CAST(1.234 AS INT)

-- Now we get back to the previous query, where we lose some rows because of the 
-- timestamp, that makes them a higher date.
SELECT PurchaseOrderId, ModifiedDate
FROM Purchasing.PurchaseOrderDetail
WHERE CAST(ModifiedDate AS DATE) BETWEEN '2014-02-02' AND '2015-08-12'
-- Before using CAST function we left out dates like 2015-08-12 12:25:46.233, because
-- we were selecting time 00:00:00.000. Here we cast that row as a date, so the value 
-- gets selected.

/* To select a matching value, we use the IN clause. We also have the NOT IN clause.
It works in a very similar way as in Python */
SELECT ProductId, Name, StandardCost, ListPrice, SafetyStockLevel
FROM Production.Product
WHERE ProductID IN (1, 10, 15, 20);

SELECT *
FROM Person.StateProvince
WHERE StateProvinceCode IN ('AK', 'AZ', 'CO', 'IA', 'ALE');
-- If we just want one result, we could have used WHERE Sta = 'AK'. But to get any of
-- strings specified, we would have to use one OR clause for each one. This is more efficient.
-- Also if we specify a string that doesn't exist, it doesn't appear in the results. As 
-- an example, the 'ALE' is made up, but it doesnt make an error happen.

/* A reminder of the execution order:
FROM [MyTable]
    ON [MyCondition]
  JOIN [MyJoinedTable]
 WHERE [...]
 GROUP BY [...]
HAVING [...]
SELECT [...]
 ORDER BY [...]
 
 A reminder of the concatenations:
 -> When using the '+' operator between strings, if one is null, the resulting value will
 be null also.
 -> When using the CONCAT() function, if one is null, that value will be ignored and the 
 remaining strings will be concatenated.*/