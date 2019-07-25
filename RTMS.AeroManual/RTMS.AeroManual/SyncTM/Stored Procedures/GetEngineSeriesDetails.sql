
-- =============================================
-- Author:		JohnRaj
-- Create date: 1/12/2018
-- Description:	Get All Node Publication
-- exec [SyncTM].[GetEngineSeriesDetails] NULL
-- =============================================
CREATE PROCEDURE [SyncTM].[GetEngineSeriesDetails] 
	-- Add the parameters for the stored procedure here
	@engineTypeId int
AS

BEGIN TRY
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
    -- Insert statements for procedure here

	     SELECT 
                es.Id as EngineSeriesId,
                es.EngineTypeId as EngineTypeId,
                et.EngineName as EngineName,
                es.EngineSeriesName as EngineSeriesName,
				es.EngineSeriesDescription as EngineSeriesDescription,
                es.EngineMarkPageTitle as EngineMarkPageTitle,
                es.IssueDate as IssueDate,
                es.SyncDate as SyncDate,
                es.SyncStatus as SyncStatus,
                es.Active    

        FROM [TManual].[ST_Engine_Series_Type] es
        INNER JOIN    [TManual].[ST_Engine_Type] et on  et.Id =es.EngineTypeId
        WHERE
            es.EngineTypeId=ISNULL(@engineTypeId,es.EngineTypeId)
			AND es.Active=1  AND es.IsManual=0
		ORDER BY 
			es.SequenceOrder

END TRY

BEGIN CATCH
   EXECUTE [dbo].[LogError]
END CATCH


