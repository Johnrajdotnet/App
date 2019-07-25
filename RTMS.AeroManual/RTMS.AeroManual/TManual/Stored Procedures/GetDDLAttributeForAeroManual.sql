
/****** Object:  StoredProcedure [TManual].[GetDDLAttributeForAeroManual]    Script Date: 3/16/2018 10:59:26 AM ******/

-- =============================================
-- Author:		<Neethu Rose Peter>
-- Create date: <15/02/2018,,>
-- Description:	< [TManual].[GetDDLAttributeForAeroManual]>
-- EXEC  [TManual].[GetDDLAttributeForAeroManual] 'EngineType'
-- =============================================
CREATE PROCEDURE [TManual].[GetDDLAttributeForAeroManual]
	-- Add the parameters for the stored procedure here
	@actionFlag NVARCHAR(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	BEGIN TRY		

	IF(@actionFlag='EngineType')
		BEGIN
			  SELECT
					 Id as GroupId,
					 CAST(Id as nvarchar(MAX)) as AttributeValue,
					 EngineName as AttributeName
			 FROM    [TManual].[ST_Engine_Type]		
		END	

	IF(@actionFlag='EngineSeriesType')
		BEGIN
			 SELECT
					  [EngineTypeId] as GroupId,
					  CAST(Id as nvarchar(MAX)) as AttributeValue,
					  [EngineSeriesName] as AttributeName			
			 FROM     [TManual].[ST_Engine_Series_Type]			
		END	
	IF(@actionFlag='EngineMarkType')
		BEGIN

			 SELECT
					[EngineSeriesTypeId] as GroupId,
					CAST(Id as nvarchar(MAX)) as AttributeValue,
					[EngineMarkName]  as AttributeName			
			 FROM   [TManual].[ST_Engine_Mark_Type]		
		END	
	IF(@actionFlag='EngineSeriesFamilyName')
		BEGIN
			 SELECT
					  [EngineTypeId] as GroupId,
					  CAST(Id as nvarchar(MAX)) as AttributeValue,
					  [EngineSeriesFamilyName] as AttributeName	--Series 500 ColumName add 	EngineSeriesFamilyName	
			 FROM     [TManual].[ST_Engine_Series_Type]		
		END	

	IF(@actionFlag='EngineAllList')
		BEGIN
			  SELECT
					 Id as GroupId,
					 CAST(Id as nvarchar(MAX)) as AttributeValue,
					 EngineName as AttributeName
			 FROM    [TManual].[ST_Engine_Type]

			 SELECT
					  [EngineTypeId] as GroupId,
					  CAST(Id as nvarchar(MAX)) as AttributeValue,
					  [EngineSeriesName] as AttributeName			
			 FROM     [TManual].[ST_Engine_Series_Type]	
			 
			 SELECT
					[EngineSeriesTypeId] as GroupId,
					CAST(Id as nvarchar(MAX)) as AttributeValue,
					[EngineMarkName]  as AttributeName			
			 FROM   [TManual].[ST_Engine_Mark_Type]					 			 		
		END	
	END TRY
		BEGIN CATCH
		EXECUTE [dbo].[LogError]
		END CATCH
END
