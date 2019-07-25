
-- =============================================
-- Author:		Vyshna
-- Create date: 02/05/2018
-- Description:	Get All Node Publication
-- exec [CollectTM].[GetAllPublicationTaskNode] NULL,NULL,NULL
-- =============================================
CREATE PROCEDURE [CollectTM].[GetAllPublicationTaskNode] 
	-- Add the parameters for the stored procedure here
	@engineTypeId int,
	@engineSeriesId bigint,
	@engineMarkId bigint,
	@machineIndex BIGINT

AS

BEGIN TRY
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements. 
	SET NOCOUNT ON;

    -- Insert statements for procedure here	
	SELECT 
				pn.Id as PublicationTaskNodeId,
				pn.EnginePublicationId as EnginePublicationId,
				et.Id as EngineTypeId,
				es.Id as EngineSeriesId,
				em.Id as EngineMarkId,
				et.EngineName as EngineTypeName,
				es.EngineSeriesName as EngineSeriesName,
				em.EngineMarkName as EngineMarkName,
				es.EngineMarkPageTitle as EngineMarkPageTitle,
				em.EPublicationTitleName as EnginePublicationTitle,
				ep.EnginePublicationLongName as EnginePublicationLongName,
				ep.EnginePublicationShotName  as EnginePublicationShotName,
				et.EngineTypeFolderName as EngineTypeFolderName,
				es.EngineSeriesFolderName as EngineSeriesFolderName,
				em.EngineMarkFolderName as EngineMarkFolderName,
				ep.EnginePubFolderName as EnginePubFolderName,
				--pn.ChapterLevel as ChapterLevel,
				--pn.SectionLevel as SectionLevel,
				--pn.PageBlockLevelName as PageBlockLevelName,
				--pn.FunctionalCode as FunctionalCode,
				pn.TaskLevelNumber as TaskLevelNumber,
				--pn.TaskLevelName as TaskLevelName,
				pn.FigureNumber as FigureNumber,
				ISNULL(pn.TaskLevelNumber,pn.FigureNumber) as TaskOrFigureNumber,
				em.EngineMarkName+' '+ep.EnginePublicationShotName+':' as TaskLevelPageTitle,
				pn.SequenceOrder as SequenceOrder,
				pn.IsDrawingAvailable as IsDrawingAvailable,
				pn.IssueDate as IssueDate,
				pn.SyncDate as SyncDate,
				pn.SyncStatus as SyncStatus,
				pn.Active as Active,
				pn.CreatedDate as CreatedDate,
				pn.ModifiedDate as ModifiedDate

	FROM        [TManual].[ST_Publication_Node_Details]  pn
			INNER JOIN [TManual].ST_Engine_Publication_Details ep ON ep.Id = pn.EnginePublicationId
			INNER JOIN [TManual].ST_Engine_Mark_Type em ON em.Id = ep.EngineMarkId
			INNER JOIN [TManual].ST_Engine_Series_Type es ON es.Id = em.EngineSeriesTypeId
			INNER JOIN [TManual].ST_Engine_Type et ON et.Id = es.EngineTypeId

	WHERE 
				(ep.EngineTypeId=(ISNULL(@engineTypeId, ep.EngineTypeId)) AND ep.EngineSeriesId=(ISNULL(@engineSeriesId, ep.EngineSeriesId))
			AND ep.EngineMarkId=(ISNULL(@engineMarkId, ep.EngineMarkId)))	
			AND UPPER(ISNULL(es.SyncStatus,'INPROGRESS'))='INPROGRESS'
			AND UPPER(ISNULL(ep.SyncStatus,'INPROGRESS'))='INPROGRESS'
			AND UPPER(ISNULL(pn.SyncStatus,'INPROGRESS'))='INPROGRESS'
			AND	pn.Active=1 AND em.Active =1 AND ep.Active =1 AND et.Active =1 
			AND es.IsManual=0 AND ep.IsManual=0 AND pn.IsManual=0 AND pn.YetToCheckForCycle=1
			AND pn.IsDrawingAvailable=1

	ORDER BY    ep.EngineTypeId,ep.EngineSeriesId,ep.EngineMarkId,ep.SequenceOrder,pn.SequenceOrder


END TRY
BEGIN CATCH
   EXECUTE [dbo].[LogError]
END CATCH

