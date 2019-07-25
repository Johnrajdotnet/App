CREATE TABLE [TManual].[ST_Engine_Mark_Type] (
    [Id]                    BIGINT         IDENTITY (1, 1) NOT NULL,
    [EngineSeriesTypeId]    BIGINT         NOT NULL,
    [EngineMarkName]        NVARCHAR (50)  NOT NULL,
    [EngineMarkDescription] NVARCHAR (200) NOT NULL,
	[EngineMarkFolderName] NVARCHAR (200) NOT NULL,
    [EPublicationTitleName] NVARCHAR (200) NULL,
    [SyncDate]              DATETIME       NULL,
    [SyncStatus]            NVARCHAR (50)  NULL,
    [SequenceOrder]         INT            NOT NULL,
    [Active]                BIT            NOT NULL,
    [CreatedDate]           DATETIME       CONSTRAINT [DF_ST_Engine_Mark_Type_CreatedDate] DEFAULT (getdate()) NOT NULL,
    [ModifiedDate]          DATETIME       NULL,
    CONSTRAINT [PK_ST_Engine_Mark_Type] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [FK_ST_Engine_Mark_Type_ST_Engine_Series_Type] FOREIGN KEY ([EngineSeriesTypeId]) REFERENCES [TManual].[ST_Engine_Series_Type] ([Id])
);

