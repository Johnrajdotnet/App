-- =============================================
-- Author:		Neethu
-- Create date: 3/2/2018
-- Description:	Update data based flag value 
-- exec [TManual].[OT_Manual_EIPC_Details] 
-- =============================================
CREATE TABLE [TManual].[OT_Manual_EIPC_Details](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[PublicationNodeId] [bigint] NOT NULL,
	[EPICEngineMark] [nvarchar](max) NULL,
	[FigOrItemNumber] [nvarchar](max) NULL,
	[PartNumber] [nvarchar](max) NULL,
	[Nomenclature] [nvarchar](200) NULL,
	[Assy] [nvarchar](10) NULL,
	[UnitPerAssy] [int] NULL,
	[Active] [bit] NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[ModifiedDate] [datetime] NULL,
 CONSTRAINT [PK_OT_Manual_Effectivity_Details] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO

ALTER TABLE [TManual].[OT_Manual_EIPC_Details] ADD  CONSTRAINT [DF_OT_Manual_Effectivity_Details_Active]  DEFAULT ((1)) FOR [Active]
GO

ALTER TABLE [TManual].[OT_Manual_EIPC_Details] ADD  CONSTRAINT [DF_OT_Manual_Effectivity_Details_CreatedDate]  DEFAULT (getdate()) FOR [CreatedDate]
GO

ALTER TABLE [TManual].[OT_Manual_EIPC_Details]  WITH CHECK ADD  CONSTRAINT [FK_OT_Manual_Effectivity_Details_OT_Publication_Node_Details] FOREIGN KEY([PublicationNodeId])
REFERENCES [TManual].[ST_Publication_Node_Details] ([Id])
GO

ALTER TABLE [TManual].[OT_Manual_EIPC_Details] CHECK CONSTRAINT [FK_OT_Manual_Effectivity_Details_OT_Publication_Node_Details]
GO


