CREATE TABLE [Admin].[OT_User_RR_Credential_Active] (
    [Id]                 BIGINT           IDENTITY (1, 1) NOT NULL,
    [UniqueId]           UNIQUEIDENTIFIER CONSTRAINT [DF__OT_User_N__Uniqu__108B795B] DEFAULT (newsequentialid()) NOT NULL,
    [RRCredentialId]     BIGINT           NOT NULL,
    [RRCredentialActive] BIT              NOT NULL,
	[EDCActive]			 BIT              NOT NULL,
    [CreatedDate]        DATETIME         CONSTRAINT [DF_ValidateUserCredential_CreatedDate] DEFAULT (getdate()) NOT NULL,
    [ModifiedDate]       DATETIME         NULL,
    CONSTRAINT [PK_ValidateUserCredential] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [FK_OT_User_RRCredential_Active_OT_User_RR_Credential_Active] FOREIGN KEY ([RRCredentialId]) REFERENCES [Admin].[ST_User_RR_Credential] ([Id])
);

