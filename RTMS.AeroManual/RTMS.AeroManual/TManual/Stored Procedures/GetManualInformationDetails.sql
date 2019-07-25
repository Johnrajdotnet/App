


/****** Object:  StoredProcedure [TManual].[GetManualInformationDetails]    Script Date: 3/16/2018 10:58:43 AM ******/

-- =============================================
-- Author:           Neethu Rose
-- Create date: 1/12/2018
-- Description:      Search Page Content column in [TManual].[OT_Manual_Information_Details]
-- EXEC [TManual].[GetManualInformationDetails] 9,1,1,'neethu',null,null,'Select','Select'
-- =============================================
CREATE PROCEDURE [TManual].[GetManualInformationDetails]
       -- Add the parameters for the stored procedure here
	   @engineTypeId bigint,
	   @engineSeriesId bigint,
	   @engineMarkId bigint,
       @freeText1 nvarchar(Max),
       @freeText2 nvarchar(Max),
       @freeText3 nvarchar(Max),
       @condition1 nvarchar(Max),
       @condition2 nvarchar(Max)
AS

BEGIN TRY
       -- SET NOCOUNT ON added to prevent extra result sets from
       -- interfering with SELECT statements.
       SET NOCOUNT ON;

		  DECLARE @searchText nvarchar(Max)
		  DECLARE @lenFreetext1 int
          DECLARE @lenFreetext2 int
          DECLARE @lenFreetext3 int
          DECLARE @queryConditionText nvarchar(Max)
          DECLARE @dynamicTable TABLE (Id INT IDENTITY(1,1) NOT NULL,PublicationNodeId INT)
		  DECLARE @publicationNodeId int
       BEGIN
          
				
                 SET @lenFreetext1= LEN(ISNULL(@freeText1,''))
                 SET @lenFreetext2= LEN(ISNULL(@freeText2,''))
                 SET @lenFreetext3= LEN(ISNULL(@freeText3,''))
                
				 SET @searchText=
				   'SELECT 
								pn.Id as PublicationNodeId
					FROM		[TManual].[ST_Engine_Publication_Details] pd
					INNER JOIN  [TManual].[ST_Publication_Node_Details] pn ON pn.EnginePublicationId=pd.Id
					INNER JOIN  [TManual].[OT_Manual_Information_Details] mi ON mi.PublicationNodeId=pn.Id

					WHERE 
								pd.EngineTypeId='+CONVERT(nvarchar(10),@engineTypeId)
								+' AND pd.EngineSeriesId='+CONVERT(nvarchar(10),@engineSeriesId)
								+' AND pd.EngineMarkId='+CONVERT(nvarchar(10),@engineMarkId) 
								+' AND '


                 IF(@lenFreetext1>0 AND @lenFreetext2>0 AND @lenFreetext3>0)       
                        BEGIN
                                  SET @queryConditionText='mi.PageContent LIKE ''%'+@freeText1+'%'' '+@condition1+' mi.PageContent LIKE ''%'+@freeText2+'%'' ' 
                                                                           +@condition2+' mi.PageContent LIKE ''%'+@freeText3+'%'' '
                                  SET @searchText=@searchText+@queryConditionText

                        END
                 ELSE IF(@lenFreetext1>0 AND @lenFreetext2>0 AND @lenFreetext3=0)
                        BEGIN
                                  SET @queryConditionText='mi.PageContent LIKE ''%'+@freeText1+'%'' '+@condition1+' mi.PageContent LIKE ''%'+@freeText2+'%'' ' 
                                                                           
                                  SET @searchText=@searchText+@queryConditionText

                        END 
                 ELSE IF(@lenFreetext1>0 AND @lenFreetext2=0 AND @lenFreetext3=0)
                        BEGIN
                                  SET @queryConditionText='mi.PageContent LIKE ''%'+@freeText1+'%'''
                                  SET @searchText=@searchText+@queryConditionText

                        END 
             
              INSERT @dynamicTable
              EXEC(@searchText)

              SELECT 
							 ISNULL(pn.TaskLevelNumber,pn.FigureNumber) as TaskOrFigureNumber,
									 mi.[TaskOrTitleName] as [TaskOrTitleName],
									 mi.FileServerPath as [FileServerPath],
									 pn.SyncDate as [SyncDate],
									 pn.IsManual as [IsManual],
									 pn.SyncStatus as [SyncStatus]
			  FROM		  [TManual].[OT_Manual_Information_Details] mi 
			  INNER JOIN  [TManual].[ST_Publication_Node_Details] pn ON mi.PublicationNodeId=pn.Id
              WHERE 
						  pn.Id IN(SELECT PublicationNodeId FROM @dynamicTable)
       END    
END TRY

BEGIN CATCH
   EXECUTE [dbo].[LogError]
END CATCH