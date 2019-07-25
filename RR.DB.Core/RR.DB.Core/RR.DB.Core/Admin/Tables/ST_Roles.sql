CREATE TABLE [Admin].[ST_Roles] (
    [Id]           INT            IDENTITY (1, 1) NOT NULL,
    [RoleName]     NVARCHAR (50)  NOT NULL,
    [Description]  NVARCHAR (250) NOT NULL,
	[RoleLevel]    INT            NOT NULL,
    [Active]       BIT            NOT NULL,
    [CreatedDate]  DATETIME       CONSTRAINT [DF_ST_Roles_CreatedDate] DEFAULT (getdate()) NOT NULL,
    [ModifiedDate] DATETIME       NULL,
    CONSTRAINT [PK_Roles] PRIMARY KEY CLUSTERED ([Id] ASC)
);

