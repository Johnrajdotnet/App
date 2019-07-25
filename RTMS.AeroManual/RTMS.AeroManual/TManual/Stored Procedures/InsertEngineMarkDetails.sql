
-- =============================================
--PROCEDURE: [TManual].[InsertEngineMarkDetails] 
--PURPOSE: Insert engine mark data to [TManual].[ST_Engine_Mark_Type]
--CREATED: Vyshna P 01/30/2018
-- ============================================= 
CREATE PROCEDURE [TManual].[InsertEngineMarkDetails]
	@engineSeriesTypeId     bigint,
	@engineMarkName         nvarchar(50),  
	@engineMarkDescription  nvarchar(200)

AS
BEGIN TRY

	DECLARE @count bigint

	SET @count = (SELECT COUNT(*) FROM [TManual].[ST_Engine_Mark_Type] 
								  WHERE EngineSeriesTypeId=@engineSeriesTypeId)  
	IF(@count = 0)   
	BEGIN
			INSERT INTO [TManual].[ST_Engine_Mark_Type]
			(
				EngineSeriesTypeId,
				EngineMarkName,
				EngineMarkDescription
			)
			VALUES 
			(
				 @engineSeriesTypeId
				,@engineMarkName
				,@engineMarkDescription
			)
	END
END TRY
BEGIN CATCH
   EXECUTE [dbo].[LogError]
END CATCH