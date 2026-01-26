CREATE TABLE [staging].[book] (
    [BookID]          INT           NULL,
    [Title]           VARCHAR (400) NULL,
    [ISBN13]          VARCHAR (13)  NULL,
    [NumPages]        INT           NULL,
    [PublicationDate] DATE          NULL,
    [LanguageCode]    VARCHAR (8)   NULL,
    [LanguageName]    VARCHAR (50)  NULL,
    [PublisherName]   VARCHAR (400) NULL,
    [RowVersionStart] BIGINT        NULL,
    [RowVersionEnd]   BIGINT        NULL,
    [LoadDate]        DATETIME      DEFAULT (getdate()) NULL
);

