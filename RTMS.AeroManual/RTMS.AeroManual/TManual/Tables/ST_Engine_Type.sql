CREATE TABLE [TManual].[ST_Engine_Type] (
    [Id]                INT            IDENTITY (1, 1) NOT NULL,
    [EngineName]        NVARCHAR (50)  NOT NULL,
    [EngineDescription] NVARCHAR (200) NOT NULL,
    [SequenceOrder]     INT            NOT NULL,
    [Active]            BIT            NOT NULL,
	[EngineTypeFolderName] NVARCHAR (200) NOT NULL,
    [CreatedDate]       DATETIME       CONSTRAINT [DF_ST_Engine_Type_CreatedDate] DEFAULT (getdate()) NOT NULL,
    [ModifiedDate]      DATETIME       NULL,
    CONSTRAINT [PK_ST_Engine_Type] PRIMARY KEY CLUSTERED ([Id] ASC)
);

