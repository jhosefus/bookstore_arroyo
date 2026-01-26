CREATE TABLE [staging].[orderStatus] (
    [StatusID]        INT          NULL,
    [StatusValue]     VARCHAR (20) NULL,
    [RowVersionStart] BIGINT       NULL,
    [RowVersionEnd]   BIGINT       NULL,
    [LoadDate]        DATETIME     DEFAULT (getdate()) NULL
);

