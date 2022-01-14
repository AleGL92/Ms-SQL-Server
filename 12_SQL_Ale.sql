/* Creating tables, keys and constraints. Let's see first the data types there are.
Bit: Stores whole number. If it's not 0 or 1, it stores a NULL value.
Tinyint: Stores whole numbers from 0 to 255.
Smallint: Stores whole numbers between -32.768 and 32.768.
Int: Stores whole numbers from -2^31 and 2^31.
Bigint: Stores whole numbers from -2^63 and 2^63.
Decimal: Numbers with floating comma, between -10^38 and 10^38.
Smallmoney: Stores small currency between -214.748,3647 and -214.748,3647.
Money: Same as before, but with much bigger range.
Float: Stores floating comma numbers between -1,79e308 and -1,79e308.
Real: Stores floating comma numbers between -1,79e308 and -1,79e308.

In general, there are 2 main types, int numbers and float numbers. Money numbers, 
which are actually floats, are also commonly used.

Then we have strings.
Char: It can store a 8000 characters max of fixed length.
Varchar: Stores up to 8000 characters of variable length.
Text: Can store up to 2gb of space aprox.
Nchar: Up to 4000 characters of fixed length.
Nvarchar: Up to 4000 characters of variable length.
Image: Used for variable length binary strings, tipically images, that can store up to
2 gb of data.
Reminder: To see the unicode number of a character, in MS Word we can select it, and
using the command ALT+X, we can get it.

Then we also have date formats, which we had already seen, like datetime, date, time or
timestamp.

Finally, there are other data types, wich aren't any of the previous ones.
Uniqueidentifier: Stores a 16 byte globally unique identifier.
Xml: Stores XML data type.

Now we'll see how to create a database. It's a previous step for creating a table.
First the database is created, and then, the tables are allocated in the database. 

Usually, the DataBase Administrator (DBA) is responsable for the database creation and 
maintenance. 
To create a database there are 2 ways. The first it right click on database, in the Object
explorer. Then we give it a name and we could leave all the other options as default.
When the database is created, there are no user tables, so we'll create them later.
*/

CREATE DATABASE Database_ALE;

-- To delete a database. (Or right click -> delete)
DROP DATABASE Database_ALE;

/* It's important to give the tables the proper naming convention, as it will help to avoid
many unwanted errors. It's not mandatory but it's better to follow these recommendations.
a. Avoid any spaces in the Table or Column names.
b. Keep the naming convention consistent thorugh all the proyect.
c. Avoid using special characters in the Table or Column names. (~ ' # () ><, etc)
d. It's always better to name Table names as PLURAL.
e. Names should always be short and meaninful.
f. Start primery keys with PK and foreign keys with FK.
g. Better to use TitleCase or camelCase for names.

To create tables
CREATE TABLE tableName
(
column1 dataType1
column2 dataType2
column3 dataType3
);		*/

CREATE TABLE Stores
(
	StoreId INT IDENTITY(1,1),
		-- IDENTITY (1,1) fills the column starting in 1 and then adding 1 more in each row
		-- IDENTITY (2,4 ) would start in 2, filling the next with 6, then 10, etc
	StoreNumber VARCHAR(50),		-- Maximun 50 characters
	PhoneNumber CHAR(14),	-- Max 14 characters. We prefer CHAR not INT, to allow characters
							-- like - or +.
	Email Varchar(50),
	Address Varchar(120),
	City Varchar(40),
	State Varchar(10),
	ZipCode INT
)

-- Now under Database_Ale, Tables we can see the table called dbo.Stores.
-- If we want to change the schema, which currently is dbo, we can go to Database_Ale ->
-- Security -> Schemas and there we have all the available schemas. Then right click -> 
-- New Schema. For this example we'll call it retail.

-- After right click and delete the previous table, that had dbo schema,
-- we create it again, in the right schema.
CREATE TABLE retail.Stores
(
	StoreId INT IDENTITY(1,1),
		-- IDENTITY (1,1) fills the column starting in 1 and then adding 1 more in each row
		-- IDENTITY (2,4 ) would start in 2, filling the next with 6, then 10, etc
	StoreNumber VARCHAR(50),		-- Maximun 50 characters
	PhoneNumber CHAR(14),	-- Max 14 characters. We prefer CHAR not INT, to allow characters
							-- like - or +.
	Email Varchar(50),
	Address Varchar(120),
	City Varchar(40),
	State Varchar(10),
	ZipCode INT
)

-- If we wanted to drop a table
DROP TABLE dbo.Stores