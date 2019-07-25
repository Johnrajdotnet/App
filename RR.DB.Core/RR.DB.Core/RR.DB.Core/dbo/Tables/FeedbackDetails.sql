CREATE TABLE [dbo].[FeedbackDetails] (
    [Id]           BIGINT           IDENTITY (1, 1) NOT NULL,
    [FeedbackQuery] NVARCHAR (MAX)   NOT NULL,
	[Status]		NVARCHAR(50)	NULL,
	[Remarks]		NVARCHAR (MAX)  NULL,	
    [CreatedBy]    UNIQUEIDENTIFIER NOT NULL,
    [CreatedDate]  DATETIME         CONSTRAINT [DF_FeedbackDetails_CreatedDate] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_FeedbackDetails] PRIMARY KEY CLUSTERED ([Id] ASC)
);

