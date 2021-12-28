-- The LIKE operator is used to get a result where 0 or more characters match.
-- We want to get from the folowing query, all the employees whose job title starts 
-- with letter R. '%' means any symbol.
SELECT BusinessEntityId, JobTitle
FROM HumanResources.Employee
--WHERE JobTitle LIKE 'R%'
WHERE JobTitle LIKE '%Manager%'		-- Before or after the word manager, there could be
-- any other characters.

 /* If we use the LIKE operator before [bc] (or any other characters inside square brackets)
 we would get results with those 2 letters. */
 SELECT *
 FROM Person.StateProvince
 WHERE StateProvinceCode LIKE 'A[BKL]%';
 -- This way, we get all results that cointain A, immediately folowed by letters B, K or L.

SELECT *
FROM Person.StateProvince
--WHERE StateProvinceCode LIKE 'A[BKL]%';
WHERE StateProvinceCode LIKE '[IL]A%';
--WHERE StateProvinceCode LIKE '%[IL][ABCDEFG]%';
-- Note that we are saying here, that any result that is IA or LA should be returned,
-- but if the result has some other characters before or after, it wont be returned.
-- So that's why it's useful to add the '%' character.

-- We can also range the like operator. To obtain all ProducNumbers starting with CODE L:
SELECT *
FROM Production.Product
--WHERE ProductNumber LIKE 'L[IJKLMN]%'		-- Below would be the same
WHERE ProductNumber LIKE 'L[I-N]%';

SELECT *
FROM Production.Product
WHERE ProductNumber LIKE 'L[A-Z]-[0-9]%';
-- This way, we can specify even more.
--WHERE ProductNumber LIKE 'L[I-N]-[135]%';		-- Here in the last bracket, we specify
-- that anything that starts with 1, 3 or 5 can be a result. It works the same way as if 
-- we had letters.
 
 -- LIKE can be used also with the negation character '^', that would be like specifying
 -- that those characters cannot appear. It's like using NOT.
 SELECT *
 FROM Production.Product
 WHERE ProductNumber LIKE 'L[^I-N]-[^135]';

 SELECT *
 FROM Person.StateProvince
 --WHERE StateProvinceCode LIKE 'A[BKL]%';		--To get everything after A[BKL]
 -- To get the exact number or characters after, we can use any number of _ (underscore)
 WHERE Name LIKE 'AL____';

-- Now we try to get the unique values in PersonType
SELECT DISTINCT PersonType
FROM Person.Person
WHERE PersonType LIKE 'S_';
-- Or to see the other unique values, which aren't S_
-- WHERE PersonType NOT LIKE 'S_';

-- Sometimes we might find a special character. This may result in difficulties to 
-- find a name when using the LIKE operator. To avoid it we can use the folowing.
SELECT *
FROM Purchasing.Vendor
--WHERE NAME like '%.%';	-- '.' is not a special character though
WHERE Name LIKE '%''%';		-- The ' character is left between both '%'s.