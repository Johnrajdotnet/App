CREATE TABLE [TManual].[ST_Publication_Node_Details] (
    [Id]                  BIGINT         IDENTITY (1, 1) NOT NULL,
    [EnginePublicationId] INT            NOT NULL,
    [TaskLevelNumber]     NVARCHAR (200) NULL,
	[FigureNumber]     NVARCHAR (200) NULL,
    [IsDrawingAvailable]  BIT            CONSTRAINT [DF_ST_Publication_Node_Details_IsDrawingAvailable] DEFAULT ((1)) NOT NULL,
	[IsManual]			  BIT				 NOT NULL DEFAULT ((0)),
	[FailedCount]	      INT				 NOT NULL DEFAULT ((0)),
    [IssueDate]           DATETIME       NULL,
    [SyncDate]            DATETIME       NULL,
    [SyncStatus]          NVARCHAR (50)  CONSTRAINT [DF_ST_Publication_Node_Details_SyncStatus] DEFAULT (N'NotStarted') NOT NULL,
    [SequenceOrder]       INT            NOT NULL,
	[MachineIndex]       INT             NULL DEFAULT ((NULL)),
	[YetToCheckForCycle]           BIT            DEFAULT ((0)) NOT NULL,
	[IsLocked]           BIT            DEFAULT ((1)) NOT NULL,
    [Active]              BIT            NULL,
    [CreatedDate]         DATETIME       CONSTRAINT [DF_ST_Builder_Publication_Node_Details_CreatedDate] DEFAULT (getdate()) NOT NULL,
    [ModifiedDate]        DATETIME       NULL,
    CONSTRAINT [PK_ST_Builder_Publication_Node_Details] PRIMARY KEY CLUSTERED ([Id] ASC)
);

