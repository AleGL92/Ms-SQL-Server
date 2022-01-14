# MS-SQL
In this repository there are series of SQL codes, showing some commonly used functions, commands and queries. In all of the codes, there many queries, and to execute one or more of them, we need to select the whole query or queries, and then press F5. If we just press F5 (or the execute button), without selecting, we'll be running all the queries in the code.
The content of each SQL code is:

1. SELECT, SELECT DISTINCT, FROM, CASE-WHEN-ELSE and AS clauses. These are the basic commands, to select columns, tables to get the colummns, if-else in SQL and to give aliases.

2. WHERE, CONCAT ans CONCAT_WS. They are used to filter the results of a query, comparing with the usual operators ('=' '<>' '!=' '>' '<' '>=' '<=') and to concatenate strings in different ways.

3. NULLs, WHERE with BETWEEN, CAST, WHERE with IN. Adding the 'between' clause let's us get just a range of filtered rows while using it with the 'in' clause lets us select the values specified in a list. 'Cast' clause is useful to change the present format to another.

4. WHERE with LIKE, to specify even more options when filtering strings.

5. ORDER BY and GROUP BY. Two important clauses, used to order the results and to group the results, while using an aggregator function.

6. Main functions. Here the aggregators SUM, AVG, MAX, MIN and COUNT are explained. Also the functions ABS, CEILING, FLOOR, ROUND, CHARINDEX, DATALENGTH, FORMAT, LEN, LOWER, UPPER, LTRIM, RTRIM, REPLICATE, REPLACE, REVERSE, SUBSTRING. These functions are used for a variety of tasks, like rounding numbers, finding substrings in a given string, formatting dates, getting the lenght of a string in number of characters or bytes, converting to upper orlowercase, trimming the blank characters or replacing characters in a string.

7. Main functions pt2. DATEADD, DATEDIFF, DATEPART, DAY, MONTH, DATENAME, EOMONTH, CURRENT_TIMESTAMP, SYSDATETIME or ISDATE, which are all functions related to dates and
times, and which allows us, for instance, to sum, substract or extract dates, from other results with date format. There are other functions not date related like ISNULL and ISNUMERIC, that give a certain result when the input is null or numeric.

8. Main functions pt3. COALESCE, NULLIF and CONVERT. To check if there are null values and to convert to different formats. Also the HAVING clause is explained in this code. It's very important, and it's used to filter like the WHERE clause, but in those cases where there are aggregators used. 

9. Several examples of Subqueries, ANY operator to return true if there are any matches with the given condition and, ALL operator, to return true if all the records match.

10. UNIONS, to combine multiple SELECT statements, remove duplicates, and append tables that have the same columns, combining rows. It's also explained how the INTERSECT statement works, which is used to combine unique rows common to both combined tables.

11. JOINS. Implicit form, INNER JOIN, LEFT AND RIGHT JOINS and CROSS JOIN, which are all used to combine columns from different tables.

12. Creating tables, explaining all the data types for the columns for number, strings and date formats. Also schemas and dropping tables.

13. Creating tables pt2. Adding constraints to the created columns like NOT NULL, UNIQUE, CHECK, DEFAULT, PRIMARY KEY or FOREIGN KEY.

14. Creating tables pt3. Some more examples about creating tables with constraints, oriented to PRIMARY KEYS and FOREIGN KEYS.

15. Insert data in the previously created tables using the INSERT INTO statement to insert the data by rows, in the corresponding columns, and the UPDATE statemente to modify the data.

16. VIEWS to encapsulate the main table, protecting it from unwanted changes or from other users reading the query. Also the SELECT INTO statement, used to create a new table
from an existing one.

17. Some more examples of creating tables with constraints, ALTER TABLE statement to modify previously created tables, ALTER COLUMN to modify previously created columns and SP_RENAME to modify the name of tables and columns.
