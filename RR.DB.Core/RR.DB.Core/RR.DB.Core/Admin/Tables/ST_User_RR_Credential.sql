CREATE TABLE [Admin].[ST_User_RR_Credential] (
    [Id]             BIGINT           IDENTITY (1, 1) NOT NULL,
    [UniqueId]       UNIQUEIDENTIFIER CONSTRAINT [DF__ST_User_N__Uniqu__267ABA7A] DEFAULT (newsequentialid()) NOT NULL,
    [UserId]         BIGINT           NOT NULL,
    [RRCareId]       NVARCHAR (250)   NOT NULL,
    [RRCarePassword] NVARCHAR (250)   NOT NULL,
    [CreatedDate]    DATETIME         CONSTRAINT [DF_RRCredential_CreatedDate] DEFAULT (getdate()) NOT NULL,
    [ModifiedDate]   DATETIME         NULL,
    CONSTRAINT [PK_LoginCredentials_User_1] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [FK_LoginCredentials_User_Users] FOREIGN KEY ([UserId]) REFERENCES [Admin].[ST_Users] ([Id])
);

