
-- =============================================
-- Author:           <Neethu>
-- Create date:            <08/05/2018>
-- Description:      <Retrives TV Drawing Details from [Edc].[OT_TV_Drawing_Details] based on partNumber nd Series>
-- [Edc].[GetDrawingInfoByPartnumSeries]
CREATE PROCEDURE [Edc].[GetDrawingInfoByPartnumSeries]
       @partNumber nvarchar(250),
       @revision nvarchar(250)
AS
BEGIN TRY
              
              SELECT    [FileName]                AS FileName,
                        [PartNumber]              AS PartNumber,
                        [PartDescription]         AS PartDescription,
                        CONVERT(date,[IssueDate]) AS IssueDate,
                        [Revision]                AS Revision,
                        [Series]                  AS Series,
                        [FilePath]                AS FileServerPath,
                        [Active]                  AS Active,
						[CpiritLink]			  AS CpiritLink
                         
              FROM   [Edc].[OT_TV_Drawing_Details]
                           
              WHERE  [PartNumber]=@partNumber AND 
                     [Revision]=@revision AND
                     [Active]=1
                           

END TRY
BEGIN CATCH
   EXECUTE [dbo].[LogError]
END CATCH
