-- Create a database
CREATE DATABASE CDC_DEMO2
GO

-- Use the created database
USE CDC_DEMO2
GO

-- Create table 1
CREATE TABLE Orders1(
order_id		INT PRIMARY KEY ,
product_num		VARCHAR(6),
price			INT,
order_date		SMALLDATETIME
)

-- Create table 2
CREATE TABLE Orders2(
id				INT IDENTITY(1,1) PRIMARY KEY,
order_id		INT,
product_num		VARCHAR(6),
price			INT,
order_date		SMALLDATETIME,
operation		VARCHAR(7)
)

-- Create trigger
CREATE TRIGGER tr_orders ON Orders1
AFTER INSERT,UPDATE,DELETE
AS
DECLARE @operation    varchar(7) 

IF EXISTS (SELECT * FROM INSERTED) AND NOT EXISTS (SELECT * FROM DELETED)
BEGIN

SET @operation='Insert'
 INSERT INTO Orders2 (order_id, product_num, price, order_date, operation)
       SELECT order_id, product_num, price, order_date, @operation
       FROM INSERTED
END

ELSE IF EXISTS (SELECT * FROM INSERTED) AND EXISTS (SELECT * FROM DELETED)
    BEGIN
        SET @operation='Update'

    INSERT INTO Orders2 (order_id, product_num, price, order_date, operation)
       SELECT order_id, product_num, price, order_date, @operation
       FROM INSERTED
  END

ELSE IF EXISTS(SELECT * FROM DELETED) AND NOT EXISTS (SELECT * FROM INSERTED)
BEGIN
    SET @operation='Delete'

    INSERT INTO Orders2 (order_id, product_num, price, order_date, operation)
       SELECT order_id, product_num, price, order_date, @operation
       FROM DELETED
END



-- Insert operation
INSERT INTO [dbo].Orders1 (
	[order_id], [product_num], [price], [order_date])
VALUES  (00001, 'P004', 1770, GETDATE()),
		(00002, 'P003', 750, '2020-07-27'),
		(00003, 'P010', 1550, GETDATE()),
		(00004, 'P007', 480, '2020-08-30'),
		(00005, 'P002', 630, '2020-10-05')


SELECT * FROM Orders1
SELECT * FROM Orders2

-- Update operation
UPDATE [dbo].[Orders1]
    SET [price] = 3200,
		[order_date] = GETDATE()
    WHERE [order_id] = 00002

UPDATE [dbo].[Orders1]
    SET [product_num] = 'P011',
		[order_date] = GETDATE()
    WHERE [order_id] = 00003

SELECT * FROM Orders1
SELECT * FROM Orders2

-- Delete operation
DELETE FROM [dbo].[Orders1]
	WHERE [order_id] = 00003

SELECT * FROM Orders1
SELECT * FROM Orders2

