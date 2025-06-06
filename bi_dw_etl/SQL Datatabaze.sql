USE [JAV0032];
/****** Object:  Schema [DM]    Script Date: 3/28/2025 10:07:01 AM ******/
IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = N'DM')
EXEC sys.sp_executesql N'CREATE SCHEMA [DM]'
GO
/****** Object:  Schema [ETL]    Script Date: 3/28/2025 10:07:01 AM ******/
IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = N'ETL')
EXEC sys.sp_executesql N'CREATE SCHEMA [ETL]'
GO
/****** Object:  Schema [ODS]    Script Date: 3/28/2025 10:07:01 AM ******/
IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = N'ODS')
EXEC sys.sp_executesql N'CREATE SCHEMA [ODS]'
GO
/****** Object:  Schema [SalesLT]    Script Date: 3/28/2025 10:07:01 AM ******/
IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = N'SalesLT')
EXEC sys.sp_executesql N'CREATE SCHEMA [SalesLT]'
GO
/****** Object:  Schema [Stage]    Script Date: 3/28/2025 10:07:01 AM ******/
IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = N'Stage')
EXEC sys.sp_executesql N'CREATE SCHEMA [Stage]'
GO
/****** Object:  UserDefinedDataType [dbo].[AccountNumber]    Script Date: 3/28/2025 10:07:01 AM ******/
IF NOT EXISTS (SELECT * FROM sys.types st JOIN sys.schemas ss ON st.schema_id = ss.schema_id WHERE st.name = N'AccountNumber' AND ss.name = N'dbo')
CREATE TYPE [dbo].[AccountNumber] FROM [nvarchar](15) NULL
GO
/****** Object:  UserDefinedDataType [dbo].[Flag]    Script Date: 3/28/2025 10:07:01 AM ******/
IF NOT EXISTS (SELECT * FROM sys.types st JOIN sys.schemas ss ON st.schema_id = ss.schema_id WHERE st.name = N'Flag' AND ss.name = N'dbo')
CREATE TYPE [dbo].[Flag] FROM [bit] NOT NULL
GO
/****** Object:  UserDefinedDataType [dbo].[Name]    Script Date: 3/28/2025 10:07:01 AM ******/
IF NOT EXISTS (SELECT * FROM sys.types st JOIN sys.schemas ss ON st.schema_id = ss.schema_id WHERE st.name = N'Name' AND ss.name = N'dbo')
CREATE TYPE [dbo].[Name] FROM [nvarchar](50) NULL
GO
/****** Object:  UserDefinedDataType [dbo].[NameStyle]    Script Date: 3/28/2025 10:07:01 AM ******/
IF NOT EXISTS (SELECT * FROM sys.types st JOIN sys.schemas ss ON st.schema_id = ss.schema_id WHERE st.name = N'NameStyle' AND ss.name = N'dbo')
CREATE TYPE [dbo].[NameStyle] FROM [bit] NOT NULL
GO
/****** Object:  UserDefinedDataType [dbo].[OrderNumber]    Script Date: 3/28/2025 10:07:01 AM ******/
IF NOT EXISTS (SELECT * FROM sys.types st JOIN sys.schemas ss ON st.schema_id = ss.schema_id WHERE st.name = N'OrderNumber' AND ss.name = N'dbo')
CREATE TYPE [dbo].[OrderNumber] FROM [nvarchar](25) NULL
GO
/****** Object:  UserDefinedDataType [dbo].[Phone]    Script Date: 3/28/2025 10:07:01 AM ******/
IF NOT EXISTS (SELECT * FROM sys.types st JOIN sys.schemas ss ON st.schema_id = ss.schema_id WHERE st.name = N'Phone' AND ss.name = N'dbo')
CREATE TYPE [dbo].[Phone] FROM [nvarchar](25) NULL
GO
/****** Object:  Sequence [ETL].[SeqBatchID]    Script Date: 3/28/2025 10:07:01 AM ******/
IF NOT EXISTS (SELECT * FROM sys.sequences WHERE name = N'SeqBatchID' AND schema_id = SCHEMA_ID(N'ETL'))
BEGIN
CREATE SEQUENCE [ETL].[SeqBatchID] 
 AS [int]
 START WITH 1
 INCREMENT BY 1
 MINVALUE -2147483648
 MAXVALUE 2147483647
 CACHE 
END
GO
/****** Object:  Sequence [ETL].[SeqExecID]    Script Date: 3/28/2025 10:07:02 AM ******/
IF NOT EXISTS (SELECT * FROM sys.sequences WHERE name = N'SeqExecID' AND schema_id = SCHEMA_ID(N'ETL'))
BEGIN
CREATE SEQUENCE [ETL].[SeqExecID] 
 AS [int]
 START WITH 1
 INCREMENT BY 1
 MINVALUE -2147483648
 MAXVALUE 2147483647
 CACHE 
END
GO
/****** Object:  Sequence [ETL].[SeqExecutionID]    Script Date: 3/28/2025 10:07:02 AM ******/
IF NOT EXISTS (SELECT * FROM sys.sequences WHERE name = N'SeqExecutionID' AND schema_id = SCHEMA_ID(N'ETL'))
BEGIN
CREATE SEQUENCE [ETL].[SeqExecutionID] 
 AS [bigint]
 START WITH 1
 INCREMENT BY 1
 MINVALUE -9223372036854775808
 MAXVALUE 9223372036854775807
 CACHE 
END
GO
/****** Object:  Table [ETL].[Batches]    Script Date: 3/28/2025 10:07:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ETL].[Batches]') AND type in (N'U'))
BEGIN
CREATE TABLE [ETL].[Batches](
	[BatchID] [int] NOT NULL,
	[PackageName] [nvarchar](50) NULL,
	[Started] [datetime] NULL,
	[Ended] [date] NULL,
	[Status] [nvarchar](1) NULL,
 CONSTRAINT [PK_Batches] PRIMARY KEY CLUSTERED 
(
	[BatchID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [ETL].[Executions]    Script Date: 3/28/2025 10:07:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ETL].[Executions]') AND type in (N'U'))
BEGIN
CREATE TABLE [ETL].[Executions](
	[ExecutionId] [int] NOT NULL,
	[BatchID] [int] NOT NULL,
	[PackageName] [nvarchar](50) NULL,
	[Started] [datetime] NULL,
	[Ended] [date] NULL,
	[SourceRowCount] [int] NULL,
	[DestRowCount] [int] NULL,
	[Inserted] [int] NULL,
	[Updated] [int] NULL,
	[Deleted] [int] NULL,
	[Status] [nvarchar](1) NULL
) ON [PRIMARY]
END
GO
/****** Object:  Table [ODS].[AWAddress]    Script Date: 3/28/2025 10:07:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ODS].[AWAddress]') AND type in (N'U'))
BEGIN
CREATE TABLE [ODS].[AWAddress](
	[AddressID] [int] NOT NULL,
	[AddressLine1] [nvarchar](60) NOT NULL,
	[AddressLine2] [nvarchar](60) NULL,
	[City] [nvarchar](30) NOT NULL,
	[StateProvince] [nvarchar](50) NOT NULL,
	[CountryRegion] [nvarchar](50) NOT NULL,
	[PostalCode] [nvarchar](15) NOT NULL,
	[rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[ModifiedDate] [datetime] NOT NULL,
	[SOURCE_SYSTEM] [nvarchar](4) NULL,
	[LOAD_DATE] [datetime] NULL,
	[LOAD_ID] [int] NULL,
	[HASH] [nvarchar](32) NULL
) ON [PRIMARY]
END
GO
/****** Object:  Table [ODS].[AWAddress_Delta]    Script Date: 3/28/2025 10:07:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ODS].[AWAddress_Delta]') AND type in (N'U'))
BEGIN
CREATE TABLE [ODS].[AWAddress_Delta](
	[Action] [nvarchar](16) NULL,
	[Action_LOAD_ID] [int] NULL,
	[AddressID] [int] NOT NULL,
	[AddressLine1] [nvarchar](60) NOT NULL,
	[AddressLine2] [nvarchar](60) NULL,
	[City] [nvarchar](30) NOT NULL,
	[StateProvince] [nvarchar](50) NOT NULL,
	[CountryRegion] [nvarchar](50) NOT NULL,
	[PostalCode] [nvarchar](15) NOT NULL,
	[rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[ModifiedDate] [datetime] NOT NULL,
	[SOURCE_SYSTEM] [nvarchar](4) NULL,
	[LOAD_DATE] [datetime] NULL,
	[LOAD_ID] [int] NULL,
	[HASH] [nvarchar](32) NULL
) ON [PRIMARY]
END
GO
/****** Object:  Table [ODS].[AWSalesOrderDetail]    Script Date: 3/28/2025 10:07:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ODS].[AWSalesOrderDetail]') AND type in (N'U'))
BEGIN
CREATE TABLE [ODS].[AWSalesOrderDetail](
	[SalesOrderID] [int] NULL,
	[SalesOrderDetailID] [int] NULL,
	[OrderQty] [smallint] NULL,
	[ProductID] [int] NULL,
	[UnitPrice] [money] NULL,
	[UnitPriceDiscount] [money] NULL,
	[LineTotal] [numeric](38, 6) NULL,
	[rowguid] [uniqueidentifier] NULL,
	[ModifiedDate] [datetime] NULL,
	[SOURCE_SYSTEM] [nvarchar](4) NULL,
	[LOAD_DATE] [datetime] NULL,
	[LOAD_ID] [int] NULL,
	[HASH] [nvarchar](32) NULL
) ON [PRIMARY]
END
GO
/****** Object:  Table [ODS].[AWSalesOrderDetail_Delta]    Script Date: 3/28/2025 10:07:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ODS].[AWSalesOrderDetail_Delta]') AND type in (N'U'))
BEGIN
CREATE TABLE [ODS].[AWSalesOrderDetail_Delta](
	[Action] [nvarchar](16) NULL,
	[Action_LOAD_ID] [int] NULL,
	[SalesOrderID] [int] NULL,
	[SalesOrderDetailID] [int] NULL,
	[OrderQty] [smallint] NULL,
	[ProductID] [int] NULL,
	[UnitPrice] [money] NULL,
	[UnitPriceDiscount] [money] NULL,
	[LineTotal] [numeric](38, 6) NULL,
	[rowguid] [uniqueidentifier] NULL,
	[ModifiedDate] [datetime] NULL,
	[SOURCE_SYSTEM] [nvarchar](4) NULL,
	[LOAD_DATE] [datetime] NULL,
	[LOAD_ID] [int] NULL,
	[HASH] [nvarchar](32) NULL
) ON [PRIMARY]
END
GO
/****** Object:  Table [Stage].[AWAddress]    Script Date: 3/28/2025 10:07:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Stage].[AWAddress]') AND type in (N'U'))
BEGIN
CREATE TABLE [Stage].[AWAddress](
	[AddressID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[AddressLine1] [nvarchar](60) NOT NULL,
	[AddressLine2] [nvarchar](60) NULL,
	[City] [nvarchar](30) NOT NULL,
	[StateProvince] [nvarchar](50) NOT NULL,
	[CountryRegion] [nvarchar](50) NOT NULL,
	[PostalCode] [nvarchar](15) NOT NULL,
	[rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[ModifiedDate] [datetime] NOT NULL,
	[SOURCE_SYSTEM] [nvarchar](4) NULL,
	[LOAD_DATE] [datetime] NULL,
	[LOAD_ID] [int] NULL,
	[HASH] [nvarchar](32) NULL
) ON [PRIMARY]
END
GO
/****** Object:  Table [Stage].[AWSalesOrderDetail]    Script Date: 3/28/2025 10:07:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Stage].[AWSalesOrderDetail]') AND type in (N'U'))
BEGIN
CREATE TABLE [Stage].[AWSalesOrderDetail](
	[SalesOrderID] [int] NULL,
	[SalesOrderDetailID] [int] NULL,
	[OrderQty] [smallint] NULL,
	[ProductID] [int] NULL,
	[UnitPrice] [money] NULL,
	[UnitPriceDiscount] [money] NULL,
	[LineTotal] [numeric](38, 6) NULL,
	[rowguid] [uniqueidentifier] NULL,
	[ModifiedDate] [datetime] NULL,
	[SOURCE_SYSTEM] [nvarchar](4) NULL,
	[LOAD_DATE] [datetime] NULL,
	[LOAD_ID] [int] NULL,
	[HASH] [nvarchar](32) NULL
) ON [PRIMARY]
END
GO
/****** Object:  StoredProcedure [ETL].[RegisterExecution]    Script Date: 3/28/2025 10:07:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ETL].[RegisterExecution]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [ETL].[RegisterExecution] AS' 
END
GO



ALTER   PROCEDURE [ETL].[RegisterExecution] 
    @BATCH_ID INT,
    @PACKAGE_NAME NVARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @CURRENT_TIME DATETIME = GETDATE();
    DECLARE @EXECUTION_ID INT =0;
	DECLARE @EXECUTION_COUNT INT =0;

	--Select count of of executions
	 SET @EXECUTION_COUNT = 
	 (
	 SELECT COUNT(1)
	 FROM [ETL].[Executions] 
	 WHERE [PackageName] = @PACKAGE_NAME 
	 )





    -- Check for running packages with the same name and batch ID, except for BATCH_ID = 0
    IF @BATCH_ID <> 0 AND EXISTS (
        SELECT 1 
        FROM [ETL].[Executions] 
        WHERE [BatchID] = @BATCH_ID 
          AND [PackageName] = @PACKAGE_NAME 
          AND [Status] = 'R'
    )
    BEGIN
           SELECT 'E' AS Status, NULL AS EXEC_ID, @EXECUTION_COUNT AS ExecutionCount ; 
			-- Indicate an error
        RETURN;
    END



	-- Check for finished packages with the same name and batch ID, except for BATCH_ID = 0
    IF @BATCH_ID <> 0 AND EXISTS (
        SELECT 1 
        FROM [ETL].[Executions] 
        WHERE [BatchID] = @BATCH_ID 
          AND [PackageName] = @PACKAGE_NAME 
          AND [Status] = 'F'
    )
    BEGIN
           SELECT 'F' AS Status, NULL AS EXEC_ID, @EXECUTION_COUNT AS ExecutionCount ; 
			-- Indicate an error
        RETURN;
    END



    -- Get next Execution ID from sequence
    SELECT @EXECUTION_ID = NEXT VALUE FOR [ETL].[SeqExecID];

    -- Insert new execution record
    INSERT INTO [ETL].[Executions] (
        [ExecutionId], 
        [BatchID], 
        [PackageName], 
        [Started], 
        [Status]
    ) VALUES (
        @EXECUTION_ID, 
        @BATCH_ID, 
        @PACKAGE_NAME, 
        @CURRENT_TIME, 
        'R'
    );

    -- Set the output status to indicate success
    SELECT 'R' AS Status, @EXECUTION_ID AS EXEC_ID,@EXECUTION_COUNT As ExecutionCount ;
	RETURN 
END;
GO
/****** Object:  StoredProcedure [ETL].[SetExecutionStatus]    Script Date: 3/28/2025 10:07:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ETL].[SetExecutionStatus]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [ETL].[SetExecutionStatus] AS' 
END
GO

ALTER PROCEDURE [ETL].[SetExecutionStatus]
    @ExecutionId INT,
    @BatchID INT,
    @Status NVARCHAR(1),
    @SourceRowCount INT,
    @DestRowCount INT,
    @Inserted INT,
    @Updated INT,
    @Deleted INT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @CURRENT_TIME DATETIME = GETDATE();



    -- Update the execution record with the provided parameters
    UPDATE [ETL].[Executions]
    SET 
        [Status] = @Status,
        [SourceRowCount] = @SourceRowCount,
        [DestRowCount] = @DestRowCount,
        [Inserted] = @Inserted,
        [Updated] = @Updated,
        [Deleted] = @Deleted,
        [Ended] = CASE WHEN @Status = 'C' THEN @CURRENT_TIME ELSE [Ended] END
    WHERE 
        [ExecutionId] = @ExecutionId
        AND [BatchID] = @BatchID;

    -- Return the status
    SELECT @Status AS Status;
END;
GO
IF NOT EXISTS (SELECT * FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'SalesLT', NULL,NULL, NULL,NULL))
	EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Contains objects related to products, customers, sales orders, and sales territories.' , @level0type=N'SCHEMA',@level0name=N'SalesLT'
GO
ALTER DATABASE [JAV0032] SET  READ_WRITE 
GO
