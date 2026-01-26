CREATE TABLE [dbo].[DimAuthor] (
    [AuthorKey]  INT           IDENTITY (1, 1) NOT NULL,
    [AuthorID]   INT           NULL,
    [AuthorName] VARCHAR (400) NULL,
    PRIMARY KEY CLUSTERED ([AuthorKey] ASC)
);

