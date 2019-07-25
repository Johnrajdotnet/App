
-- =============================================
-- Author:		Vyshna
-- Create date: 2/15/2018
-- Description:	Get the count of Not started
-- sync status and current sync date
-- exec [SyncTM].[GetCountOfSyncInformation]
-- =============================================
 CREATE PROCEDURE [SyncTM].[GetCountOfSyncInformation] 
	-- Add the parameters for the stored procedure here
AS
BEGIN TRY
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
    -- Insert statements for procedure here
	--DECLARE @syncStatusCountofES int ,@syncStatusCountofEM int, @syncStatusCountofEP int, @syncStatusCountofTaskNode int,
	--		@totalSyncStatusCount int, @syncDateCountofES int ,@syncDateofEM int, @syncDateofEP int, @syncDateofTaskNode int,
	--		@totalSyncDateCount int,
			
	DECLARE @allRecordCount int,@allNotStartedCount int,@allSyncToday int,@inProgress int,@allRecordCompleted int

	  BEGIN	

		 SET  @allRecordCount=   (SELECT COUNT(1) FROM [TManual].ST_Engine_Series_Type WHERE Active=1 AND IsManual=0)
								 								 
		 SET  @allSyncToday	=     (SELECT COUNT(1) FROM [TManual].ST_Engine_Series_Type WHERE Active=1 
								  AND CONVERT(nvarchar,SyncDate,112)=CONVERT(nvarchar(10),GETDATE(),112))
								  								 								 
		 SET  @allNotStartedCount=  (SELECT COUNT(1) FROM [TManual].ST_Publication_Node_Details WHERE Active=1 AND UPPER(SyncStatus) = 'NOTSTARTED')
								
		 SET @inProgress =(SELECT COUNT(1) FROM [TManual].ST_Publication_Node_Details WHERE Active=1 AND UPPER(SyncStatus) = 'INPROGRESS' AND IsManual=0)

		 SET @allRecordCompleted =(SELECT COUNT(1) FROM [TManual].ST_Publication_Node_Details WHERE Active=1 AND UPPER(SyncStatus) = 'COMPLETED')

		 SELECT @allRecordCount as CountAllRecord,@allSyncToday as CountSyncToday,@allNotStartedCount as CountOfNotStarted,@inProgress as CountOfInProgress
		 , @allRecordCompleted as CountOfCompleted



	  END

END TRY

BEGIN CATCH
   EXECUTE [dbo].[LogError]
END CATCH
