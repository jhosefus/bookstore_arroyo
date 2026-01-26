CREATE TABLE [dbo].[DimOrderStatus] (
    [OrderStatusKey] INT          IDENTITY (1, 1) NOT NULL,
    [StatusID]       INT          NULL,
    [StatusValue]    VARCHAR (20) NULL,
    PRIMARY KEY CLUSTERED ([OrderStatusKey] ASC)
);

