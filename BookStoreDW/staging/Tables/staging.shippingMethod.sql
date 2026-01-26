CREATE TABLE [staging].[shippingMethod] (
    [MethodID]        INT            NULL,
    [MethodName]      VARCHAR (100)  NULL,
    [Cost]            DECIMAL (6, 2) NULL,
    [RowVersionStart] BIGINT         NULL,
    [RowVersionEnd]   BIGINT         NULL,
    [LoadDate]        DATETIME       DEFAULT (getdate()) NULL
);

