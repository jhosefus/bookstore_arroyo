CREATE TABLE [staging].[orderLine] (
    [OrderID]          INT             NULL,
    [LineID]           INT             NULL,
    [BookID]           INT             NULL,
    [AuthorID]         INT             NULL,
    [Price]            DECIMAL (10, 2) NULL,
    [Quantity]         INT             DEFAULT ((1)) NULL,
    [OrderDate]        DATETIME        NULL,
    [CustomerID]       INT             NULL,
    [ShippingMethodID] INT             NULL,
    [StatusID]         INT             NULL,
    [StatusDate]       DATETIME        NULL,
    [RowVersionStart]  BIGINT          NULL,
    [RowVersionEnd]    BIGINT          NULL,
    [LoadDate]         DATETIME        DEFAULT (getdate()) NULL
);

