
CREATE TABLE [Edc].[OT_TV_Drawing_Details](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[FileName] [nvarchar](250) NULL,
	[PartNumber] [nvarchar](250) NULL,
	[PartDescription] [nvarchar](250) NULL,
	[IssueNumber] [nvarchar](250) NULL,
	[IssueDate] [datetime] NOT NULL,
	[Revision] [nvarchar](250) NULL,
	[Series] [nvarchar](250) NULL,
	[FilePath] [nvarchar](1500) NULL,
	[CpiritLink] [nchar](1500) NULL,
	[Active] [bit] NOT NULL CONSTRAINT [DF__OT_TV_Dra__Activ__379B24DB]  DEFAULT ((1)),
	[CreatedBy] [uniqueidentifier] NOT NULL,
	[CreatedDate] [datetime] NOT NULL CONSTRAINT [DF_Concession.OT_TV_Drawing_Details_CreatedDate]  DEFAULT (getdate()),
	[ModifiedBy] [uniqueidentifier] NULL,
	[ModifiedDate] [datetime] NULL,
 CONSTRAINT [PK_TV.OT_TV_Drawing_Details] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO


