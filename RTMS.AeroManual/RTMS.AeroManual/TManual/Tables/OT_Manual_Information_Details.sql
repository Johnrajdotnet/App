CREATE TABLE [TManual].[OT_Manual_Information_Details] (
    [Id]                    BIGINT         IDENTITY (1, 1) NOT NULL,
    [PublicationNodeId]     BIGINT         NOT NULL,
    [TaskOrTitleName]             NVARCHAR (300) NULL,
    [ATANumber]             NVARCHAR (50)  NULL,
    [FunctionalCode]        INT  NULL,
	[ChapterLevel]        NVARCHAR (200) NULL,
    [SectionLevel]        NVARCHAR (200) NULL,
    [PageBlockLevelName]  NVARCHAR (200) NULL,
    [RepairSchemeNumber]    NVARCHAR (50)  NULL,
	[PageContent]		TEXT NULL,	
	[FileServerPath]    NVARCHAR (Max)  NULL,
	[IsDownloadSuccess]    BIT NULL,
	[IsManualOutDated]		BIT				 NOT NULL DEFAULT ((0)),
    [CreatedDate]           DATETIME       CONSTRAINT [DF_OT_Publication_Manual_Details_CreatedDate] DEFAULT (getdate()) NOT NULL,
    [ModifiedDate]          DATETIME       NULL,
    CONSTRAINT [PK_OT_Publication_Manual_Details] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [FK_OT_Publication_Manual_Details_ST_Builder_Publication_Node_Details] FOREIGN KEY ([PublicationNodeId]) REFERENCES [TManual].[ST_Publication_Node_Details] ([Id])
);

