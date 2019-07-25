
-- =============================================
-- Author:           <John Raj>
-- Create date: <08/03/2018,,>
-- Description:      GetManualInformationDetails
-- exec [CollectTM].[GetManualInformationDetails] 1
-- =============================================
CREATE PROCEDURE [CollectTM].[GetManualInformationDetails]
          @publicationNodeId  bigint
AS  
BEGIN
       -- SET NOCOUNT ON added to prevent extra result sets from
       -- interfering with SELECT statements.
       SET NOCOUNT ON;
       SELECT 
			Id				   as  Id,
			PublicationNodeId  as  PublicationNodeId,
			TaskOrTitleName	   as  TaskOrTitleName,	
			ATANumber          as  ATANumber, 
			FunctionalCode     as  FunctionalCode, 
			RepairSchemeNumber as  RepairSchemeNumber,
			PageContent        as  PageContent,
			FileServerPath     as  FileServerPath,
			IsDownloadSuccess  as  IsDownloadSuccess,
			CreatedDate        as  CreatedDate,
			ModifiedDate       as  ModifiedDate
			 
	   FROM
			 [TManual].[OT_Manual_Information_Details]
	   WHERE
			 PublicationNodeId=@publicationNodeId		 
END


