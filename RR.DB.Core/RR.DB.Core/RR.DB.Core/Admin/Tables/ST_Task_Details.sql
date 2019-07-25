CREATE TABLE [Admin].[ST_Task_Details]
(
	[Id]		   INT			  IDENTITY (1, 1) NOT NULL,
	[TaskName]     NVARCHAR(50)	  NOT NULL,
    [Description]  NVARCHAR(50)   NOT NULL,
    [Active]       BIT            NOT NULL,
    [CreatedDate]  DATETIME       CONSTRAINT [DF_ST_Task_Details_CreatedDate] DEFAULT (GETDATE()) NOT NULL,
    [ModifiedDate] DATETIME       NULL,
    CONSTRAINT [PK_ST_Task_Details] PRIMARY KEY CLUSTERED ([Id] ASC)
)
