
-- =============================================
--PROCEDURE: [TManual].[InsertTaskNodeDetails] 
--PURPOSE: Insert task node details to [TManual].[ST_Task_Node_Details]
--CREATED: Vyshna P 01/30/2018
-- ============================================= 

CREATE PROCEDURE [TManual].[InsertPublicationNodeDetails]
	@enginePublicationId	bigint,
	--@chapterLevel			nvarchar(200),  
	--@sectionLevel			nvarchar(200), 
	--@pageBlockLevel		    nvarchar(200), 
	--@functionalCode		    nvarchar(200), 
	@taskLevelNumber		nvarchar(200),
	--@taskLeveName			nvarchar(200),
	@sequenceNumber			int,
	@isDrawingAvailable		bit,
	@issueDate				datetime,
	@syncDate				datetime

AS

	DECLARE @count bigint

BEGIN TRY
	SET @count = (SELECT COUNT(*) FROM [TManual].[ST_Publication_Node_Details] 
				  WHERE EnginePublicationId=@enginePublicationId
				 )

	IF(@count = 0)
	BEGIN
    
		INSERT INTO [TManual].[ST_Publication_Node_Details]
		(
			 EnginePublicationId
			--,ChapterLevel
			--,SectionLevel
			--,PageBlockLevelName
			--,FunctionalCode
			,TaskLevelNumber
			--,TaskLevelName
			,IsDrawingAvailable
			,IssueDate
			,SyncDate
		)
		VALUES 
		(
			 @enginePublicationId
			--,@chapterLevel
			--,@sectionLevel
			--,@pageBlockLevel
			--,@functionalCode
			,@taskLevelNumber
			--,@taskLeveName
			,@isDrawingAvailable
			,@issueDate
			,@syncDate
		)
	END
END TRY
BEGIN CATCH
   EXECUTE [dbo].[LogError]
END CATCH
