CREATE TABLE [dbo].[DimShippingMethod] (
    [ShippingMethodKey] INT            IDENTITY (1, 1) NOT NULL,
    [MethodID]          INT            NULL,
    [MethodName]        VARCHAR (100)  NULL,
    [Cost]              DECIMAL (6, 2) NULL,
    PRIMARY KEY CLUSTERED ([ShippingMethodKey] ASC)
);

