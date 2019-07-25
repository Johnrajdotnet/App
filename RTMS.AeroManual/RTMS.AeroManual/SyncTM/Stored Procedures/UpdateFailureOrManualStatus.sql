
-- =============================================
-- Author:		ARATHY
-- Create date: 3/2/2018
-- Description:	Update data based flag value 
-- exec [SyncTM].[UpdateFailureOrManualStatus] ENGINETYPE,9
-- =============================================
CREATE PROCEDURE [SyncTM].[UpdateFailureOrManualStatus]

		@flag  nvarchar(50),
		@paraId  INT	--Any Id based on flag	
			
AS
BEGIN TRY

	DECLARE @CountOfFailure INT

	IF(UPPER(@flag) = 'ENGINETYPE')   
	BEGIN
		-- paraid enginetypeID
		 
			SELECT @CountOfFailure=FailedCount FROM [TManual].ST_Engine_Series_Type WHERE [EngineTypeId]=@paraId AND Active=1	

			IF( @CountOfFailure >=2)

				 UPDATE [TManual].ST_Engine_Series_Type
				 SET 	
					IsManual=1
				WHERE 
					[EngineTypeId] = @paraId AND Active=1
	
			ELSE
				UPDATE [TManual].ST_Engine_Series_Type
				SET  
				   FailedCount = ISNULL(@CountOfFailure,0)+1
				WHERE  
				   [EngineTypeId] = @paraId AND Active=1
		
	END
	ELSE IF(UPPER(@flag) = 'ENGINESERIES')
	BEGIN
		
		SELECT @CountOfFailure=FailedCount FROM [TManual].ST_Engine_Publication_Details WHERE [EngineSeriesId]=@paraId AND Active=1	

			IF( @CountOfFailure >=2)

				 UPDATE [TManual].ST_Engine_Publication_Details
				 SET 	
					IsManual=1
				 WHERE 
					[EngineSeriesId] = @paraId AND Active=1
			ELSE
				UPDATE [TManual].ST_Engine_Publication_Details
				SET  
				   FailedCount = ISNULL(@CountOfFailure,0)+1
				WHERE  
				   [EngineSeriesId] = @paraId AND Active=1		
	END
	ELSE IF(UPPER(@flag) = 'EPUBLICATION')
	BEGIN
	
	
			SELECT @CountOfFailure = FailedCount FROM [TManual].ST_Publication_Node_Details WHERE [EnginePublicationId]=@paraId	AND Active=1	

			IF( @CountOfFailure >=2)

				 UPDATE [TManual].ST_Publication_Node_Details
				 SET 	
					IsManual=1
				 WHERE 
					[EnginePublicationId] = @paraId AND Active=1
			ELSE
				UPDATE [TManual].ST_Publication_Node_Details
				SET  
				   FailedCount = ISNULL(@CountOfFailure,0)+1
				WHERE  
				   [EnginePublicationId] = @paraId AND Active=1
		
	END
	ELSE IF(UPPER(@flag) = 'EPUBLICATIONNODE')
	BEGIN
	
	
			SELECT @CountOfFailure =FailedCount FROM [TManual].ST_Publication_Node_Details WHERE [Id]=@paraId AND Active=1	

			IF( @CountOfFailure >=2)

				 UPDATE [TManual].ST_Publication_Node_Details
				 SET 	
					IsManual=1
				 WHERE 
					[Id] = @paraId AND Active=1
			ELSE
				UPDATE [TManual].ST_Publication_Node_Details
				SET  
				   FailedCount = ISNULL(@CountOfFailure,0)+1
				WHERE  
				   [Id] = @paraId AND Active=1
		
	END

END TRY

BEGIN CATCH
   EXECUTE [dbo].[LogError]
END CATCH
