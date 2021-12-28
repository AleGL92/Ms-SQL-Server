/* In the folowing codes, all the main functions used in SQL will be explained. Some of them 
have already been used in other codes. We have SUM(), AVG(), MAX(), MIN() and COUNT().
All of them are numerical aggregate functions. */

-- SUM() calculates the sum of all the non-null numbers. We have already used it with the
-- GROUP BY clause. But we could also sum all the values in a column like this.
SELECT SUM(StandardCost)		-- This would be like SUM(ALL StandardCost)
FROM Production.Product;

-- Or sum all the different values we have.
SELECT SUM(DISTINCT StandardCost)		
FROM Production.Product;

--Another useful function is AVG(), which calculates the average value.
-- There are only 2 possible values in MakeFlag (0 or 1). We can group them easily.
SELECT MakeFlag, StandardCost
FROM Production.Product;

SELECT MakeFlag, AVG(StandardCost)		-- DISTINCT could also be possible here
FROM Production.Product
GROUP BY MakeFlag;

-- COUNT is another function frequently used. It counts the total number of non null elements.
SELECT COUNT(*)
FROM Production.Product;
-- Here we get the total number of rows.

SELECT COUNT(Color)		-- In the color row we have many null elements, so those will not be counted.
FROM Production.Product;

SELECT Color
FROM Production.Product
WHERE Color IS NOT NULL;		-- This way we get 256 rows, as we had before.

 -- Max and min functions are frequently used too.
SELECT MAX(StandardCost) AS MaxStdCost
FROM Production.Product;

-- It can be used grouping aswell
SELECT MakeFlag, MAX(StandardCost) AS MaxStdCost
FROM Production.Product
GROUP BY MakeFlag
ORDER BY MAX(StandardCost);

-- We use the MIN() function in the same way as before.
SELECT MIN(StandardCost) AS MinStdCost
FROM Production.Product;		
-- The minimun value was 0, so we try go get values greater than 0 using WHERE clause.
-- WHERE MinStdCost > 0;
-- WHERE MIN(StandardCost) > 0;

/* We can't use the alias in the WHERE clause, because it's executed the select clause, 
and it returns error. But neither can we use MIN() in the where clause. It doesn't accept
aggregates. To do this, we have to use the HAVING() clause. */

-- The ABS() function returns the absolute value of the given value.
SELECT ABS(-123.45)

-- The CEILING() value returns the ceiling value of the given value. It's a upper aproximation
-- of the result to the greater integer value.
SELECT StandardCost, CEILING(StandardCost)
FROM Production.Product
WHERE StandardCost > 0;

-- To get the nearest integer value but aproximating to the lower value.
SELECT StandardCost, FLOOR(StandardCost)
FROM Production.Product
WHERE StandardCost > 0;

-- To get a random number, between 0 and 1.
SELECT RAND();
-- If we want to get it between 3 and 4
SELECT RAND() + 3;
-- To get the random value between some numbers, for instance, between 3 and 8.
SELECT RAND()*5 + 3;
-- And we could round up to integers, using ceiling.
SELECT CEILING(RAND()*5 + 3);

-- To round to a certain number of decimals.
SELECT ROUND(345.567, 2)		-- Rounding to the second decimal

-- Now we'll see some string functions.
-- With the CHARINDEX() function, we get back the position of a substring.
-- CHARINDEX(subString, mainString, startPosition). StarPosition is optional. By default 1.
SELECT CHARINDEX('D', 'DAD')		-- Returns the first value finded.
SELECT CHARINDEX('D', 'DAD', 2)

SELECT Name, CHARINDEX('Cr', Name)			-- We get index number when it matches
FROM Production.Product
WHERE Name LIKE '%Cr%';			-- This is to see only the names containing cr somewhere

/* Another string function that we have already seen is CONCAT(). Same for CONCAT_WS,
which was similar, but concatenating with a separator between strings.
We have DATALENTGH() wich returns the number of bytes of the string, including spaces. */
SELECT FirstName, DATALENGTH(FirstName) AS Bytes			-- We get index number when it matches
FROM Person.Person
GROUP BY FirstName;

-- Now we'll see FORMAT(), which changes the format in dates.
SELECT FORMAT(20220201, '####-##-##')
SELECT FORMAT(20220201, '####/##/##')

-- LEFT() retrieves a selected number of characters from a string, starting in the left side
-- RIGTH() works the same, but starting from the right side.
-- Another useful function is LEN(), which returns the number of characters in the string.
SELECT FirstName, LEFT(FirstName, 2) AS NumLeft		
FROM Person.Person;		-- We extract 2 characters here

SELECT FirstName, RIGHT(FirstName, 2) AS NumRight	
FROM Person.Person;

SELECT FirstName, LEN(FirstName) AS NameLenght
FROM Person.Person;

-- To convert strings to lower theres LOWER(), and to convert to uppecase, UPPER()
-- The function LTRIM() is used to remove the blanks in the left, meaning, the blanks
-- before the input string. Similarly, RTRIM() removes the blanks after the input string.
-- To remove spaces in both sides, TRIM().
SELECT FirstName, LOWER(FirstName) AS NameLowerCase
FROM Person.Person;

SELECT FirstName, UPPER(FirstName) AS NameUpperCase
FROM Person.Person;

SELECT LTRIM('            Trim left side')
SELECT RTRIM('Trim right side              ')
SELECT TRIM('      Trim both sides       ')

-- We'll continue with some more string functions.
-- PATINDEX displays the position of the first occurrence of a substring in the input string.
-- REPLACE() replaces all the occurences of a certain substring, inside the main string.
-- REPLICATE() repeates a string a number of times.
SELECT Name, PATINDEX('%Ball%', Name)
FROM Production.Product
WHERE Name LIKE '%Ball%';
-- 'Ball' is on the fouth position in 'BB Ball Bearing' for instance.

SELECT Name, PATINDEX('%Cr_nk%', Name)		-- It fills the underscore with any character it finds
FROM Production.Product
WHERE Name LIKE '%Cr%';

-- 'adventure-works\' appears in all the results before the real LoginId
SELECT LoginID, REPLACE(LoginId, 'adventure-works', 'aw') AS ReplacedStr	
FROM HumanResources.Employee;

-- REPLICATE (String, NumberOfTimes)
SELECT FirstName, REPLICATE(FirstName, 2) AS RepName
FROM Person.Person;

-- REVERSE() reverses the order in a given string.
-- STR() changes the type of a number, given as input, to a string type. Quite useful.
-- SUBSTRING() extracts some characters to a substring, from the main string.
SELECT FirstName, REVERSE(FirstName) AS ReverseName
FROM Person.Person;

-- SUBSTRING(MainString, StartingPosition, Length)
SELECT FirstName, SUBSTRING(FirstName, 3, 5) AS SubStr
FROM Person.Person;
-- Note that the 3erd position is included but the 8th is not.

SELECT ProductId, STR(ProductID)
FROM Production.Product;