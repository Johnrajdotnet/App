CREATE TABLE [Admin].[ST_Program_Task_WorkFlow_Step] (
    [Id]                 INT            IDENTITY (1, 1) NOT NULL,
    [ProgramId]          INT            NOT NULL,
	[TaskId]			 INT            NOT NULL,
    [SequenceStepNumber] INT            NULL,
    [StepName]           NVARCHAR (250) NOT NULL,
    [StepDescription]    NVARCHAR (500) NOT NULL,
	[OriginalTaskWFlowId] INT			NOT NULL,
    [IsChildStep]        BIT            NULL,
    [Active]             BIT            NOT NULL,
    [CreatedDate]        DATETIME       CONSTRAINT [DF_ST_Program_Task_WorkFlow_Step_CreatedDate] DEFAULT (getdate()) NOT NULL,
    [ModifiedDate]       DATETIME       NULL,
    CONSTRAINT [PK_ST_Program_Task_WorkFlow_Step] PRIMARY KEY CLUSTERED ([Id] ASC),
	CONSTRAINT [FK_ST_Program_Task_WorkFlow_Step_ST_Task_Details] FOREIGN KEY ([TaskId]) REFERENCES [Admin].[ST_Task_Details] ([Id]),
    CONSTRAINT [FK_ST_Program_Task_WorkFlow_Step_ST_Program_Task_Acitivity1] FOREIGN KEY ([ProgramId]) REFERENCES [Admin].[ST_Program_Details] ([Id])
);

