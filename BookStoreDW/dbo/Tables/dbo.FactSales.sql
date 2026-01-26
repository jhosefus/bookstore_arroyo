CREATE TABLE [dbo].[FactSales] (
    [FactID]            BIGINT          IDENTITY (1, 1) NOT NULL,
    [DateKey]           INT             NULL,
    [CustomerKey]       INT             NULL,
    [BookKey]           INT             NULL,
    [AuthorKey]         INT             NULL,
    [ShippingMethodKey] INT             NULL,
    [OrderStatusKey]    INT             NULL,
    [Quantity]          INT             NULL,
    [Price]             DECIMAL (10, 2) NULL,
    [TotalAmount]       DECIMAL (12, 2) NULL,
    [StatusDate]        DATETIME        NULL,
    PRIMARY KEY CLUSTERED ([FactID] ASC),
    FOREIGN KEY ([AuthorKey]) REFERENCES [dbo].[DimAuthor] ([AuthorKey]),
    FOREIGN KEY ([BookKey]) REFERENCES [dbo].[DimBook] ([BookKey]),
    FOREIGN KEY ([CustomerKey]) REFERENCES [dbo].[DimCustomer] ([CustomerKey]),
    FOREIGN KEY ([DateKey]) REFERENCES [dbo].[DimDate] ([DateKey]),
    FOREIGN KEY ([OrderStatusKey]) REFERENCES [dbo].[DimOrderStatus] ([OrderStatusKey]),
    FOREIGN KEY ([ShippingMethodKey]) REFERENCES [dbo].[DimShippingMethod] ([ShippingMethodKey])
);

