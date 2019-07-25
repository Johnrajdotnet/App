
-- =============================================
-- Author:           <Neethu Rose>
-- Create date: <1/3/18>
-- Description:      <Insert Effectivity Detail to [TManual].[OT_Manual_EIPC_Details] >
-- =============================================
CREATE PROCEDURE [TManual].[InsertEffectivityDetail]
       -- Add the parameters for the stored procedure here
                
          @figOrItemNumber nvarchar(250),
          @partNumber  nvarchar(250),
          @assy  nvarchar(10),
          @engineMark nvarchar(250),
          @publicationNodeId  int,
                @active bit
          
AS  
BEGIN
       -- SET NOCOUNT ON added to prevent extra result sets from
       -- interfering with SELECT statements.
       SET NOCOUNT ON;
       

       BEGIN TRY
             
                                           INSERT INTO  [TManual].[OT_Manual_EIPC_Details]
                                           (
                                                [PublicationNodeId],
                                                [EPICEngineMark],
                                                [FigOrItemNumber],
                                                [PartNumber],
                                                [Assy],
                                                [Active],
                                                [CreatedDate]
                                           )
                                           VALUES
                                           (                                         
                                                   @publicationNodeId,
                                                   @engineMark,
                                                   @figOrItemNumber,
                                                   @partNumber,
                                                   @assy,
                                                   @active,
                                                   GETDATE()
                                            )

                                           
                      
       END TRY
        BEGIN CATCH
            EXECUTE [dbo].[LogError]
        END CATCH
END






GO


