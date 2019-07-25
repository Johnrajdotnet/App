﻿CREATE TABLE [TManual].[ST_Engine_Publication_Details] (
    [Id]                           BIGINT         IDENTITY (1, 1) NOT NULL,
    [EngineTypeId]                 INT            NOT NULL,
    [EngineSeriesId]               BIGINT         NOT NULL,
    [EngineMarkId]                 BIGINT         NOT NULL,
    [EnginePublicationShotName]    NVARCHAR (50)  NULL,
    [EnginePublicationLongName]    NVARCHAR (200) NOT NULL,
    [EnginePublicationDescription] NVARCHAR (500) NULL,
	[EnginePubFolderName]		   NVARCHAR (200) NOT NULL,
	[IsManual]					   BIT			  NOT NULL DEFAULT ((0)),
	[FailedCount]	               INT			  NOT NULL DEFAULT ((0)),
    [IssueDate]                    DATETIME       NULL,
    [SyncDate]                     DATETIME       NULL,
    [SyncStatus]                   NVARCHAR (50)  CONSTRAINT [DF_ST_Engine_Publication_Details_SyncStatus] DEFAULT (N'NotStarted') NOT NULL,
    [SequenceOrder]                INT            NOT NULL,
	[YetToCheckForCycle]           BIT            DEFAULT ((0)) NOT NULL,
    [Active]                       BIT            CONSTRAINT [DF_ST_Engine_Publication_Details_Active] DEFAULT ((1)) NOT NULL,
    [CreatedDate]                  DATETIME       CONSTRAINT [DF_ST_Publication_Node_Details_CreatedDate] DEFAULT (getdate()) NOT NULL,
    [ModifiedDate]                 DATETIME       NULL,
    CONSTRAINT [PK_ST_Engine_Publication_Details] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [FK_ST_Engine_Publication_Details_ST_Engine_Mark_Type] FOREIGN KEY ([EngineMarkId]) REFERENCES [TManual].[ST_Engine_Mark_Type] ([Id]),
    CONSTRAINT [FK_ST_Engine_Publication_Details_ST_Engine_Series_Type] FOREIGN KEY ([EngineSeriesId]) REFERENCES [TManual].[ST_Engine_Series_Type] ([Id]),
    CONSTRAINT [FK_ST_Engine_Publication_Details_ST_Engine_Type] FOREIGN KEY ([EngineTypeId]) REFERENCES [TManual].[ST_Engine_Type] ([Id])
);

