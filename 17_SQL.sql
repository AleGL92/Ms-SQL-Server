-- Here are some examples of creating tables.

CREATE SCHEMA market;
--DROP SCHEMA market;

CREATE TABLE market.Shares (
Id INT NOT NULL IDENTITY,
ShareId INT PRIMARY KEY,
ShareName VARCHAR(50) NOT NULL,
SharePrice MONEY NOT NULL,
ShareIssueDate DATE
);
SELECT * FROM market.Shares;

CREATE TABLE market.Investors(
InvestorId INT PRIMARY KEY,
InvestorName VARCHAR(50) NOT NULL,
InvestorStatus BIT
);
SELECT * FROM market.Investors;

CREATE TABLE market.Issuers(
IssuerId INT PRIMARY KEY,
IssuerName VARCHAR(50) NOT NULL,
IssuerType VARCHAR(50) NOT NULL,
IssuerAddress VARCHAR(100) NOT NULL,
IssuerStatus BIT
);

CREATE TABLE market.InvestorIssues(
IId INT IDENTITY NOT NULL,
InvestorId INT NOT NULL,
IssuerId INT NOT NULL,
IssuerType Varchar(50) NOT NULL,
HoldingId INT NOT NULL,
HoldingStatus CHAR(3) NOT NULL,
HoldingNumber INT NOT NULL,
ParticipantCode Varchar(10) NOT NULL,
FOREIGN KEY (InvestorId) REFERENCES market.Investors(InvestorId),
FOREIGN KEY (IssuerId) REFERENCES market.Issuers(IssuerId)
);

-- Now we'll see about the ALTER statement. It's used to change the structure of a table.
-- It could be done adding columns, constraints or keys. Deleting columns, constraints and
-- indexes. Also changing all those before.

-- With the ALTER ADD statement we can add columns, constraints or keys. The syntax is
-- ALTER TABLE tableName
-- ADD {columnDetail | constraintDetail | keyDetail}

ALTER TABLE market.Investors
ADD InvestorStartDate DATE NOT NULL;

ALTER TABLE market.Investors
ADD CONSTRAINT UK_Investors_InvestorId_InvestorName UNIQUE(InvestorId, InvestorName);

ALTER TABLE market.InvestorIssues
ADD PRIMARY KEY(IId);

-- We can also add a default value with ALTER.
ALTER TABLE market.Investors
ADD CONSTRAINT DF_Investors_InvestorStatus
DEFAULT 0 FOR InvestorStatus;

ALTER TABLE market.Investors
ADD DEFAULT 'General' for InvestorName;

-- If we want to change a column's datatype, lenght or constraint
ALTER TABLE market.Shares
ALTER COLUMN ShareName Char(100);

ALTER TABLE market.Investors
ALTER COLUMN InvestorStatus BIT NOT NULL;

-- To drop columns or constraints
ALTER TABLE market.Investors
DROP COLUMN InvestorStartDate;
-- DROP COLUMN InvestorStartDate, InvestorStatus;

ALTER TABLE Investors
DROP CONSTRAINT DF_Investors_InvestorStatus;

-- Tables and columns can be renamed with SP_RENAME. The syntax is
-- SP_RENAME 'OldColumnName', 'NewColumnName', 'COLUMN'
-- SP_RENAME 'OldTableName', 'NewTableName'

SP_RENAME 'market.Issuers.IssuerType', 'IssuerTypes', 'COLUMN';
SP_RENAME 'Issuers', 'Issuer';

-- To delet the records from a table we use DELETE statement. To delete a table, we had to
-- use DROP TABLE

CREATE TABLE market.TablaPrueba
(
Col1 INT,
Col2 VARCHAR(50)
);

INSERT INTO market.TablaPrueba VALUES (44,77);
SELECT * FROM market.TablaPrueba;

DELETE FROM market.TablaPrueba WHERE Col1 = 33;
-- DELETE FROM market.TablaPrueba;		-- It will delete all the records from the table.
 
 -- Finally, we can drop indexes
 DROP INDEX CheckItems;