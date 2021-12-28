/* Date functions are frequently used. We'll see here how to use them.
The first one is DATEADD(), which adds date or time to another date.
The syntax is DATEADD(format-inverval, number, dateVal) 
In a similar way, we have DATEDIFF(), which is used to substract date or time to 
another date. The syntax is DATEDIFF(datepart, date1, date2). 
When refering to years, we can use these formats: year, y, yy or yyyy.
For quarters q or qq.
For months we can use month, m, mm.
For days we can use day, d or dd.
For hours we use hour or hh.
If it's minutes, we have minute, mi, m. 
Then we have second, ss, s.
milisecond, ms. */

SELECT ProductID, SellStartDate
FROM Production.Product;
-- SellStartDate has format yyyy-mm--dd hh:mm:ss-ms

SELECT ProductID, SellStartDate, DATEADD(yyyy, 3, SellStartDate) AS NewSellStartDate
FROM Production.Product;
-- We specified the date format with yyyy, so we added 3 years. Now we'll add 3 quarters.

SELECT ProductID, SellStartDate, DATEADD(q, 3, SellStartDate) AS NewSellStartDate
FROM Production.Product;

-- To add hours
SELECT ProductID, SellStartDate, DATEADD(hh, 3, SellStartDate) AS NewSellStartDate
FROM Production.Product;

-- To substract using DATEDIFF it's not the same format as DATEADD.
-- We have to specify 
SELECT ProductID, SellStartDate, SellEndDate, 
		DATEDIFF(yyyy, SellStartDate, SellEndDate) AS NewSellDiffDate
FROM Production.Product		-- There are many null values in SellEndDate, we don't need those
WHERE SellEndDate IS NOT NULL;

-- Reminder, DATEPART() returns part of the date as an integer.
-- DATEPART(date-interval, dateField)
-- In a similar way, to extract just the day from a date, DAY([datefield])
-- Similarly MONTH(), YEAR()
SELECT  ProductID, SellStartDate, DATEPART(yyyy, SellStartDate) AS ExtDate
FROM Production.Product;

-- To extract other date formats
SELECT  ProductID, SellStartDate, DATEPART(mm, SellStartDate) AS ExtDate
FROM Production.Product;		-- monts

SELECT  ProductID, SellStartDate, DATEPART(hh, SellStartDate) AS ExtDate
FROM Production.Product;		-- hours

SELECT  ProductID, SellStartDate, DAY(SellStartDate) AS ExtDate
FROM Production.Product;

SELECT  ProductID, SellStartDate, MONTH(SellStartDate) AS ExtDate
FROM Production.Product;

-- DATENAME() returns part of a date, in a similar way to DATEPART(), but this function
-- returns a string.
-- We can also get the last date of the month using EOMONTH().

SELECT  ProductID, SellStartDate, DATENAME(mm, SellStartDate) AS ExtDate
FROM Production.Product;

SELECT  ProductID, SellStartDate, DATEPART(yyyy, SellStartDate) AS ExtDate
FROM Production.Product;

SELECT  ProductID, SellStartDate, EOMONTH(SellStartDate) AS ExtDate
FROM Production.Product;

-- We have a few more date functions left.
-- CURRENT_TIMESTAMP() returns the current system time, without time zone.
--GETDATE() returns the system date, with the time from the SQL server.

SELECT CURRENT_TIMESTAMP;
SELECT GETDATE();		-- Both give the same result.
SELECT SYSDATETIME();	-- Current time from the operating system where the SQL server is 
-- installed. It has more precission than the 2 previous.

-- ISDATE() returns boolean 1 if the expression given is a valid date/time/datetime and
-- 0 if it's not.
-- ISNULL() takes 2 arguments, checks whether it is a null value or not. If it's null, 
-- Then it returns the second argument as output. If the first argument it not null, it
-- will return this first one.
-- We can also check if an expression is numeric using ISNUMERIC(),
SELECT *
FROM Production.Product;

SELECT SellStartDate, ISDATE(SellStartDate)
FROM Production.Product;		-- All 1's, because it's a valid date.

SELECT ISDATE(1) AS ISADATE;		-- We got a 0, it's not a valid date format.

SELECT ISNULL(NULL, 'ALE');
SELECT ISNULL(999, 'ALE');		-- As expected, first it returned 'ALE', then it returned 999.

-- Reminder. Zero (as an integer), or a space character aren't nulls.
SELECT ISNULL(0, 'ALE');
SELECT ISNULL(' ', 'ALE');

SELECT Color, ISNULL(Color, 'We had null')
FROM Production.Product;
-- When the row is not null, shows the color, if not, it shows the given string.

SELECT StandardCost, ISNUMERIC(StandardCost) as ISNum
FROM Production.Product;	-- All 1's.

SELECT Color, ISNUMERIC(Color) AS ISNum
FROM Production.Product;