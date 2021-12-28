-- The WHERE clause is used to filter the results of the query
SELECT BusinessEntityID, NationalIDNumber, BirthDate, MaritalStatus
FROM HumanResources.Employee
WHERE MaritalStatus = 'S';
-- This time, the order of execution will be FROM->WHERE->SELECT
--WHERE BirthDate > '1985-01-20';
--WHERE year(BirthDate) > '1985';			-- This time, we just specify the year
-- But we could use any other operator '=' '<> or !=' '>' '<' '>=' '<='  


SELECT StateProvinceID, CountryRegionCode
FROM Person.StateProvince
WHERE CountryRegionCode != 'US';
-- All the countries except US

-- We can also use arithmetic operators like '+' '-' '*' '/' in a WHERE clause
-- or creating a new column.
SELECT StandardCost, ListPrice, StandardCost + ListPrice AS Suma
FROM Production.Product
/* WHERE (StandardCost > 0) AND (Suma > 50);
Initially we cant add 'Suma' column to the where, because the order was 
FROM->WHERE->SELECT, so it's defined in last place. */
WHERE (StandardCost > 0) AND (StandardCost + ListPrice > 50);

-- When dividing we need to be careful not to include 0 values.
SELECT ProductID, Name, ReorderPoint, StandardCost
FROM Production.Product
WHERE (ReorderPoint/StandardCost >3) AND (StandardCost > 0);

-- As we have seen before, the WHERE clause also accepts logical operators like AND,
-- OR, and NOT.
SELECT ProductId, Name, StandardCost, ListPrice, SafetyStockLevel
FROM Production.Product
WHERE (ProductID < 600) AND (StandardCost < 50) AND (SafetyStockLevel BETWEEN 500 AND 1000);
--WHERE ProductID < 600 OR StandardCost > 50;
-- Note that brackets aren't really necesary but, the AND expressions will be evaluated
-- before the OR expression.
-- WHERE ProductID == 800 OR ProductId < 600 AND StandardCost > 50 AND SafetyStockLevel > 500;
-- will be like (ProductId == 800) OR (ProductId < 600 AND StandardCost ... )
-- Meaning the ANDs are first 'linked' together, and then the OR are evaluated.

-- It's useful sometimes to leave out a result.
SELECT ProductId, Name, StandardCost, ListPrice, SafetyStockLevel
FROM Production.Product
WHERE NOT ProductId = 3;

 -- If we wanted to select some rows with ProductId = XX
 SELECT ProductId, Name, StandardCost, ListPrice, SafetyStockLevel
 FROM Production.Product
 WHERE Name = 'Chainring';

 -- We can use the '+' to concatenate 2 different strings. If one of the strings is NULL
 -- all the concatenation will be NULL.
 SELECT Title, Firstname, MiddleName, LastName, 
		Title + ' ' + FirstName + ' ' + MiddleName + ' ' + LastName AS FullName
		-- CONCAT(Title, ' ', FirstName, ' ', MiddleName) would also be right.
 FROM Person.Person

 SELECT FirstName, BusinessEntityID,  
		CONCAT(FirstName, BusinessEntityID, '@', CONCAT_WS('.','web', 'adventure-works', 'com')) AS PersMail,
		CONCAT_WS('.','web', 'adventure-works', 'com') AS Domain
 FROM Person.Person
 -- This way, we can use the CONCAT_WS function inside the CONCAT function