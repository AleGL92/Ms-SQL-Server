/* Here we will see how the ORDER BY clause works. It's used to sort the results 
We have to specify ASC/DESC, but by default it's ASC. NULLS, if present, will be 
considered lowest values. */
SELECT JobCandidateId, ModifiedDate
FROM HumanResources.JobCandidate
ORDER BY ModifiedDate DESC;
-- Execution order was: FROM -> WHERE -> SELECT -> ORDER BY

-- To get the TOP 3 candidates (in the order defined)
SELECT TOP 3 JobCandidateId, ModifiedDate
FROM HumanResources.JobCandidate
ORDER BY ModifiedDate DESC;

-- To sort the by the AddressId
SELECT AddressId, CONCAT(AddressLine1, ' ', AddressLine2, ' ', City, ' ', StateProvinceID,  ' ',
			  PostalCode) AS PostalAddress
FROM Person.Address
ORDER BY AddressID

SELECT ProductID, Name, StandardCost, ListPrice
FROM Production.Product
ORDER BY StandardCost ASC, ListPrice DESC;
-- This means that if we get 2 identical values for StandardCost, then the rows will 
-- be sorted by ListPrice in descending order.

-- To avoid zeros in the classification, we'll repeat the query, using WHERE clause
SELECT ProductID, Name, StandardCost, ListPrice
FROM Production.Product
WHERE StandardCost > 0 AND ListPrice > 0
ORDER BY StandardCost DESC, ListPrice DESC;
-- We can order by column number, which is useful sometimes.
-- ORDER BY 4;		-- Column n4 would be ListPrice in our SELECT clause

-- When using the ORDER BY clause, it's not necessary that the column that sets the 
-- order is in the SELECT clause. 
SELECT BusinessEntityID, NationalIDNumber, HireDate
FROM HumanResources.Employee
ORDER BY Birthdate DESC;

SELECT AddressID, AddressLine1
FROM Person.Address
ORDER BY LEN(AddressLine1) ASC;		-- Functions can also be used.

-- FETCH and OFFSET are used to limit the number of rows in the results
SELECT BusinessEntityID, NationalIDNumber, HireDate
FROM HumanResources.Employee
ORDER BY HireDate ASC
-- To skip the first 5 results. They will be excluded.
OFFSET 5 ROWS
-- then, to get just the next 20 folowing results
FETCH NEXT 20 ROWS ONLY;

-- To get the 5 most recent employees
SELECT BusinessEntityID, NationalIDNumber, HireDate
FROM HumanResources.Employee
ORDER BY HireDate DESC
OFFSET 0 ROWS
FETCH NEXT 5 ROWS ONLY;
--or
SELECT TOP 5 BusinessEntityID, NationalIDNumber, HireDate
FROM HumanResources.Employee
ORDER BY HireDate;
-- To use FETCH, we should have OFFSET before.
-- The second query is more efficient, as we dont need to offset anything.

-- In a similar way as the previous query, we want now to get the top 2 products
SELECT TOP 2 ProductId, Name, StandardCost
FROM Production.Product
ORDER BY StandardCost DESC;
-- But the first 2 results have both the same StandardCost. To avoid this we can use WITH TIES

SELECT TOP 2 WITH TIES ProductId, Name, StandardCost
FROM Production.Product
ORDER BY StandardCost DESC;
-- We get 5 results, that have all the same StandardCost

-- Now we have this query to get number of orders in descending number
SELECT TOP 3 WITH TIES SalesOrderId, SalesOrderDetailID, OrderQty
FROM Sales.SalesOrderDetail
ORDER BY OrderQty DESC;

-- But we could also be interested in getting TOP numbers by percent
SELECT TOP 10 PERCENT SalesOrderId, SalesOrderDetailID, OrderQty
FROM Sales.SalesOrderDetail
ORDER BY OrderQty DESC;
-- From 121.317 rows, we got 12.131 as result

-- Now we'll see the GROUP BY clause. It's used for aggregations, combining values from
-- one or more rows into a single value. 
SELECT SalesOrderID, OrderQty
FROM Sales.SalesOrderDetail;
-- There are many SalesOrderID repeated with different OrderQty, so we can group them,
-- by adding them with SUM() in the SELECT clause.
SELECT SalesOrderID, sum(OrderQty)
FROM Sales.SalesOrderDetail
GROUP BY SalesOrderId;

SELECT GroupName
FROM HumanResources.Department
GROUP BY GroupName;
-- We dont have any aggregated values, so we dont get error when executing this query.
-- The result is a column of all the unique names.

-- This time we want to know how many of each unique value
SELECT GroupName, COUNT(GroupName) AS NumTimes
FROM HumanResources.Department
GROUP BY GroupName;

-- This is another example of GROUP BY clause. PayFrequency is 1 or 2, so we can group
-- both values. Once we group by 1's and 2's, we have to aggregate, so we will sum them.
SELECT PayFrequency, Rate 
FROM HumanResources.EmployeePayHistory;

SELECT PayFrequency, SUM(Rate) AS TotalRatePerPayFreq
FROM HumanResources.EmployeePayHistory
GROUP BY PayFrequency
-- Then we can order the results
ORDER BY PayFrequency DESC;
-- Reminder: GROUP BY goes before than ORDER BY clause.

-- Another example, using products in shelfs
SELECT ProductID, Shelf, Quantity
FROM Production.ProductInventory;
-- If we run this query, we can see that there is more than one row for each ProdutId,
-- but also, more than one Shelf, for each ProductId. So we can't just group by ProductId
-- as the aggregation of Shelf could be possible.

SELECT ProductID, Shelf, SUM(Quantity) AS SumQuant
FROM Production.ProductInventory
GROUP BY ProductID, Shelf		-- We specify 2 columns to group
ORDER BY ProductID;
