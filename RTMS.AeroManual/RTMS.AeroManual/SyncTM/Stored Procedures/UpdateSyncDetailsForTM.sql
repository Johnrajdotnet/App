
-- =============================================
-- Author:		Arathy
-- Create date: 3/2/2018
-- Description:	Update data based flag value 
-- exec [SyncTM].[UpdateSyncDetailsForTM] 1,'EPublicationNode',InProgress,null
-- =============================================
CREATE PROCEDURE [SyncTM].[UpdateSyncDetailsForTM]
		@id                     int,
		@flag					nvarchar(50),
		@syncStatus				nvarchar(50),
		@issueDate				datetime

AS
BEGIN TRY
	--Notstarted or Completed or inprogress Syncstatus update--Changes or Issue date Not match
	IF(UPPER(@flag) = 'EngineSeries')   
	BEGIN

			UPDATE  [TManual].[ST_Engine_Series_Type]
			SET	    [SyncStatus] = @syncStatus,
				    [SyncDate] = GETDATE(),
					[IssueDate] =ISNULL(@issueDate,[IssueDate]),
					ModifiedDate=GETDATE()
			WHERE   [Id] = @id	
	END
	ELSE IF(UPPER(@flag) = 'EPublication')
	BEGIN
			UPDATE  [TManual].[ST_Engine_Publication_Details]
			SET	    [SyncStatus] = @syncStatus,
				    [SyncDate] = GETDATE(),
					[YetToCheckForCycle]=1,
					[IssueDate] =ISNULL(@issueDate,[IssueDate]),
					ModifiedDate=GETDATE()
			WHERE   [Id] = @id	
			
	END
	ELSE IF(UPPER(@flag) = 'EPublicationNode')
	BEGIN
			UPDATE  [TManual].[ST_Publication_Node_Details]
			SET	    [SyncStatus] = @syncStatus,
				    [SyncDate] = GETDATE(),					
					[IssueDate] =ISNULL(@issueDate,[IssueDate]),
					[FailedCount]=0,
					ModifiedDate=GETDATE()
			WHERE   [Id] = @id		

			IF(UPPER(@syncStatus)='INPROGRESS')
			BEGIN
			
				UPDATE [TManual].OT_Manual_Information_Details
				SET	   [IsManualOutDated]=1
				WHERE  [PublicationNodeId]=@id	

				UPDATE  [TManual].[ST_Publication_Node_Details]
				SET	    [YetToCheckForCycle] =1
				WHERE   [Id] = @id			

			END
			ELSE IF(UPPER(@syncStatus)='COMPLETED')
			BEGIN
			
				UPDATE [TManual].OT_Manual_Information_Details
				SET	   [IsManualOutDated]=0
				WHERE  [PublicationNodeId]=@id
				
				UPDATE  [TManual].[ST_Publication_Node_Details]
				SET	    [YetToCheckForCycle] =0
				WHERE   [Id] = @id					
			END
	END
	ELSE IF(UPPER(@flag) = 'ISDRAWING')
	BEGIN
			UPDATE  [TManual].[ST_Publication_Node_Details]
			SET	    IsDrawingAvailable = 1,
					[SyncStatus] = 'NoDrawing',
					ModifiedDate=GETDATE()
			WHERE   [Id] = @id		
	END
	ELSE IF(UPPER(@flag) = 'YETTOCHECKFORCYCLE')
	BEGIN
			UPDATE  [TManual].[ST_Engine_Publication_Details]
			SET	    [YetToCheckForCycle] =0
			WHERE   [Id] = @id		
	END
END TRY
BEGIN CATCH
   EXECUTE [dbo].[LogError]
END CATCH

