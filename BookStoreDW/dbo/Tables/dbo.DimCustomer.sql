CREATE TABLE [dbo].[DimCustomer] (
    [CustomerKey]   INT           IDENTITY (1, 1) NOT NULL,
    [CustomerID]    INT           NULL,
    [FirstName]     VARCHAR (200) NULL,
    [LastName]      VARCHAR (200) NULL,
    [Email]         VARCHAR (350) NULL,
    [StreetName]    VARCHAR (200) NULL,
    [StreetNumber]  VARCHAR (10)  NULL,
    [City]          VARCHAR (100) NULL,
    [CountryName]   VARCHAR (200) NULL,
    [AddressStatus] VARCHAR (30)  NULL,
    PRIMARY KEY CLUSTERED ([CustomerKey] ASC)
);

