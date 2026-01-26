CREATE TABLE [dbo].[DimBook] (
    [BookKey]         INT           IDENTITY (1, 1) NOT NULL,
    [BookID]          INT           NULL,
    [Title]           VARCHAR (400) NULL,
    [ISBN13]          VARCHAR (13)  NULL,
    [NumPages]        INT           NULL,
    [PublicationDate] DATE          NULL,
    [LanguageCode]    VARCHAR (8)   NULL,
    [LanguageName]    VARCHAR (50)  NULL,
    [PublisherName]   VARCHAR (400) NULL,
    PRIMARY KEY CLUSTERED ([BookKey] ASC)
);

