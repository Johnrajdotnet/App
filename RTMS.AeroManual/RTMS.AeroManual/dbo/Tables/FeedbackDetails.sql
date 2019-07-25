CREATE TABLE [dbo].[FeedbackDetails] (
    [Id]           BIGINT           IDENTITY (1, 1) NOT NULL,
    [FeedbackData] NVARCHAR (MAX)   NOT NULL,
    [CreatedBy]    UNIQUEIDENTIFIER NOT NULL,
    [CreatedDate]  DATETIME         CONSTRAINT [DF_FeedbackDetails_CreatedDate] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_FeedbackDetails] PRIMARY KEY CLUSTERED ([Id] ASC)
);

