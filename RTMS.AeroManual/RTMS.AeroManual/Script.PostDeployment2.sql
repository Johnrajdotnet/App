/*
Post-Deployment Script Template							
--------------------------------------------------------------------------------------
 This file contains SQL statements that will be appended to the build script.		
 Use SQLCMD syntax to include a file in the post-deployment script.			
 Example:      :r .\myfile.sql								
 Use SQLCMD syntax to reference a variable in the post-deployment script.		
 Example:      :setvar TableName MyTable							
               SELECT * FROM [$(TableName)]					
--------------------------------------------------------------------------------------
*/
-------------------------- Trent Engine---------------------------------------

SET IDENTITY_INSERT [TManual].[ST_Engine_Type] ON

INSERT [TManual].[ST_Engine_Type] (Id,[EngineName], [EngineDescription],[SequenceOrder], [Active],[EngineTypeFolderName], [CreatedDate], [ModifiedDate])
 VALUES (1,'AE Series','AE Series',1,0,'AE Series', GETDATE(), NULL)
INSERT [TManual].[ST_Engine_Type] (Id,[EngineName], [EngineDescription],[SequenceOrder], [Active],[EngineTypeFolderName], [CreatedDate], [ModifiedDate])
 VALUES (2,'BR700 Series','BR700 Series',2,0,'BR700 Series', GETDATE(), NULL)
INSERT [TManual].[ST_Engine_Type] (Id,[EngineName], [EngineDescription],[SequenceOrder], [Active],[EngineTypeFolderName], [CreatedDate], [ModifiedDate])
 VALUES (3,'Dart','Dart',3,0,'Dart', GETDATE(), NULL)
INSERT [TManual].[ST_Engine_Type] (Id,[EngineName], [EngineDescription],[SequenceOrder], [Active],[EngineTypeFolderName], [CreatedDate], [ModifiedDate])
 VALUES (4,'RB211-22B','RB211-22B',4,0,'RB211-22B', GETDATE(), NULL)
INSERT [TManual].[ST_Engine_Type] (Id,[EngineName], [EngineDescription],[SequenceOrder], [Active],[EngineTypeFolderName], [CreatedDate], [ModifiedDate])
 VALUES (5,'RB211-524 Series','RB211-524 Series',5,0,'RB211-524 Series', GETDATE(), NULL)
INSERT [TManual].[ST_Engine_Type] (Id,[EngineName], [EngineDescription],[SequenceOrder], [Active],[EngineTypeFolderName], [CreatedDate], [ModifiedDate])
 VALUES (6,'RB211-535 Series','RB211-535 Series',6,0,'RB211-535 Series', GETDATE(), NULL)
INSERT [TManual].[ST_Engine_Type] (Id,[EngineName], [EngineDescription],[SequenceOrder], [Active],[EngineTypeFolderName], [CreatedDate], [ModifiedDate])
 VALUES (7,'Spey Series','Spey Series',7,0,'Spey Series', GETDATE(), NULL)
INSERT [TManual].[ST_Engine_Type] (Id,[EngineName], [EngineDescription],[SequenceOrder], [Active],[EngineTypeFolderName], [CreatedDate], [ModifiedDate])
 VALUES (8,'Tay Series','Tay Series',8,0,'Tay Series', GETDATE(), NULL)
INSERT [TManual].[ST_Engine_Type] (Id,[EngineName], [EngineDescription],[SequenceOrder], [Active],[EngineTypeFolderName], [CreatedDate], [ModifiedDate])
 VALUES (9,'Trent Series','Trent Series',9,1,'Trent Series', GETDATE(), NULL)
INSERT [TManual].[ST_Engine_Type] (Id,[EngineName], [EngineDescription],[SequenceOrder], [Active],[EngineTypeFolderName], [CreatedDate], [ModifiedDate])
 VALUES (10,'Supplementary Data','Supplementary Data',10,0,'Supplementary Data', GETDATE(), NULL)

SET IDENTITY_INSERT [TManual].[ST_Engine_Type] OFF
 --------------------------ST_Engine_Type---------------------------------------

SET IDENTITY_INSERT [TManual].[ST_Engine_Series_Type] ON 
-------------------------- ST_Engine_Series_Type---------------------------------------
GO
INSERT [TManual].[ST_Engine_Series_Type] ([Id], [EngineTypeId],EngineSeriesFamilyName, [EngineSeriesName], [EngineSeriesDescription],[EngineSeriesFolderName], [EngineMarkPageTitle], [IssueDate], [SyncDate], [SyncStatus], [SequenceOrder], [Active], [CreatedDate], [ModifiedDate]) 
VALUES (1, 9, N'Trent 500 Airbus A340 Overhaul Data','Trent 500', N'Trent 500 Airbus A340 Overhaul Data',N'Trent 500 Airbus A340 Overhaul Data', N'Trent 500 Series - Model Selection', NULL, NULL, N'NotStarted', 1, 1, GETDATE(), GETDATE())
GO
INSERT [TManual].[ST_Engine_Series_Type] ([Id], [EngineTypeId], EngineSeriesFamilyName, [EngineSeriesName], [EngineSeriesDescription],[EngineSeriesFolderName], [EngineMarkPageTitle], [IssueDate], [SyncDate], [SyncStatus], [SequenceOrder], [Active], [CreatedDate], [ModifiedDate]) 
VALUES (4, 9, N'Trent 700 Airbus A330 Overhaul Data','Trent 700', N'Trent 700 Airbus A330 Overhaul Data',N'Trent 700 Airbus A330 Overhaul Data', N'Trent 700 Series - Model Selection',  NULL, NULL, N'NotStarted', 4, 1, GETDATE(), GETDATE())
GO
SET IDENTITY_INSERT [TManual].[ST_Engine_Series_Type] OFF


SET IDENTITY_INSERT [TManual].[ST_Engine_Mark_Type] ON
-------------------------- ST_Engine_Mark_Type---------------------------------------
GO
INSERT [TManual].[ST_Engine_Mark_Type] ([Id], [EngineSeriesTypeId], [EngineMarkName], [EngineMarkDescription],[EngineMarkFolderName], [EPublicationTitleName], [SyncDate], [SyncStatus], [SequenceOrder], [Active], [CreatedDate], [ModifiedDate]) 
VALUES (1, 1, N'TRENT553-61', N'TRENT553-61',N'TRENT553-61', N'Trent 500 Series', NULL, NULL, 1, 1,GETDATE(), NULL)
GO
INSERT [TManual].[ST_Engine_Mark_Type] ([Id], [EngineSeriesTypeId], [EngineMarkName], [EngineMarkDescription],[EngineMarkFolderName], [EPublicationTitleName], [SyncDate], [SyncStatus], [SequenceOrder], [Active], [CreatedDate], [ModifiedDate]) 
VALUES (6, 4, N'TRENT-768-60/15', N'TRENT-768-60/15',N'TRENT-768-60/15', N'Trent 700 Series', NULL, NULL, 6, 1,GETDATE(), NULL)
GO
SET IDENTITY_INSERT [TManual].[ST_Engine_Mark_Type] OFF


SET IDENTITY_INSERT [TManual].[ST_Engine_Publication_Details] ON
-------------------------- ST_Engine_Publication_Details---------------------------------------
GO
INSERT [TManual].[ST_Engine_Publication_Details] ([Id], [EngineTypeId], [EngineSeriesId], [EngineMarkId], [EnginePublicationShotName], [EnginePublicationLongName], [EnginePublicationDescription],[EnginePubFolderName], [IssueDate], [SyncDate], [SyncStatus], [SequenceOrder], [Active], [CreatedDate], [ModifiedDate])
 VALUES (1, 9, 1, 1, N'CRM', N'Check and Rectify', N'Check and Rectify',N'CRM', NULL, NULL, N'NotStarted', 1, 1, GETDATE(), GETDATE())
GO
INSERT [TManual].[ST_Engine_Publication_Details] ([Id], [EngineTypeId], [EngineSeriesId], [EngineMarkId], [EnginePublicationShotName], [EnginePublicationLongName], [EnginePublicationDescription],[EnginePubFolderName], [IssueDate], [SyncDate], [SyncStatus], [SequenceOrder], [Active], [CreatedDate], [ModifiedDate])
 VALUES (2, 9, 1, 1, N'CMM_EHC', N'Component Maintenance Manual Electrical Harnesses and Cables', N'Component Maintenance Manual Electrical Harnesses and Cables', N'CMM_EHC', NULL, NULL, N'NotStarted', 2, 1, GETDATE(), GETDATE())
GO
INSERT [TManual].[ST_Engine_Publication_Details] ([Id], [EngineTypeId], [EngineSeriesId], [EngineMarkId], [EnginePublicationShotName], [EnginePublicationLongName], [EnginePublicationDescription],[EnginePubFolderName], [IssueDate], [SyncDate], [SyncStatus], [SequenceOrder], [Active], [CreatedDate], [ModifiedDate])
 VALUES (46, 9, 4, 6, N'CMM_EHC', N'Component Maintenance Manual Electrical Harnesses and Cables', N'Component Maintenance Manual Electrical Harnesses and Cables',N'CMM_EHC', NULL, NULL, N'NotStarted', 46, 1,GETDATE(), GETDATE())
GO
INSERT [TManual].[ST_Engine_Publication_Details] ([Id], [EngineTypeId], [EngineSeriesId], [EngineMarkId], [EnginePublicationShotName], [EnginePublicationLongName], [EnginePublicationDescription],[EnginePubFolderName], [IssueDate], [SyncDate], [SyncStatus], [SequenceOrder], [Active], [CreatedDate], [ModifiedDate]) 
VALUES (47, 9, 4, 6, N'CMM_MM', N'Component Maintenance Manual Miscellaneous Mechanical', N'Component Maintenance Manual Miscellaneous Mechanical',N'CMM_MM', NULL, NULL, N'NotStarted', 47, 1,GETDATE(), GETDATE())
GO
                ---------------------------EIPC,EM,OMAT,TSD594J------------------------------------------
INSERT [TManual].[ST_Engine_Publication_Details] ([Id],[EngineTypeId], [EngineSeriesId], [EngineMarkId], [EnginePublicationShotName], [EnginePublicationLongName], [EnginePublicationDescription],[EnginePubFolderName], [IssueDate], [SyncDate], [SyncStatus],[SequenceOrder], [Active], [CreatedDate], [ModifiedDate]) 
VALUES (5,9,1,1,'EIPC','Engine Illustrated Parts Catalog','Engine Illustrated Parts Catalog','EIPC', NULL, NULL, N'NotStarted',5,1 ,GETDATE(), NULL)
GO
INSERT [TManual].[ST_Engine_Publication_Details] ([Id],[EngineTypeId], [EngineSeriesId], [EngineMarkId], [EnginePublicationShotName], [EnginePublicationLongName], [EnginePublicationDescription],[EnginePubFolderName], [IssueDate], [SyncDate], [SyncStatus],[SequenceOrder], [Active], [CreatedDate], [ModifiedDate]) 
VALUES (6,9,1,1,'EM','Engine Manual','Engine Manual','EM', NULL, NULL, N'NotStarted',6,1 ,GETDATE(), NULL)
GO
INSERT [TManual].[ST_Engine_Publication_Details] ([Id],[EngineTypeId], [EngineSeriesId], [EngineMarkId], [EnginePublicationShotName], [EnginePublicationLongName], [EnginePublicationDescription],[EnginePubFolderName], [IssueDate], [SyncDate], [SyncStatus],[SequenceOrder], [Active], [CreatedDate], [ModifiedDate]) 
VALUES (8,9,1,1,'TSD594J','Overhaul Processes Manual','Overhaul Processes Manual','TSD594J', NULL, NULL, N'NotStarted',8,1 ,GETDATE(), NULL)
GO
INSERT [TManual].[ST_Engine_Publication_Details] ([Id],[EngineTypeId], [EngineSeriesId], [EngineMarkId], [EnginePublicationShotName], [EnginePublicationLongName], [EnginePublicationDescription],[EnginePubFolderName], [IssueDate], [SyncDate], [SyncStatus],[SequenceOrder], [Active], [CreatedDate], [ModifiedDate]) 
VALUES (7,9,1,1,'OMAT','Overhaul Materials Manual','Overhaul Materials Manual','OMAT', NULL, NULL, N'NotStarted',7,0 ,GETDATE(), NULL)
GO
SET IDENTITY_INSERT [TManual].[ST_Engine_Publication_Details] OFF



SET IDENTITY_INSERT [TManual].[ST_Publication_Node_Details] ON
-------------------------- ST_Engine_Publication_Node_Details---------------------------------------
GO
INSERT [TManual].[ST_Publication_Node_Details] ([Id], [EnginePublicationId], [TaskLevelNumber], [FigureNumber], [IsDrawingAvailable], [IsManual], [IssueDate], [SyncDate], [SyncStatus], [SequenceOrder], [Active], [CreatedDate], [ModifiedDate])
 VALUES (1, 1, N'72-00-00-900-001',NULL , 1, 0,  NULL, NULL, N'NotStarted', 1, 1, GETDATE(), GETDATE())
GO
INSERT [TManual].[ST_Publication_Node_Details] ([Id], [EnginePublicationId], [TaskLevelNumber], [FigureNumber], [IsDrawingAvailable], [IsManual], [IssueDate], [SyncDate], [SyncStatus], [SequenceOrder], [Active], [CreatedDate], [ModifiedDate])
 VALUES (5, 1, N'72-00-00-200-001',NULL, 1, 0, NULL, NULL, N'NotStarted', 5, 1, GETDATE(), GETDATE())
GO
INSERT [TManual].[ST_Publication_Node_Details] ([Id], [EnginePublicationId], [TaskLevelNumber], [FigureNumber], [IsDrawingAvailable], [IsManual], [IssueDate], [SyncDate], [SyncStatus], [SequenceOrder], [Active], [CreatedDate], [ModifiedDate])
 VALUES (65, 2, N'70-00-20-200-801',NULL, 1, 0, NULL, NULL, N'NotStarted', 65, 1,GETDATE(), GETDATE())
GO
INSERT [TManual].[ST_Publication_Node_Details] ([Id], [EnginePublicationId], [TaskLevelNumber], [FigureNumber], [IsDrawingAvailable], [IsManual], [IssueDate], [SyncDate], [SyncStatus], [SequenceOrder], [Active], [CreatedDate], [ModifiedDate])
VALUES (69, 2, N'70-00-20-300-012',NULL, 1, 0, NULL, NULL, N'NotStarted', 69, 1,GETDATE(),GETDATE())
GO
INSERT [TManual].[ST_Publication_Node_Details] ([Id], [EnginePublicationId], [TaskLevelNumber], [FigureNumber], [IsDrawingAvailable], [IsManual], [IssueDate], [SyncDate], [SyncStatus], [SequenceOrder], [Active], [CreatedDate], [ModifiedDate])
VALUES (14999, 46, N'24-21-15-100-800', NULL, 1, 0, NULL, NULL, N'NotStarted', 14999, 1,GETDATE(),GETDATE())
GO
INSERT [TManual].[ST_Publication_Node_Details] ([Id], [EnginePublicationId], [TaskLevelNumber], [FigureNumber], [IsDrawingAvailable], [IsManual], [IssueDate], [SyncDate], [SyncStatus], [SequenceOrder], [Active], [CreatedDate], [ModifiedDate])
VALUES (15001, 46, N'24-21-15-400-800', NULL,1, 0, NULL, NULL, N'NotStarted', 15001, 1, GETDATE(), GETDATE())
GO
INSERT [TManual].[ST_Publication_Node_Details] ([Id], [EnginePublicationId], [TaskLevelNumber], [FigureNumber], [IsDrawingAvailable], [IsManual], [IssueDate], [SyncDate], [SyncStatus], [SequenceOrder], [Active], [CreatedDate], [ModifiedDate])
 VALUES (15193, 47, N'26-21-49-200-900', NULL, 1, 0, NULL, NULL, N'NotStarted', 15193, 1,GETDATE(),GETDATE())
GO
INSERT [TManual].[ST_Publication_Node_Details] ([Id], [EnginePublicationId], [TaskLevelNumber], [FigureNumber], [IsDrawingAvailable], [IsManual], [IssueDate], [SyncDate], [SyncStatus], [SequenceOrder], [Active], [CreatedDate], [ModifiedDate])
 VALUES (15195, 47, N'29-11-11-000-800', NULL, 1, 0, NULL, NULL, N'NotStarted', 15195, 1, GETDATE(), GETDATE())
GO
-----------------------------------------EIPC--------------------------------
INSERT [TManual].[ST_Publication_Node_Details] ([Id],[EnginePublicationId],[TaskLevelNumber],[FigureNumber], [IsDrawingAvailable],[IsManual],[IssueDate], [SyncDate], [SyncStatus],[SequenceOrder], [Active], [CreatedDate], [ModifiedDate]) 
VALUES (324,5,NULL,'11-24-71-01', 1,0,NULL, NULL, N'NotStarted', 324,1, GETDATE(), GETDATE())
GO
INSERT [TManual].[ST_Publication_Node_Details] ([Id],[EnginePublicationId],[TaskLevelNumber],[FigureNumber], [IsDrawingAvailable],[IsManual],[IssueDate], [SyncDate], [SyncStatus],[SequenceOrder], [Active], [CreatedDate], [ModifiedDate])  
VALUES (325,5,NULL,'24-21-11-01',1,0,NULL, NULL, N'NotStarted', 325,1, GETDATE(), GETDATE())
GO
INSERT [TManual].[ST_Publication_Node_Details] ([Id],[EnginePublicationId],[TaskLevelNumber],[FigureNumber], [IsDrawingAvailable],[IsManual],[IssueDate], [SyncDate], [SyncStatus],[SequenceOrder], [Active], [CreatedDate], [ModifiedDate])   
VALUES (326,5,NULL,'24-21-12-01',1,0,NULL, NULL, N'NotStarted', 326,1, GETDATE(), GETDATE())
GO
----------------------------------------EM----------------------------------------
INSERT [TManual].[ST_Publication_Node_Details] ([Id],[EnginePublicationId],[TaskLevelNumber],[FigureNumber], [IsDrawingAvailable],[IsManual],[IssueDate], [SyncDate], [SyncStatus],[SequenceOrder], [Active], [CreatedDate], [ModifiedDate]) 
VALUES (903,6,'71-21-11-000-800',NULL,1,0,NULL, NULL, N'NotStarted', 903,1, GETDATE(), GETDATE())
GO
INSERT [TManual].[ST_Publication_Node_Details] ([Id],[EnginePublicationId],[TaskLevelNumber],[FigureNumber], [IsDrawingAvailable],[IsManual],[IssueDate], [SyncDate], [SyncStatus],[SequenceOrder], [Active], [CreatedDate], [ModifiedDate]) 
VALUES (904,6,'71-21-11-000-801',NULL,1,0,NULL, NULL, N'NotStarted', 904,1, GETDATE(), GETDATE())
GO
----------------------------------------TSD594J-------------------------------------
INSERT [TManual].[ST_Publication_Node_Details] ([Id],[EnginePublicationId],[TaskLevelNumber],[FigureNumber], [IsDrawingAvailable],[IsManual],[IssueDate], [SyncDate], [SyncStatus],[SequenceOrder], [Active], [CreatedDate], [ModifiedDate]) 
VALUES (3508,8,'70-00-00-100-101',NULL,1,0,NULL, NULL, N'NotStarted', 3508,1, GETDATE(), GETDATE())
GO
INSERT [TManual].[ST_Publication_Node_Details] ([Id],[EnginePublicationId],[TaskLevelNumber],[FigureNumber], [IsDrawingAvailable],[IsManual],[IssueDate], [SyncDate], [SyncStatus],[SequenceOrder], [Active], [CreatedDate], [ModifiedDate]) 
VALUES (3509,8,'70-00-00-100-102',NULL,1,0,NULL, NULL, N'NotStarted', 3509,1, GETDATE(), GETDATE())
GO

-------------------------------------------OMAT-----------------------------------------
---------------------------------NO TASK/FIGURE NUMBERS----------------------------------

SET IDENTITY_INSERT [TManual].[ST_Publication_Node_Details] OFF