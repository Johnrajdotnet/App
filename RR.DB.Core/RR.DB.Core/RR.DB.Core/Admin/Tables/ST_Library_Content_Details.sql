CREATE TABLE [Admin].[ST_Library_Content_Details]
(
	[Id] [int] IDENTITY(1,1) NOT NULL,
    [DocumentTypeName] NVARCHAR(50) NOT NULL, 	
    [FileNameExtension] NVARCHAR(150) NOT NULL,
	[FileDisplayName] NVARCHAR(150) NOT NULL,
	[FileServerPath] NVARCHAR(500) NOT NULL,
	[Active]       BIT            NOT NULL,
    [CreatedDate]  DATETIME       CONSTRAINT [DF_Library_Content_Details_Active] DEFAULT (getdate()) NOT NULL,
    [ModifiedDate] DATETIME       NULL,
	CONSTRAINT [PK__ST_Libra__3214EC078E413434] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
