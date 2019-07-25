
-- =============================================
-- Author:           <Neethu Rose>
-- Create date: <08/03/2018,,>
-- Description:      <AddOrUpdateManualInformationDetails>
-- =============================================
-- Description:      <AddOrUpdateManualInformationDetails>
-- exec [TManual].[AddOrUpdateManualInformationDetails] ('Add',0,5,null,'','',1)
-- =============================================
CREATE PROCEDURE [TManual].[AddOrUpdateManualInformationDetails]
       -- Add the parameters for the stored procedure here
		  @actionflag nvarchar(10),
          @id bigint,
          @publicationNodeId  bigint,
          @repairSchemeNumber  nvarchar(250),
          @PageContent text,
          @fileServerPath  nvarchar(max),
          @isDownloadSuccess bit
AS  
BEGIN
       -- SET NOCOUNT ON added to prevent extra result sets from
       -- interfering with SELECT statements.
       SET NOCOUNT ON;
       

       BEGIN TRY

                     IF (UPPER(@actionflag) ='ADD')

                     BEGIN
                
						  INSERT INTO  [TManual].[OT_Manual_Information_Details](
							  [PublicationNodeId],
							  [RepairSchemeNumber],
							  [PageContent],
							  [FileServerPath],
							  [IsDownloadSuccess],
							  [CreatedDate]
						  )
						  VALUES
						  (
							  @publicationNodeId,
							  @repairSchemeNumber,
							  @PageContent,
							  @FileServerPath,
							  @isDownloadSuccess,
							  GETDATE()
						  )
                     END

					 ELSE IF (UPPER(@actionflag) ='UPDATE')

                     BEGIN

						  UPDATE [TManual].[OT_Manual_Information_Details] 
						  SET
							  [RepairSchemeNumber]=@repairSchemeNumber,
							  [PageContent]=@PageContent,
							  [FileServerPath]=@FileServerPath,
							  [IsDownloadSuccess]=@isDownloadSuccess,
							  [ModifiedDate]=GETDATE()
						  WHERE [Id]=@id
                     END
                      
       END TRY
        BEGIN CATCH
            EXECUTE [dbo].[LogError]
        END CATCH
END
