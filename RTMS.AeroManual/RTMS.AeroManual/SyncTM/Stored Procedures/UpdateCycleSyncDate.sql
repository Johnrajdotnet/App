
-- =============================================
-- Author:		John Raj
-- Create date: 3/2/2018
-- Description:	Update data based flag value 
-- exec [SyncTM].[UpdateCycleSyncDate] 1,'EPublicationNode',InProgress,null
-- =============================================
CREATE PROCEDURE [SyncTM].[UpdateCycleSyncDate]
		@paraId         nvarchar(200),	--Any Id based on flag	
		@flag			nvarchar(50)
AS
BEGIN TRY

	DECLARE @TotalCountOfPublication INT
	DECLARE @TotalCountOfPublicationNode INT
	DECLARE @CountOfPublicationByCompleted INT
	DECLARE @CountOfPublicationNodeByCompleted INT
	DECLARE @CountOfFailure INT
	--------------------Sync date update for other by Series Id if Issue date is matched in series level


	-- This is commanded for further evaluation..dont remove it
	--IF(UPPER(@flag) = 'ESERIESCYCLEISSUEDATEMATCH')
	--BEGIN
	--		--@paraId to be Series
	--		--Update the publication SyncDate of give Series -Nochanges
	--		UPDATE	[TManual].ST_Engine_Publication_Details 
	--		SET	    
	--				[SyncDate] = GETDATE()					
	--		WHERE   [Id] IN (

	--		SELECT  ep.Id
	--		FROM			   [TManual].ST_Engine_Publication_Details ep 
	--				INNER JOIN [TManual].ST_Engine_Mark_Type em ON em.Id = ep.EngineMarkId
	--				INNER JOIN [TManual].ST_Engine_Series_Type es ON es.Id = em.EngineSeriesTypeId
	--		WHERE
	--				es.Id in (SELECT item FROM dbo.StringToTableValue(@paraId,',')) AND em.Active =1 AND ep.Active=1
	--		)	

	--		--Update the publicationNode SyncDate of give Series-Nochanges
	--		UPDATE	[TManual].[ST_Publication_Node_Details] 
	--		SET	    
	--				[SyncDate] = GETDATE()					
	--		WHERE   [Id] IN (

	--		SELECT pn.Id
	--		FROM			   [TManual].[ST_Publication_Node_Details]  pn
	--				INNER JOIN [TManual].ST_Engine_Publication_Details ep ON ep.Id = pn.EnginePublicationId
	--				INNER JOIN [TManual].ST_Engine_Mark_Type em ON em.Id = ep.EngineMarkId
	--				INNER JOIN [TManual].ST_Engine_Series_Type es ON es.Id = em.EngineSeriesTypeId
	--		WHERE
	--				es.Id in (SELECT item FROM dbo.StringToTableValue(@paraId,',')) AND em.Active =1 AND ep.Active=1 AND pn.Active=1
	--		)			
	--END
	IF(UPPER(@flag) = 'ESERIESCYCLEISSUEDATEMATCH')
	BEGIN
			--@paraId to be Series
			--Update the series syndate of given Series - (for finding whether the application is executed today)
			UPDATE	[TManual].ST_Engine_Series_Type
			SET	    
					[SyncDate] = GETDATE()					
			WHERE   [Id] IN (

			SELECT  es.Id
			FROM			   [TManual].ST_Engine_Publication_Details ep 
					INNER JOIN [TManual].ST_Engine_Mark_Type em ON em.Id = ep.EngineMarkId
					INNER JOIN [TManual].ST_Engine_Series_Type es ON es.Id = em.EngineSeriesTypeId
			WHERE
					es.Id in (SELECT item FROM dbo.StringToTableValue(@paraId,',')) AND em.Active =1 AND ep.Active=1
			)	
	END

	--------------------Sync date update for other by Series Id if Issue date is matched in series level
	ELSE IF(UPPER(@flag) = 'EPUBCYCLEISSUEDATEMATCH')
	BEGIN
			--@paraId to be pub
			--Update the publication SyncDate of give Series -Nochanges
			UPDATE	[TManual].ST_Engine_Publication_Details 
			SET	    
					[SyncDate] = GETDATE()					
			WHERE   [Id] IN (

			SELECT  ep.Id
			FROM			   [TManual].ST_Engine_Publication_Details ep 
					INNER JOIN [TManual].ST_Engine_Mark_Type em ON em.Id = ep.EngineMarkId
					INNER JOIN [TManual].ST_Engine_Series_Type es ON es.Id = em.EngineSeriesTypeId
			WHERE
					ep.Id in (SELECT item FROM dbo.StringToTableValue(@paraId,',')) AND em.Active =1 AND ep.Active=1
			)	

			--Update the publicationNode SyncDate of give Series-Nochanges
			UPDATE	[TManual].[ST_Publication_Node_Details] 
			SET	    
					[SyncDate] = GETDATE()					
			WHERE   [Id] IN (

			SELECT pn.Id
			FROM			   [TManual].[ST_Publication_Node_Details]  pn
					INNER JOIN [TManual].ST_Engine_Publication_Details ep ON ep.Id = pn.EnginePublicationId
					INNER JOIN [TManual].ST_Engine_Mark_Type em ON em.Id = ep.EngineMarkId
					INNER JOIN [TManual].ST_Engine_Series_Type es ON es.Id = em.EngineSeriesTypeId
			WHERE
					ep.Id in (SELECT item FROM dbo.StringToTableValue(@paraId,',')) AND em.Active =1 AND ep.Active=1 AND pn.Active=1
			)		
	END
	--------------------Sync status update for other by Series Id if Issue date is matched in series level		
	ELSE IF(UPPER(@flag) = 'UPDATESTATUSOFSERIESLEVEL')
	BEGIN
			--@paraId to be SeriesId
			--Update the publication SyncDate of give Series -Nochanges

			SELECT @TotalCountOfPublication=  COUNT(1)
			FROM			   [TManual].ST_Engine_Publication_Details ep 
					INNER JOIN [TManual].ST_Engine_Mark_Type em ON em.Id = ep.EngineMarkId
					INNER JOIN [TManual].ST_Engine_Series_Type es ON es.Id = em.EngineSeriesTypeId
			WHERE
					es.Id in (SELECT item FROM dbo.StringToTableValue(@paraId,',')) AND em.Active =1 AND ep.Active=1

			SELECT @CountOfPublicationByCompleted=  COUNT(1)
			FROM			   [TManual].ST_Engine_Publication_Details ep 
					INNER JOIN [TManual].ST_Engine_Mark_Type em ON em.Id = ep.EngineMarkId
					INNER JOIN [TManual].ST_Engine_Series_Type es ON es.Id = em.EngineSeriesTypeId
			WHERE
						es.Id in (SELECT item FROM dbo.StringToTableValue(@paraId,',')) AND em.Active =1 AND ep.Active=1
					AND UPPER(ep.SyncStatus)='COMPLETED' 


			IF(@TotalCountOfPublication=@CountOfPublicationByCompleted)
			BEGIN
				UPDATE	[TManual].ST_Engine_Series_Type 
				SET	    
						[SyncDate] = GETDATE(),
						[SyncStatus] ='Completed'
				WHERE
						Id =@paraId	
			END
	
	END
	--------------------Sync status update for other by Series Id if Issue date is matched in series level
	ELSE IF(UPPER(@flag) = 'UPDATESTATUSOFEPUBLEVEL')
	BEGIN
			--@paraId to be pubId
			--Update the publication SyncDate of give Series -Nochanges


			SELECT @TotalCountOfPublicationNode=   COUNT(1)
			FROM		 [TManual].[ST_Publication_Node_Details]  pn
					INNER JOIN [TManual].ST_Engine_Publication_Details ep ON ep.Id = pn.EnginePublicationId
					INNER JOIN [TManual].ST_Engine_Mark_Type em ON em.Id = ep.EngineMarkId
					INNER JOIN [TManual].ST_Engine_Series_Type es ON es.Id = em.EngineSeriesTypeId
			WHERE
					ep.Id in (SELECT item FROM dbo.StringToTableValue(@paraId,',')) AND em.Active =1 AND ep.Active=1 AND pn.Active=1

			SELECT @CountOfPublicationNodeByCompleted=  COUNT(1)
			FROM			   [TManual].[ST_Publication_Node_Details]  pn
					INNER JOIN [TManual].ST_Engine_Publication_Details ep ON ep.Id = pn.EnginePublicationId
					INNER JOIN [TManual].ST_Engine_Mark_Type em ON em.Id = ep.EngineMarkId
					INNER JOIN [TManual].ST_Engine_Series_Type es ON es.Id = em.EngineSeriesTypeId
			WHERE
					ep.Id in (SELECT item FROM dbo.StringToTableValue(@paraId,',')) AND em.Active =1 AND ep.Active=1  AND pn.Active=1
					AND (UPPER(pn.SyncStatus)='COMPLETED' OR UPPER(pn.SyncStatus)='NODRAWING')

			IF(@TotalCountOfPublicationNode=@CountOfPublicationNodeByCompleted)
			BEGIN
				UPDATE	[TManual].ST_Engine_Publication_Details 
				SET	    
						[SyncDate] = GETDATE(),
						[SyncStatus] ='Completed',
						[YetToCheckForCycle]=0
				WHERE
						Id =@paraId	
			END
	
	END	
	--------------------------------UPDATE IsManual status--------------------------------
	--IF(UPPER(@flag) = 'FAILCOUNT')
	--BEGIN
	--	 SET @CountOfFailure =(SELECT FailedCount FROM [TManual].ST_Publication_Node_Details WHERE Id=@paraId)	

	--	 IF( @CountOfFailure >=2)

	--		 UPDATE [TManual].ST_Publication_Node_Details 
	--	     SET 	
	--				IsManual=1
	--	     WHERE 
	--				[Id] = @paraId
	
	--	ELSE
	--		UPDATE [TManual].ST_Publication_Node_Details
	--		SET  
	--			   FailedCount = ISNULL(@CountOfFailure,0)+1
	--		WHERE  
	--			   [Id] = @paraId
	--END				
END TRY
BEGIN CATCH
   EXECUTE [dbo].[LogError]
END CATCH
