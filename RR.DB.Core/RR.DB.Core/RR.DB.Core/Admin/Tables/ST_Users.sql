CREATE TABLE [Admin].[ST_Users] (
    [Id]				BIGINT           IDENTITY (1, 1) NOT NULL,
    [UniqueId]			UNIQUEIDENTIFIER CONSTRAINT [DF__ST_Users__Unique__2D27B809] DEFAULT (newsequentialid()) NOT NULL,
    [UserId]			BIGINT           NOT NULL,	
    [RRCareUserName]	NVARCHAR (250)   NOT NULL,
    [Password]			NVARCHAR (250)   NOT NULL,
    [FirstName]			NVARCHAR (250)   NOT NULL,
    [MiddleName]		NVARCHAR (250)   NULL,
    [LastName]			NVARCHAR (250)   NOT NULL,
    [EmailAddress]		NVARCHAR (250)   NOT NULL,
    [DateOfBirth]		DATE             NULL,
    [ExpiryDate]		DATETIME         NOT NULL,
    [Active]			BIT              CONSTRAINT [DF_Users_Active] DEFAULT ((1)) NOT NULL,
    [CreatedDate]		DATETIME         CONSTRAINT [DF_Users_CreatedDate] DEFAULT (getdate()) NOT NULL,
    [ModifiedDate]		DATETIME         NULL,
    CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED ([Id] ASC)
);

