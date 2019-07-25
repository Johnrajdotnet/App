CREATE TABLE [TManual].[ST_Engine_Series_Type] (
    [Id]                      BIGINT         IDENTITY (1, 1) NOT NULL,
    [EngineTypeId]            INT            NOT NULL,
	[EngineSeriesFamilyName]  NVARCHAR (100) NULL,
    [EngineSeriesName]        NVARCHAR (100) NOT NULL,
    [EngineSeriesDescription] NVARCHAR (300) NOT NULL,
	[EngineSeriesFolderName] NVARCHAR (200)  NOT NULL,
    [EngineMarkPageTitle]     NVARCHAR (200) NOT NULL,
	[IsManual]				  BIT			 NOT NULL DEFAULT ((0)),
	[FailedCount]	          INT			 NOT NULL DEFAULT ((0)),
    [IssueDate]               DATETIME       NULL,
    [SyncDate]                DATETIME       NULL,
    [SyncStatus]              NVARCHAR (50)  NOT NULL DEFAULT 'NotStarted',
    [SequenceOrder]           INT            NOT NULL,
    [Active]                  BIT            NOT NULL,
    [CreatedDate]             DATETIME       CONSTRAINT [DF_ST_Engine_Series_Type_CreatedDate] DEFAULT (getdate()) NOT NULL,
    [ModifiedDate]            DATETIME       NULL,
    CONSTRAINT [PK_ST_Engine_Series_Type] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [FK_ST_Engine_Series_Type_ST_Engine_Type1] FOREIGN KEY ([EngineTypeId]) REFERENCES [TManual].[ST_Engine_Type] ([Id])
);

