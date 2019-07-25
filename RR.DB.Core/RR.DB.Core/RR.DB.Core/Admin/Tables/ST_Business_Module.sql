-- =============================================
-- Author:		<Neethu Rose Peter>
-- Create date: <16/02/2018>
-- ============================================= 

CREATE TABLE [Admin].[ST_Business_Module](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[BusinessName] [nvarchar](50) NOT NULL,
	[Description] [nvarchar](50) NULL,
	[Active] [bit] NOT NULL,
	[CreatedDate] [datetime] NOT NULL CONSTRAINT [DF_ST_Business_Module_CreatedDate]  DEFAULT (getdate()),
	[ModifiedDate] [datetime] NULL,
 CONSTRAINT [PK_ST_Businessmodule] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO


