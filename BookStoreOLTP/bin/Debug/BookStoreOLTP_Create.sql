/*
Script de implementación para BookStoreOLTP

Este código lo generó una herramienta.
Los cambios en este archivo pueden provocar un comportamiento incorrecto y se perderán si
el código se vuelve a generar.
*/

GO
SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, CONCAT_NULL_YIELDS_NULL, QUOTED_IDENTIFIER ON;

SET NUMERIC_ROUNDABORT OFF;


GO
:setvar DatabaseName "BookStoreOLTP"
:setvar DefaultFilePrefix "BookStoreOLTP"
:setvar DefaultDataPath ""
:setvar DefaultLogPath ""

GO
:on error exit
GO
/*
Detecte el modo SQLCMD y deshabilite la ejecución de scripts si no se admite el modo SQLCMD.
Para volver a habilitar el script después de habilitar el modo SQLCMD, ejecute lo siguiente:
ESTABLECER NOEXEC DESACTIVADO; 
*/
:setvar __IsSqlCmdEnabled "True"
GO
IF N'$(__IsSqlCmdEnabled)' NOT LIKE N'True'
    BEGIN
        PRINT N'El modo SQLCMD debe estar habilitado para ejecutar correctamente este script.';
        SET NOEXEC ON;
    END


GO
USE [master];


GO

IF (DB_ID(N'$(DatabaseName)') IS NOT NULL) 
BEGIN
    ALTER DATABASE [$(DatabaseName)]
    SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE [$(DatabaseName)];
END

GO
PRINT N'Creando la base de datos $(DatabaseName)...'
GO
CREATE DATABASE [$(DatabaseName)] COLLATE Modern_Spanish_CI_AS
GO
USE [$(DatabaseName)];


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET ANSI_NULLS OFF,
                ANSI_PADDING OFF,
                ANSI_WARNINGS OFF,
                ARITHABORT OFF,
                CONCAT_NULL_YIELDS_NULL OFF,
                NUMERIC_ROUNDABORT OFF,
                QUOTED_IDENTIFIER OFF,
                ANSI_NULL_DEFAULT OFF,
                CURSOR_DEFAULT GLOBAL,
                RECOVERY FULL,
                CURSOR_CLOSE_ON_COMMIT OFF,
                AUTO_CREATE_STATISTICS ON,
                AUTO_SHRINK OFF,
                AUTO_UPDATE_STATISTICS ON,
                RECURSIVE_TRIGGERS OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET ALLOW_SNAPSHOT_ISOLATION OFF;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET READ_COMMITTED_SNAPSHOT OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET AUTO_UPDATE_STATISTICS_ASYNC OFF,
                PAGE_VERIFY CHECKSUM,
                DATE_CORRELATION_OPTIMIZATION OFF,
                DISABLE_BROKER,
                PARAMETERIZATION SIMPLE,
                SUPPLEMENTAL_LOGGING OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF IS_SRVROLEMEMBER(N'sysadmin') = 1
    BEGIN
        IF EXISTS (SELECT 1
                   FROM   [master].[dbo].[sysdatabases]
                   WHERE  [name] = N'$(DatabaseName)')
            BEGIN
                EXECUTE sp_executesql N'ALTER DATABASE [$(DatabaseName)]
    SET TRUSTWORTHY OFF,
        DB_CHAINING OFF 
    WITH ROLLBACK IMMEDIATE';
            END
    END
ELSE
    BEGIN
        PRINT N'No se puede modificar la configuración de la base de datos. Debe ser un administrador del sistema para poder aplicar esta configuración.';
    END


GO
IF IS_SRVROLEMEMBER(N'sysadmin') = 1
    BEGIN
        IF EXISTS (SELECT 1
                   FROM   [master].[dbo].[sysdatabases]
                   WHERE  [name] = N'$(DatabaseName)')
            BEGIN
                EXECUTE sp_executesql N'ALTER DATABASE [$(DatabaseName)]
    SET HONOR_BROKER_PRIORITY OFF 
    WITH ROLLBACK IMMEDIATE';
            END
    END
ELSE
    BEGIN
        PRINT N'No se puede modificar la configuración de la base de datos. Debe ser un administrador del sistema para poder aplicar esta configuración.';
    END


GO
ALTER DATABASE [$(DatabaseName)]
    SET TARGET_RECOVERY_TIME = 60 SECONDS 
    WITH ROLLBACK IMMEDIATE;


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET FILESTREAM(NON_TRANSACTED_ACCESS = OFF),
                CONTAINMENT = NONE 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET AUTO_CREATE_STATISTICS ON(INCREMENTAL = OFF),
                MEMORY_OPTIMIZED_ELEVATE_TO_SNAPSHOT = OFF,
                DELAYED_DURABILITY = DISABLED 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET QUERY_STORE (QUERY_CAPTURE_MODE = AUTO, OPERATION_MODE = READ_WRITE, DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_PLANS_PER_QUERY = 200, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), MAX_STORAGE_SIZE_MB = 1000) 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET MAXDOP = PRIMARY;
        ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET LEGACY_CARDINALITY_ESTIMATION = PRIMARY;
        ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET PARAMETER_SNIFFING = PRIMARY;
        ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET QUERY_OPTIMIZER_HOTFIXES = PRIMARY;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET TEMPORAL_HISTORY_RETENTION ON 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF fulltextserviceproperty(N'IsFulltextInstalled') = 1
    EXECUTE sp_fulltext_database 'enable';


GO
PRINT N'Creando Tabla [dbo].[order_history]...';


GO
CREATE TABLE [dbo].[order_history] (
    [history_id]  INT        IDENTITY (1, 1) NOT NULL,
    [order_id]    INT        NULL,
    [status_id]   INT        NULL,
    [status_date] DATETIME   NULL,
    [rowversion]  ROWVERSION NOT NULL,
    CONSTRAINT [pk_orderhist] PRIMARY KEY CLUSTERED ([history_id] ASC)
);


GO
PRINT N'Creando Tabla [dbo].[order_line]...';


GO
CREATE TABLE [dbo].[order_line] (
    [line_id]    INT            IDENTITY (1, 1) NOT NULL,
    [order_id]   INT            NULL,
    [book_id]    INT            NULL,
    [price]      DECIMAL (5, 2) NULL,
    [rowversion] ROWVERSION     NOT NULL,
    CONSTRAINT [pk_orderline] PRIMARY KEY CLUSTERED ([line_id] ASC)
);


GO
PRINT N'Creando Tabla [dbo].[order_status]...';


GO
CREATE TABLE [dbo].[order_status] (
    [status_id]    INT          NOT NULL,
    [status_value] VARCHAR (20) NULL,
    [rowversion]   ROWVERSION   NOT NULL,
    CONSTRAINT [pk_orderstatus] PRIMARY KEY CLUSTERED ([status_id] ASC)
);


GO
PRINT N'Creando Tabla [dbo].[cust_order]...';


GO
CREATE TABLE [dbo].[cust_order] (
    [order_id]           INT        IDENTITY (1, 1) NOT NULL,
    [order_date]         DATETIME   NULL,
    [customer_id]        INT        NULL,
    [shipping_method_id] INT        NULL,
    [dest_address_id]    INT        NULL,
    [rowversion]         ROWVERSION NOT NULL,
    CONSTRAINT [pk_custorder] PRIMARY KEY CLUSTERED ([order_id] ASC)
);


GO
PRINT N'Creando Tabla [dbo].[shipping_method]...';


GO
CREATE TABLE [dbo].[shipping_method] (
    [method_id]   INT            NOT NULL,
    [method_name] VARCHAR (100)  NULL,
    [cost]        DECIMAL (6, 2) NULL,
    [rowversion]  ROWVERSION     NOT NULL,
    CONSTRAINT [pk_shipmethod] PRIMARY KEY CLUSTERED ([method_id] ASC)
);


GO
PRINT N'Creando Tabla [dbo].[customer_address]...';


GO
CREATE TABLE [dbo].[customer_address] (
    [customer_id] INT        NOT NULL,
    [address_id]  INT        NOT NULL,
    [status_id]   INT        NULL,
    [rowversion]  ROWVERSION NOT NULL,
    CONSTRAINT [pk_custaddr] PRIMARY KEY CLUSTERED ([customer_id] ASC, [address_id] ASC)
);


GO
PRINT N'Creando Tabla [dbo].[customer]...';


GO
CREATE TABLE [dbo].[customer] (
    [customer_id] INT           NOT NULL,
    [first_name]  VARCHAR (200) NULL,
    [last_name]   VARCHAR (200) NULL,
    [email]       VARCHAR (350) NULL,
    [rowversion]  ROWVERSION    NOT NULL,
    CONSTRAINT [pk_customer] PRIMARY KEY CLUSTERED ([customer_id] ASC)
);


GO
PRINT N'Creando Tabla [dbo].[address]...';


GO
CREATE TABLE [dbo].[address] (
    [address_id]    INT           NOT NULL,
    [street_number] VARCHAR (10)  NULL,
    [street_name]   VARCHAR (200) NULL,
    [city]          VARCHAR (100) NULL,
    [country_id]    INT           NULL,
    [rowversion]    ROWVERSION    NOT NULL,
    CONSTRAINT [pk_address] PRIMARY KEY CLUSTERED ([address_id] ASC)
);


GO
PRINT N'Creando Tabla [dbo].[country]...';


GO
CREATE TABLE [dbo].[country] (
    [country_id]   INT           NOT NULL,
    [country_name] VARCHAR (200) NULL,
    [rowversion]   ROWVERSION    NOT NULL,
    CONSTRAINT [pk_country] PRIMARY KEY CLUSTERED ([country_id] ASC)
);


GO
PRINT N'Creando Tabla [dbo].[address_status]...';


GO
CREATE TABLE [dbo].[address_status] (
    [status_id]      INT          NOT NULL,
    [address_status] VARCHAR (30) NULL,
    [rowversion]     ROWVERSION   NOT NULL,
    CONSTRAINT [pk_addr_status] PRIMARY KEY CLUSTERED ([status_id] ASC)
);


GO
PRINT N'Creando Tabla [dbo].[book_author]...';


GO
CREATE TABLE [dbo].[book_author] (
    [book_id]    INT        NOT NULL,
    [author_id]  INT        NOT NULL,
    [rowversion] ROWVERSION NOT NULL,
    CONSTRAINT [pk_bookauthor] PRIMARY KEY CLUSTERED ([book_id] ASC, [author_id] ASC)
);


GO
PRINT N'Creando Tabla [dbo].[book]...';


GO
CREATE TABLE [dbo].[book] (
    [book_id]          INT           NOT NULL,
    [title]            VARCHAR (400) NULL,
    [isbn13]           VARCHAR (13)  NULL,
    [language_id]      INT           NULL,
    [num_pages]        INT           NULL,
    [publication_date] DATE          NULL,
    [publisher_id]     INT           NULL,
    [rowversion]       ROWVERSION    NOT NULL,
    CONSTRAINT [pk_book] PRIMARY KEY CLUSTERED ([book_id] ASC)
);


GO
PRINT N'Creando Tabla [dbo].[book_language]...';


GO
CREATE TABLE [dbo].[book_language] (
    [language_id]   INT          NOT NULL,
    [language_code] VARCHAR (8)  NULL,
    [language_name] VARCHAR (50) NULL,
    [rowversion]    ROWVERSION   NOT NULL,
    CONSTRAINT [pk_language] PRIMARY KEY CLUSTERED ([language_id] ASC)
);


GO
PRINT N'Creando Tabla [dbo].[publisher]...';


GO
CREATE TABLE [dbo].[publisher] (
    [publisher_id]   INT           NOT NULL,
    [publisher_name] VARCHAR (400) NULL,
    [rowversion]     ROWVERSION    NOT NULL,
    CONSTRAINT [pk_publisher] PRIMARY KEY CLUSTERED ([publisher_id] ASC)
);


GO
PRINT N'Creando Tabla [dbo].[author]...';


GO
CREATE TABLE [dbo].[author] (
    [author_id]   INT           NOT NULL,
    [author_name] VARCHAR (400) NULL,
    [rowversion]  ROWVERSION    NOT NULL,
    CONSTRAINT [pk_author] PRIMARY KEY CLUSTERED ([author_id] ASC)
);


GO
PRINT N'Creando Clave externa [dbo].[fk_oh_order]...';


GO
ALTER TABLE [dbo].[order_history]
    ADD CONSTRAINT [fk_oh_order] FOREIGN KEY ([order_id]) REFERENCES [dbo].[cust_order] ([order_id]);


GO
PRINT N'Creando Clave externa [dbo].[fk_oh_status]...';


GO
ALTER TABLE [dbo].[order_history]
    ADD CONSTRAINT [fk_oh_status] FOREIGN KEY ([status_id]) REFERENCES [dbo].[order_status] ([status_id]);


GO
PRINT N'Creando Clave externa [dbo].[fk_ol_book]...';


GO
ALTER TABLE [dbo].[order_line]
    ADD CONSTRAINT [fk_ol_book] FOREIGN KEY ([book_id]) REFERENCES [dbo].[book] ([book_id]);


GO
PRINT N'Creando Clave externa [dbo].[fk_ol_order]...';


GO
ALTER TABLE [dbo].[order_line]
    ADD CONSTRAINT [fk_ol_order] FOREIGN KEY ([order_id]) REFERENCES [dbo].[cust_order] ([order_id]);


GO
PRINT N'Creando Clave externa [dbo].[fk_order_addr]...';


GO
ALTER TABLE [dbo].[cust_order]
    ADD CONSTRAINT [fk_order_addr] FOREIGN KEY ([dest_address_id]) REFERENCES [dbo].[address] ([address_id]);


GO
PRINT N'Creando Clave externa [dbo].[fk_order_cust]...';


GO
ALTER TABLE [dbo].[cust_order]
    ADD CONSTRAINT [fk_order_cust] FOREIGN KEY ([customer_id]) REFERENCES [dbo].[customer] ([customer_id]);


GO
PRINT N'Creando Clave externa [dbo].[fk_order_ship]...';


GO
ALTER TABLE [dbo].[cust_order]
    ADD CONSTRAINT [fk_order_ship] FOREIGN KEY ([shipping_method_id]) REFERENCES [dbo].[shipping_method] ([method_id]);


GO
PRINT N'Creando Clave externa [dbo].[fk_ca_addr]...';


GO
ALTER TABLE [dbo].[customer_address]
    ADD CONSTRAINT [fk_ca_addr] FOREIGN KEY ([address_id]) REFERENCES [dbo].[address] ([address_id]);


GO
PRINT N'Creando Clave externa [dbo].[fk_ca_cust]...';


GO
ALTER TABLE [dbo].[customer_address]
    ADD CONSTRAINT [fk_ca_cust] FOREIGN KEY ([customer_id]) REFERENCES [dbo].[customer] ([customer_id]);


GO
PRINT N'Creando Clave externa [dbo].[fk_customer_address_addres_status_id]...';


GO
ALTER TABLE [dbo].[customer_address]
    ADD CONSTRAINT [fk_customer_address_addres_status_id] FOREIGN KEY ([status_id]) REFERENCES [dbo].[address_status] ([status_id]) ON DELETE CASCADE ON UPDATE CASCADE;


GO
PRINT N'Creando Clave externa [dbo].[fk_addr_ctry]...';


GO
ALTER TABLE [dbo].[address]
    ADD CONSTRAINT [fk_addr_ctry] FOREIGN KEY ([country_id]) REFERENCES [dbo].[country] ([country_id]);


GO
PRINT N'Creando Clave externa [dbo].[fk_ba_author]...';


GO
ALTER TABLE [dbo].[book_author]
    ADD CONSTRAINT [fk_ba_author] FOREIGN KEY ([author_id]) REFERENCES [dbo].[author] ([author_id]);


GO
PRINT N'Creando Clave externa [dbo].[fk_ba_book]...';


GO
ALTER TABLE [dbo].[book_author]
    ADD CONSTRAINT [fk_ba_book] FOREIGN KEY ([book_id]) REFERENCES [dbo].[book] ([book_id]);


GO
PRINT N'Creando Clave externa [dbo].[fk_book_lang]...';


GO
ALTER TABLE [dbo].[book]
    ADD CONSTRAINT [fk_book_lang] FOREIGN KEY ([language_id]) REFERENCES [dbo].[book_language] ([language_id]);


GO
PRINT N'Creando Clave externa [dbo].[fk_book_pub]...';


GO
ALTER TABLE [dbo].[book]
    ADD CONSTRAINT [fk_book_pub] FOREIGN KEY ([publisher_id]) REFERENCES [dbo].[publisher] ([publisher_id]);


GO
PRINT N'Creando Procedimiento [dbo].[GetAddressChangesByRowVersion]...';


GO
CREATE PROCEDURE [dbo].[GetAddressChangesByRowVersion]
(
   @startRow BIGINT 
   ,@endRow  BIGINT 
)
AS
BEGIN
	select 
	a.[address_id]
	,a.[street_name]
	,a.[street_number]
	,a.[city]
	,co.[country_name]
  FROM [dbo].[address] a
  JOIN [dbo].[country] co on (a.country_id = co.country_id)
  WHERE (a.[rowversion] > CONVERT(ROWVERSION,@startRow) AND a.[rowversion] <= CONVERT(ROWVERSION,@endRow))
  OR (co.[rowversion] > CONVERT(ROWVERSION,@startRow) AND co.[rowversion] <= CONVERT(ROWVERSION,@endRow))
END
GO
PRINT N'Creando Procedimiento [dbo].[GetBookChangesByRowVersion]...';


GO
CREATE PROCEDURE [dbo].[GetBookChangesByRowVersion]
(
   @startRow BIGINT 
   ,@endRow  BIGINT 
)
AS
BEGIN
  SELECT b.[book_id]
      ,b.[title]
      ,b.[isbn13]
      ,bl.[language_code]
      ,bl.[language_name]
      ,b.[num_pages]
      ,b.[publication_date]
      ,p.[publisher_name]
      ,a.[author_name]
    FROM [dbo].[book] b
    INNER JOIN [dbo].[book_language] bl ON b.language_id = bl.language_id
    INNER JOIN [dbo].[publisher] p ON b.publisher_id = p.publisher_id
    INNER JOIN [dbo].[book_author] ba ON b.book_id = ba.book_id
    INNER JOIN [dbo].[author] a ON ba.author_id = a.author_id
    WHERE (b.[rowversion] > CONVERT(ROWVERSION,@startRow) AND b.[rowversion] <= CONVERT(ROWVERSION,@endRow))
  OR (bl.[rowversion] > CONVERT(ROWVERSION,@startRow) AND bl.[rowversion] <= CONVERT(ROWVERSION,@endRow))
  OR (p.[rowversion] > CONVERT(ROWVERSION,@startRow) AND p.[rowversion] <= CONVERT(ROWVERSION,@endRow))
    OR (ba.[rowversion] > CONVERT(ROWVERSION,@startRow) AND ba.[rowversion] <= CONVERT(ROWVERSION,@endRow))
  OR (a.[rowversion] > CONVERT(ROWVERSION,@startRow) AND a.[rowversion] <= CONVERT(ROWVERSION,@endRow))
END



-- Address
SET ANSI_NULLS ON
GO
PRINT N'Creando Procedimiento [dbo].[GetCustomerChangesByRowVersion]...';


GO
CREATE PROCEDURE [dbo].[GetCustomerChangesByRowVersion]
(
   @startRow BIGINT 
   ,@endRow  BIGINT 
)
AS
BEGIN
	select c.[customer_id]
      ,c.[first_name]
      ,c.[last_name]
      ,c.[email]
	  ,a.[street_name]
	  ,a.[street_number]
	  ,a.city
	  ,adds.address_status
	  ,co.country_name
  FROM [Bookstore].[dbo].[customer] c
  JOIN [dbo].[customer_address] ca ON (c.customer_id = ca.customer_id)
  JOIN [dbo].[address_status] adds ON (ca.status_id = adds.status_id)
  JOIN [dbo].[address] a ON (ca.address_id = a.address_id)
  JOIN [dbo].[country] co on (a.country_id = co.country_id)
  WHERE (c.[rowversion] > CONVERT(ROWVERSION,@startRow) AND c.[rowversion] <= CONVERT(ROWVERSION,@endRow))
  OR (ca.[rowversion] > CONVERT(ROWVERSION,@startRow) AND ca.[rowversion] <= CONVERT(ROWVERSION,@endRow))
  OR (adds.[rowversion] > CONVERT(ROWVERSION,@startRow) AND adds.[rowversion] <= CONVERT(ROWVERSION,@endRow))
  OR (a.[rowversion] > CONVERT(ROWVERSION,@startRow) AND a.[rowversion] <= CONVERT(ROWVERSION,@endRow))
  OR (co.[rowversion] > CONVERT(ROWVERSION,@startRow) AND co.[rowversion] <= CONVERT(ROWVERSION,@endRow))
END



-- BOOK
SET ANSI_NULLS ON
GO
PRINT N'Creando Procedimiento [dbo].[GetShippingMethodChangesByRowVersion]...';


GO
CREATE PROCEDURE [dbo].[GetShippingMethodChangesByRowVersion]
(
   @startRow BIGINT 
   ,@endRow  BIGINT 
)
AS
BEGIN
	SELECT [method_id]
      ,[method_name]
      ,[cost]
	  FROM [dbo].[shipping_method]
	  WHERE [rowversion] > CONVERT(ROWVERSION,@startRow) 
	  AND [rowversion] <= CONVERT(ROWVERSION,@endRow)
END

--CUSTOMER
SET ANSI_NULLS ON
GO
PRINT N'Creando Procedimiento [dbo].[GetDatabaseRowVersion]...';


GO
CREATE PROCEDURE [dbo].[GetDatabaseRowVersion]
AS
BEGIN
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	SET NOCOUNT ON

	SELECT DBTS = (CONVERT(BIGINT,MIN_ACTIVE_ROWVERSION())-1);
END


-- Shipping Method
SET ANSI_NULLS ON
GO
DECLARE @VarDecimalSupported AS BIT;

SELECT @VarDecimalSupported = 0;

IF ((ServerProperty(N'EngineEdition') = 3)
    AND (((@@microsoftversion / power(2, 24) = 9)
          AND (@@microsoftversion & 0xffff >= 3024))
         OR ((@@microsoftversion / power(2, 24) = 10)
             AND (@@microsoftversion & 0xffff >= 1600))))
    SELECT @VarDecimalSupported = 1;

IF (@VarDecimalSupported > 0)
    BEGIN
        EXECUTE sp_db_vardecimal_storage_format N'$(DatabaseName)', 'ON';
    END


GO
ALTER DATABASE [$(DatabaseName)]
    SET MULTI_USER 
    WITH ROLLBACK IMMEDIATE;


GO
PRINT N'Actualización completada.';


GO
