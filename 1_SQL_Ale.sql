/* To check name and version */
SELECT @@SERVERNAME;
SELECT @@VERSION;


-- This is also another way  to make comments
SELECT *		-- '*' is used to select everything in the table
-- FROM DatabaseName.SchemaName.TableName
-- But as we have already selected the Database, we can skip that part
FROM Person.Password;
-- SQL considers first the FROM statement and then the SELECT statement
-- We can do another query just below the first one. If we select it, we
-- can run only the second one.
SELECT *
FROM Person.Person;

SELECT BusinessEntityID, MiddleName, LastName
FROM Person.Person;
 -- This way we select just the columns we need, not all of them like 
 -- before, when using '*'


-- The distinct clause is used to select unique values in a column or list of columns
SELECT JobTitle
FROM HumanResources.Employee;
-- We have 290 rows, with many repeated jobs

SELECT DISTINCT JobTitle
FROM HumanResources.Employee
-- This time there are only 69 rows, and all the jobs appear just once

-- Same thing happens when we have numerical values
SELECT OrganizationLevel
FROM HumanResources.Employee;

SELECT DISTINCT OrganizationLevel
FROM HumanResources.Employee;
-- In the second query for Organizartion_Level, there are only 5 unique results. 
-- Nulls are not ignored.

SELECT *
FROM Person.Person;

SELECT DISTINCT Title, Suffix
FROM Person.Person;
/* In the first query we had all the columns. Then we select just Title and Suffix columns.
The DISTINCT clause returns each unique combination of Title and Suffix. It's useful to see 
all the possible combinations of 2 different columns. */


-- Now we'll see how the CASE clause works. It's very similar to an if in Python. 
SELECT NationalIDNumber, HireDate, VacationHours,
CASE
WHEN VacationHours > 70 THEN 'Vacation hours over limit'
WHEN VacationHours BETWEEN 40 AND 70 THEN 'Vacation hours average'
ELSE 'Vacation hours within limit'
END AS VacationHourLimit			-- This is going to be the alias for the new column
FROM HumanResources.Employee; 
-- CASE clauses go before FROM clause. When using BETWEEN, both values are considered.
-- It would be like using 40 <= X <= 70.