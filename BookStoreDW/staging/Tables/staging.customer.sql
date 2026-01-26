CREATE TABLE [staging].[customer] (
    [CustomerID]      INT           NULL,
    [FirstName]       VARCHAR (200) NULL,
    [LastName]        VARCHAR (200) NULL,
    [Email]           VARCHAR (350) NULL,
    [StreetName]      VARCHAR (200) NULL,
    [StreetNumber]    VARCHAR (10)  NULL,
    [City]            VARCHAR (100) NULL,
    [CountryName]     VARCHAR (200) NULL,
    [AddressStatus]   VARCHAR (30)  NULL,
    [RowVersionStart] BIGINT        NULL,
    [RowVersionEnd]   BIGINT        NULL,
    [LoadDate]        DATETIME      DEFAULT (getdate()) NULL
);

