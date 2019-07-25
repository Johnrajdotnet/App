
-- =============================================
--PROCEDURE: [TManual]].[InsertEnginePublicationDetails] 
--PURPOSE: Insert engine publication data to [TManual].[ST_Engine_Publication_Details]
--CREATED: Vyshna P 01/30/2018
-- ============================================= 

CREATE PROCEDURE [TManual].[InsertEnginePublicationDetails]
	@engineTypeId					int,
	@engineSeriesId					bigint,  
	@engineMarkId					bigint, 
	@enginePublicationShotName		nvarchar(50), 
	@enginePublicationLongName		nvarchar(20), 
	@enginePublicationDescription	nvarchar(50),
	@issueDate						datetime

AS
BEGIN TRY

	DECLARE @count int

	SET @count = (SELECT COUNT(*) FROM [TManual].[ST_Engine_Publication_Details] 
				  WHERE EngineTypeId=@engineTypeId
				   AND EngineSeriesId=@engineSeriesId
				   AND EngineMarkId =@engineMarkId
				 )  

	IF(@count=0)   
	BEGIN    
			INSERT INTO [TManual].[ST_Engine_Publication_Details]
			(
				 EngineTypeId
				,EngineSeriesId
				,EngineMarkId
				,EnginePublicationShotName
				,EnginePublicationLongName
				,EnginePublicationDescription
				,IssueDate
			)
			VALUES  
			(
				 @engineTypeId
				,@engineSeriesId
				,@engineMarkId
				,@enginePublicationShotName
				,@enginePublicationLongName
				,@enginePublicationDescription
				,@issueDate
			)
	END
END TRY
BEGIN CATCH
   EXECUTE [dbo].[LogError]
END CATCH