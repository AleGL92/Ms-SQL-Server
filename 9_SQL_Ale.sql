/* In this code, we'll see how the subqueries are done. */
SELECT NationalIdNumber, JobTitle, HireDate
FROM HumanResources.Employee
WHERE BusinessEntityId IN 
	(SELECT BusinessEntityId
	FROM HumanResources.EmployeeDepartmentHistory
	)
ORDER BY JobTitle;
/* In this query we want to get some columns, but showing only those results that match
the subquery. For instance, we need the NationalIdNumbers of the people who have a 
BusinessEntityId in the History Department. This information is contained in another 
table, and to get it, we use a subquery. We could have also joined tables, but that 
will done later. 
To link 2 different tables, they need to have a primary key. This will be explained 
later aswell.
Note that subqueries are always performed before the main query.
We could have also added conditions to the subquery, like WHERE BunsinessEntityId <= 100 */

-- Subqueries can be in the same table as the main one.
SELECT MIN(UnitPrice)
FROM Purchasing.PurchaseOrderDetail
WHERE UnitPrice IN 
	(SELECT TOP 2 UnitPrice
	FROM Purchasing.PurchaseOrderDetail
	ORDER BY UnitPrice DESC
	);
-- This was probably a strange way to find the second top value in UnitPrice, but 
-- it shows that a subquery doesn't necessary have to be in a separate table.
SELECT TOP 2 UnitPrice
FROM Purchasing.PurchaseOrderDetail
ORDER BY UnitPrice DESC;
-- This actually shows the 2 lowest results, and then we can just see the second lowest.

-- In this query we'll use 2 tables again. We need PurchaseOrderId and UnitPrice for 
-- those prices that are greater than average of the list price from the product table.
-- (First table is Purchasing.PurchaseOrderDetail and the second one is Product table).
SELECT PurchaseOrderID, UnitPrice
FROM Purchasing.PurchaseOrderDetail
WHERE UnitPrice >
	(SELECT AVG(ListPrice)
	FROM Production.Product
	)
-- If we select the inner query we'll see the avg is 438,66. But we're not getting any 
-- results with the outer query, because there aren't any UnitPrices greater.

-- To check if a particular record exists or not, we can use the EXISTS operator.
-- It returns a boolean 0 or 1.
-- We'll check if some columns and rows exist from the folowing queries.
SELECT *
FROM HumanResources.Employee;
SELECT *
FROM HumanResources.Department;

SELECT BusinessEntityId, JobTitle
FROM HumanResources.Employee
WHERE EXISTS
	(SELECT DepartmentId
	FROM HumanResources.Department
	WHERE Name = 'Sales'
	) AND JobTitle LIKE '%Sales%'
/* In the inner query we want the DepartmentId corresponding to Sales. The result gives
that DepartmentId = 3 is for sales. 
Then the EXISTS returns a boolean 1, because we got some result from the inner query.
After this, we add the AND clause. Note that the AND affects the outter query only. 
This is because in the outter query, the WHERE clause would be a boolean 0 or 1 from 
the EXISTS operator, plus the AND with JobTitle LIKE '%Sales%'. */

-- With subqueries we can also do nesting. This means more subqueries can be inside others.
SELECT ProductSubcategoryID
FROM Production.Product
WHERE ProductSubcategoryID IN
	(SELECT ProductSubCategoryID		-- 1st subq
	FROM Production.ProductSubCategory
	WHERE ProductCategoryID IN
		(SELECT ProductCategoryID		--2nd subq
		FROM Production.ProductCategory
		WHERE Name LIKE '%Bikes%'
		)
	);

-- We can also use subqueries as an expression to get details from a table.
-- This way, we can use a subquery as a column expression.
SELECT PurchaseOrderID, TaxAmt
FROM Purchasing.PurchaseOrderHeader;

--SELECT PurchaseOrderID, OrderQty
SELECT PurchaseOrderID, SUM(OrderQty) AS SumOrdQty
FROM Purchasing.PurchaseOrderDetail AS POD
GROUP BY POD.PurchaseOrderID;

SELECT PurchaseOrderID, TaxAmt, 
	(SELECT SUM(OrderQty)
	FROM Purchasing.PurchaseOrderDetail AS POD
	WHERE POD.PurchaseOrderId = POH.PurchaseOrderId
	GROUP BY POD.PurchaseOrderID
	) AS SumOrderQty
FROM Purchasing.PurchaseOrderHeader AS POH
ORDER BY POH.PurchaseOrderId;
/* In the inner query we sum the orders quantity but just considering those 
that match with the orders in the outter query. The ids are the same, so it's
important to use an alias for both FROM clauses.
We also gave an alias to the  subquery, to show it as a column. */

-- It's possible to use a subquery in the FROM clause.
--SELECT PurchaseOrderId, UnitPrice
SELECT PurchaseOrderId, MIN(UnitPrice) AS MinUnitPrice
FROM Purchasing.PurchaseOrderDetail
GROUP BY PurchaseOrderID;
-- In this query we have different unit prices for the same PurchaseOrderId, so
-- we get the minumum value. 

-- But now we would like to know the average of those minimum unit prices.
SELECT AVG(MinUnitPrices) AS AvgMinUnitPrices
FROM
	(SELECT PurchaseOrderId, MIN(UnitPrice) AS MinUnitPrices
	FROM Purchasing.PurchaseOrderDetail
	GROUP BY PurchaseOrderID) AS MinUnitPriceQuery;
-- Note that it's not possible to use 2 aggregators at the same time, like 
-- AVG(MIN(UnitPrice)). It's important to remember that the FROM clause needs to
-- have an alias, in the format above. Otherwise, it will return error.

/* The operator ANY returns TRUE if any value in the subquery matches the given condition
In case the query returns a list of values, if any of them matches the condition, 
then the result for ANY will be TRUE.
The ALL operator is similar but it retunrs TRUE only if all the values in the subquery
meet the condition. */
SELECT PurchaseOrderId, DueDate, UnitPrice
FROM Purchasing.PurchaseOrderDetail
WHERE DueDate >= 
	ANY(SELECT OrderDate
	FROM Purchasing.PurchaseOrderHeader);
-- This way we can compare the DueDate in PurchaseOrderDetail table, against the 
-- order dates in PurchaseOrderHeader. But note that the comparison done here means
-- that if OrderDate is greater or equal than any of the dates in OrderDate, then it
-- will return true, and will be included. We get 8.845 rows as result.

-- If we change the logical operator in the WHERE clause.
SELECT PurchaseOrderId, DueDate, UnitPrice
FROM Purchasing.PurchaseOrderDetail
WHERE DueDate = 
	ANY(SELECT OrderDate
	FROM Purchasing.PurchaseOrderHeader);
-- we get 6.820 rows, meaning not all DueDates appear in the OrderDate rows.

-- Now trying the ALL operator with the '=' operator, we get 0 rows.
SELECT PurchaseOrderId, DueDate, UnitPrice
FROM Purchasing.PurchaseOrderDetail
WHERE DueDate <> 
	ALL(SELECT OrderDate
	FROM Purchasing.PurchaseOrderHeader);
-- Then with the '<>' operator we get 2.025 rows. This means that there aren't any dates
-- in the DueDate column, that are equal to all the OrderDate. Those rows in DueDate 
-- that don't match any of the rows in OrderDate, are the 2.025 that we get as a result.
-- If we sum the 6.820 rows that appear when trying to match any of the DueDates with the
-- OrderDates and the 2.025 rows that dont have any match, we get 8.845, that was the 
-- total number of rows we got.