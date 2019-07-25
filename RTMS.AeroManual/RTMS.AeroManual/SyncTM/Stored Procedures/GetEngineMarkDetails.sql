
-- =============================================
-- Author:		JohnRaj
-- Create date: 1/12/2018
-- Description:	Get All Node Publication
-- exec [SyncTM].[GetEngineMarkDetails] NULL
-- =============================================
CREATE PROCEDURE [SyncTM].[GetEngineMarkDetails] 
	-- Add the parameters for the stored procedure here
	@engineSeriesId bigint
AS

BEGIN TRY
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
    -- Insert statements for procedure here

	SELECT 
			em.Id as EngineMarkId,
			et.Id as EngineTypeId,
			em.EngineSeriesTypeId as EngineSeriesTypeId,			
			em.EngineMarkName as EngineMarkName,
			et.EngineName as EngineTypeName,
			es.EngineSeriesName as EngineSeriesName,				
			es.EngineMarkPageTitle as EngineMarkPageTitle,
			em.EPublicationTitleName as EPublicationTitleName,
			em.EngineMarkDescription as EngineMarkDescription,
			em.Active    as Active 

	FROM	[TManual].[ST_Engine_Mark_Type] em
		INNER JOIN 	[TManual].[ST_Engine_Series_Type] es ON  es.Id =em.EngineSeriesTypeId
		INNER JOIN 	[TManual].[ST_Engine_Type] et ON  et.Id =es.EngineTypeId

	WHERE
			em.EngineSeriesTypeId=(ISNULL(@engineSeriesId, em.EngineSeriesTypeId))
		AND UPPER(es.SyncStatus)='INPROGRESS'
		AND em.Active=1 AND es.Active=1 AND et.Active =1

	ORDER BY es.EngineTypeId,em.EngineSeriesTypeId,es.SequenceOrder, em.SequenceOrder

END TRY

BEGIN CATCH
   EXECUTE [dbo].[LogError]
END CATCH
