-- =============================================
-- Author:		JohnRaj
-- Create date: 1/12/2018
-- Description:	Get All Node Publication
-- exec [SyncTM].[GetPublicationNodeByPublication] null
-- =============================================
CREATE PROCEDURE [SyncTM].[GetPublicationNodeByPublication] 
	-- Add the parameters for the stored procedure here
	@enginePublicationId bigint
AS
BEGIN TRY
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements. 
	SET NOCOUNT ON;

    -- Insert statements for procedure here

		SELECT 
			pn.Id as PublicationTaskNodeId,
		    pn.EnginePublicationId as EnginePublicationId,
			et.EngineName as EngineTypeName,
			es.EngineSeriesName as EngineSeriesName,
			em.EngineMarkName as EngineMarkName,
			es.EngineMarkPageTitle as EngineMarkPageTitle,
			em.EPublicationTitleName as EnginePublicationTitle,
			ep.EnginePublicationLongName as EnginePublicationLongName,
			ep.EnginePublicationShotName  as EnginePublicationShotName,
			--pn.ChapterLevel as ChapterLevel,
			--pn.SectionLevel as SectionLevel,
			--pn.PageBlockLevelName as PageBlockLevelName,
			--pn.FunctionalCode as FunctionalCode,
			pn.TaskLevelNumber as TaskLevelNumber,
			--pn.TaskLevelName as TaskLevelName,
			pn.FigureNumber as FigureNumber,
			ISNULL(pn.TaskLevelNumber,pn.FigureNumber) as TaskOrFigureNumber,
			em.EngineMarkName+' '+ep.EnginePublicationShotName+':' as TaskLevelPageTitle,		
			pn.IsDrawingAvailable as IsDrawingAvailable,
			pn.IssueDate as IssueDate,
			pn.SyncDate as SyncDate,
			pn.SyncStatus as SyncStatus,
			pn.Active as Active,
			pn.CreatedDate as CreatedDate,
			pn.ModifiedDate as ModifiedDate

	FROM	[TManual].[ST_Publication_Node_Details]  pn
			INNER JOIN [TManual].ST_Engine_Publication_Details ep ON ep.Id = pn.EnginePublicationId
			INNER JOIN [TManual].ST_Engine_Mark_Type em ON em.Id = ep.EngineMarkId
			INNER JOIN [TManual].ST_Engine_Series_Type es ON es.Id = em.EngineSeriesTypeId
			INNER JOIN [TManual].ST_Engine_Type et ON et.Id = es.EngineTypeId
	WHERE	
			EnginePublicationId = ISNULL(@enginePublicationId, EnginePublicationId)	
			AND	pn.Active=1 AND em.Active =1 AND ep.Active =1 AND et.Active =1 
		    AND es.IsManual=0 AND ep.IsManual=0 AND pn.IsManual=0
			AND UPPER(ISNULL(es.SyncStatus,'INPROGRESS'))='INPROGRESS'

END TRY
BEGIN CATCH
   EXECUTE [dbo].[LogError]
END CATCH