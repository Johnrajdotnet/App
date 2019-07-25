
-- =============================================
-- Author:		Vyshna
-- Create date: 1/30/2018
-- Description:	Get All Engine Publication Details
-- exec [SyncTM].[GetEnginePublicationDetails] null,null,null
-- =============================================
CREATE PROCEDURE [SyncTM].[GetEnginePublicationDetails] 
	-- Add the parameters for the stored procedure here
	@engineTypeId int,
	@engineSeriesId bigint,
	@engineMarkId bigint

AS

BEGIN TRY
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
    -- Insert statements for procedure here

	SELECT  
				ep.Id as EnginePublicationId,
				ep.EngineTypeId as EngineTypeId,
				ep.EngineSeriesId as EngineSeriesId,
		        ep.EngineMarkId as EngineMarkId,
				et.EngineName as EngineTypeName,
				es.EngineSeriesName as EngineSeriesName,
				em.EngineMarkName as EngineMarkName,				
				es.EngineMarkPageTitle as EngineMarkPageTitle,
				ep.EnginePublicationShotName as EnginePublicationShotName, 
			    ep.EnginePublicationLongName as EnginePublicationLongName,
			    ep.EnginePublicationDescription as EnginePublicationDescription,
				em.EPublicationTitleName as EnginePublicationTitle,
			    ep.IssueDate as IssueDate, 
			    ep.SyncDate as SyncDate, 
			    ep.SyncStatus as SyncStatus, 
			    ep.Active as Active, 
			    ep.CreatedDate as CreatedDate, 
			    ep.ModifiedDate as ModifiedDate
			
	FROM		[TManual].[ST_Engine_Publication_Details] ep	
			INNER JOIN [TManual].ST_Engine_Mark_Type em ON em.Id = ep.EngineMarkId
			INNER JOIN [TManual].ST_Engine_Series_Type es ON es.Id = em.EngineSeriesTypeId
			INNER JOIN [TManual].ST_Engine_Type et ON et.Id = es.EngineTypeId
	WHERE 		
				(ep.EngineTypeId=(ISNULL(@engineTypeId, ep.EngineTypeId)) 
			AND ep.EngineSeriesId=(ISNULL(@engineSeriesId, ep.EngineSeriesId))
			AND ep.EngineMarkId=(ISNULL(@engineMarkId, ep.EngineMarkId)))	
			AND UPPER(es.SyncStatus)='INPROGRESS'
			AND ep.Active=1 AND em.Active=1 AND es.Active=1 AND et.Active=1
			AND es.IsManual=0 AND ep.IsManual=0
	ORDER BY	ep.EngineTypeId,ep.EngineSeriesId,ep.EngineMarkId,ep.SequenceOrder

END TRY

BEGIN CATCH
   EXECUTE [dbo].[LogError]
END CATCH
