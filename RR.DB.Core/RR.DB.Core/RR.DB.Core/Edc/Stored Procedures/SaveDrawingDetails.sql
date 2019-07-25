
-- =============================================
-- Author:           <neethu>
-- Create date: <05/11/2018>
-- Description:      <Save Drawing Info>
-- =============================================
CREATE PROCEDURE [Edc].[SaveDrawingDetails]
        @action nvarchar(20),
              @partNumber nvarchar(100),
              @partDescription nvarchar(250),
              @issueDate datetime,
              @engineSeries nvarchar(250),
              @active bit,
              @revision nvarchar(250),
              @filepath nvarchar(250),
              @userRoleId nvarchar(250),
			  @cpiRit nvarchar(250)
AS
BEGIN
       
       SET NOCOUNT ON;
       BEGIN TRY

              IF(@action = 'ADD')
              BEGIN
                     INSERT INTO [Edc].[OT_TV_Drawing_Details] (
                           [FileName],
                           [PartNumber],
                           [PartDescription],
                           [IssueDate],
                           [Revision],
                           [Series],
                           [FilePath],
						   CpiritLink,
                           [CreatedBy]
                           )
                           VALUES(
                           @partNumber+'_'+@revision+'.pdf',
                           @partNumber,
                           @partDescription,
                           @issueDate,
                           @revision,
                           @engineSeries,
                           @filepath,
						   @cpiRit,
                           @userRoleId
                           )
              END

              ELSE IF(@action = 'UPDATE' and @filepath !='' )
              BEGIN

                     UPDATE [Edc].[OT_TV_Drawing_Details]  
                     SET    
                        [PartDescription]= @partDescription,
                        [IssueDate]=@issueDate,
                        [Series]=@engineSeries,
                        [FilePath]=@filepath,
                        [Active]=@active,
                        [ModifiedBy]=@userRoleId,
                        [ModifiedDate] =GETDATE()
                     WHERE  [PartNumber]= @partNumber and [Revision]=@revision
              END 

              ELSE IF(@action = 'UPDATE' and @filepath ='' )
              BEGIN
                     UPDATE [Edc].[OT_TV_Drawing_Details]  
                     SET    
                        [PartDescription]= @partDescription,
                        [IssueDate]=@issueDate,
                        [Series]=@engineSeries,
                        [Active]=@active,
                        [ModifiedBy]=@userRoleId,
                        [ModifiedDate] =GETDATE()
                     WHERE  [PartNumber]= @partNumber and [Revision]=@revision
              END 
       END TRY
       BEGIN CATCH
         EXECUTE [dbo].[LogError]
       END CATCH
END
