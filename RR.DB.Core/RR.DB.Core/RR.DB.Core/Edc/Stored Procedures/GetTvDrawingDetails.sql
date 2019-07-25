
-- =============================================
-- Author:           <Mira>
-- Create date:            <07/03/2019>
-- Description:      <Retrives TV Drawing Details from [Edc].[OT_TV_Drawing_Details]>
-- [Edc].[GetTvDrawingDetails] 
CREATE PROCEDURE [Edc].[GetTvDrawingDetails] 
@partNumber       NVARCHAR(50),
@partDescription  NVARCHAR(MAX),
@issueDate        NVARCHAR(200),
@revision         NVARCHAR(10),
@series           NVARCHAR(50)
AS
BEGIN TRY
              
              SELECT  TOP  2000
						[FileName]                AS FileName,
                        [PartNumber]              AS PartNumber,
                        [PartDescription]         AS PartDescription,
                        CONVERT(date,[IssueDate]) AS IssueDate,
                        [Revision]                AS Revision,
                        [Series]                  AS Series,
                        [FilePath]                AS FilePath,
						[CpiritLink]			  AS CpiritLink
                         
              FROM   [Edc].[OT_TV_Drawing_Details]
                           
              WHERE  [Active]=1 
			  AND PartNumber like '%'+ISNULL(@partNumber,PartNumber)+'%' 
			  AND PartDescription like '%'+ISNULL(@partDescription,PartDescription)+'%' 
			  AND IssueDate like '%'+ ISNULL(@issueDate,IssueDate)+'%'
			  AND Revision like '%'+ISNULL(@revision,Revision)+'%'
			  AND Series like '%'+ISNULL(@series,Series)+'%'			  
			  ORDER BY CreatedDate DESC
                           

END TRY
BEGIN CATCH
   EXECUTE [dbo].[LogError]
END CATCH

