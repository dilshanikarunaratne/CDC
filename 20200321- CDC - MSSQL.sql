-- Use the restored database
USE AdventureWorksDW2019
GO

-- Change owner
sp_changedbowner 'sa'
GO

-- Enabling CDC on the database
EXEC sys.sp_cdc_enable_db

-- Check if CDC is enabled for the database
SELECT name, database_id, is_cdc_enabled FROM sys.databases

-- Enabling CDC on the source table
EXEC sys.sp_cdc_enable_table

@source_schema = 'dbo', 
@source_name   = 'DimCustomer', 
@role_name     = NULL 
GO 

-- Check change tables
SELECT 
	object_name(object_id) AS capture_table_name, 
	*
FROM cdc.change_tables;
GO

select name, is_tracked_by_cdc from sys.tables

--Insert operation
INSERT INTO [dbo].[DimCustomer]
           ([GeographyKey]
           ,[CustomerAlternateKey]
           ,[FirstName]
           ,[MiddleName]
           ,[LastName]
           ,[NameStyle]
           ,[BirthDate]
           ,[MaritalStatus]
           ,[Gender]
           ,[EmailAddress]
           ,[YearlyIncome]
           ,[TotalChildren]
           ,[NumberChildrenAtHome]
           ,[EnglishEducation]
           ,[SpanishEducation]
           ,[FrenchEducation]
           ,[EnglishOccupation]
           ,[SpanishOccupation]
           ,[FrenchOccupation]
           ,[HouseOwnerFlag]
           ,[NumberCarsOwned]
           ,[AddressLine1]
           ,[Phone]
           ,[DateFirstPurchase]
           ,[CommuteDistance])
     VALUES
           (620
           ,'AW00032508'
           ,'Rachel'
           ,'Meli'
           ,'Parson'
           ,0
           ,'1982-08-07'
           ,'M'
           ,'F'
           ,'racheclparson@gmail.com'
           ,85000.00
           ,3
           ,1
           ,'Partial College'
           ,'Estudios universitarios (en curso)'
           ,'Baccalauréat'
           ,'Professional'
           ,'Profesional'
           ,'Cadre'
           ,'1'
           ,1
           ,'9187 Vista Del Sol'
           ,'246-534-0147'
           ,'2010-05-08'
           ,'10+ Miles')
GO


SELECT *
FROM cdc.dbo_DimCustomer_CT;
GO

SELECT *
FROM dbo.DimCustomer
GO

--Update operation
UPDATE [dbo].[DimCustomer]
    SET [GeographyKey] = 621
    WHERE [CustomerAlternateKey] = 'AW00032508'

SELECT *
FROM cdc.dbo_DimCustomer_CT;
GO

SELECT *
FROM dbo.DimCustomer
GO

--Insert operation
INSERT INTO [dbo].[DimCustomer]
           ([GeographyKey]
           ,[CustomerAlternateKey]
           ,[FirstName]
           ,[MiddleName]
           ,[LastName]
           ,[NameStyle]
           ,[BirthDate]
           ,[MaritalStatus]
           ,[Gender]
           ,[EmailAddress]
           ,[YearlyIncome]
           ,[TotalChildren]
           ,[NumberChildrenAtHome]
           ,[EnglishEducation]
           ,[SpanishEducation]
           ,[FrenchEducation]
           ,[EnglishOccupation]
           ,[SpanishOccupation]
           ,[FrenchOccupation]
           ,[HouseOwnerFlag]
           ,[NumberCarsOwned]
           ,[AddressLine1]
           ,[Phone]
           ,[DateFirstPurchase]
           ,[CommuteDistance])
     VALUES
           (620
           ,'AW00032509'
           ,'Liza'
           ,'N'
           ,'Stanley'
           ,0
           ,'1986-01-24'
           ,'M'
           ,'F'
           ,'lizastanley@gmail.com'
           ,97000.00
           ,2
           ,0
           ,'Partial College'
           ,'Estudios universitarios (en curso)'
           ,'Baccalauréat'
           ,'Professional'
           ,'Profesional'
           ,'Cadre'
           ,'1'
           ,1
           ,'9187 Vista Del Sol'
           ,'246-930-0487'
           ,'2012-09-03'
           ,'10+ Miles')
GO


INSERT INTO [dbo].[DimCustomer]
           ([GeographyKey]
           ,[CustomerAlternateKey]
           ,[FirstName]
           ,[MiddleName]
           ,[LastName]
           ,[NameStyle]
           ,[BirthDate]
           ,[MaritalStatus]
           ,[Gender]
           ,[EmailAddress]
           ,[YearlyIncome]
           ,[TotalChildren]
           ,[NumberChildrenAtHome]
           ,[EnglishEducation]
           ,[SpanishEducation]
           ,[FrenchEducation]
           ,[EnglishOccupation]
           ,[SpanishOccupation]
           ,[FrenchOccupation]
           ,[HouseOwnerFlag]
           ,[NumberCarsOwned]
           ,[AddressLine1]
           ,[Phone]
           ,[DateFirstPurchase]
           ,[CommuteDistance])
     VALUES
           (620
           ,'AW00032510'
           ,'Rosa'
           ,'N'
           ,'Lee'
           ,0
           ,'1984-04-15'
           ,'M'
           ,'F'
           ,'rosanlee@gmail.com'
           ,92000.00
           ,2
           ,1
           ,'Partial College'
           ,'Estudios universitarios (en curso)'
           ,'Baccalauréat'
           ,'Professional'
           ,'Profesional'
           ,'Cadre'
           ,'1'
           ,1
           ,'9187 Vista Del Sol'
           ,'238-450-0736'
           ,'2015-03-08'
           ,'10+ Miles')
GO


SELECT *
FROM cdc.dbo_DimCustomer_CT;
GO

SELECT *
FROM dbo.DimCustomer
GO

--Delete operation
DELETE FROM [dbo].[DimCustomer]
	WHERE [CustomerAlternateKey] = 'AW00032510'

SELECT *
FROM cdc.dbo_DimCustomer_CT;
GO

SELECT *
FROM dbo.DimCustomer
GO

-- Transpose the operation column
SELECT 
	[__$start_lsn],
	[__$seqval],
	[__$operation],
	CASE [__$operation] 
		WHEN 1 THEN 'Delete'
		WHEN 2 THEN 'Insert'
		WHEN 3 THEN 'Update From Value'
		WHEN 4 THEN 'Update To Value'
	END AS [operation],
	[__$update_mask]
			,[GeographyKey]
           ,[CustomerAlternateKey]
           ,[FirstName]
           ,[MiddleName]
           ,[LastName]
           ,[NameStyle]
           ,[BirthDate]
           ,[MaritalStatus]
           ,[Gender]
           ,[EmailAddress]
           ,[YearlyIncome]
           ,[TotalChildren]
           ,[NumberChildrenAtHome]
           ,[EnglishEducation]
           ,[SpanishEducation]
           ,[FrenchEducation]
           ,[EnglishOccupation]
           ,[SpanishOccupation]
           ,[FrenchOccupation]
           ,[HouseOwnerFlag]
           ,[NumberCarsOwned]
           ,[AddressLine1]
           ,[Phone]
           ,[DateFirstPurchase]
           ,[CommuteDistance]
FROM cdc.dbo_DimCustomer_CT;
GO