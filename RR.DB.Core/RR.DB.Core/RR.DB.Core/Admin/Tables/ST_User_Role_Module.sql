CREATE TABLE [Admin].[ST_User_Role_Module] (
    [Id]               UNIQUEIDENTIFIER CONSTRAINT [DF_ST_User_Role_Module_Id] DEFAULT (newid()) NOT NULL,
    [UserId]           BIGINT           NOT NULL,
    [RoleId]           INT              NOT NULL,
    [BusinessModuleId] NVARCHAR (250)   NULL,
	[ProgramId] NVARCHAR (250)   NULL,
    [CreateDate]       DATETIME         CONSTRAINT [DF_ST_User_Role_Module_CreateDate] DEFAULT (getdate()) NOT NULL,
    [ModifiedDate]     DATETIME         NULL,
    CONSTRAINT [PK_ST_User_Role_Module] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [FK_ST_User_Role_Module_ST_Users] FOREIGN KEY ([UserId]) REFERENCES [Admin].[ST_Users] ([Id])
);

