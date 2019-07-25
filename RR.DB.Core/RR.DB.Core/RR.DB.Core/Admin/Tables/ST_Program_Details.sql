CREATE TABLE [Admin].[ST_Program_Details] (
    [Id]           INT           IDENTITY (1, 1) NOT NULL,
    [ProgramName]  VARCHAR (50)  NOT NULL,
    [Description]  VARCHAR (250) NULL,
	[RoleLevel] [int] NULL,
	[ParentId] [int] NULL,
	[MenuId] [int] NULL,
	[SubMenuId] [int] NULL,
    [Active]       BIT           CONSTRAINT [DF_ST_ProgramDetails_Active] DEFAULT ((1)) NOT NULL,
    [CreatedDate]  DATETIME      CONSTRAINT [DF_ST_ProgramDetails_CreatedDate] DEFAULT (getdate()) NOT NULL,
    [ModifiedDate] DATETIME      NULL,
    CONSTRAINT [PK_ST_ProgramDetails] PRIMARY KEY CLUSTERED ([Id] ASC)
);

