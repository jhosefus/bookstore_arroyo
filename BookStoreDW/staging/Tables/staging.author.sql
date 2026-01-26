CREATE TABLE [staging].[author] (
    [AuthorID]        INT           NULL,
    [AuthorName]      VARCHAR (400) NULL,
    [RowVersionStart] BIGINT        NULL,
    [RowVersionEnd]   BIGINT        NULL,
    [LoadDate]        DATETIME      DEFAULT (getdate()) NULL
);

