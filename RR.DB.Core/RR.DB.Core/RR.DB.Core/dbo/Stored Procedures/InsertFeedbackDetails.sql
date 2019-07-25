/****** Object:  StoredProcedure [SyncTM].[GetEnginePublicationDetails]    Script Date: 5/8/2018 2:41:05 PM ******/
-- =============================================
-- Author:		Vyshna
-- Create date: 05/08/2018
-- Description:	Insert feedback Details
-- exec [dbo].[InsertFeedbackDetails] 
-- =============================================
CREATE PROCEDURE [dbo].[InsertFeedbackDetails] 
	-- Add the parameters for the stored procedure here
	@feedback    nvarchar(max),
	@createdBy   uniqueidentifier

AS

BEGIN TRY
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
    -- Insert statements for procedure here

		INSERT INTO  [dbo].[FeedbackDetails] 
				(
					FeedbackQuery,
					CreatedBy,
					CreatedDate
				)
				VALUES
				(
					@feedback,
					@createdBy,
					GETDATE()
				)

END TRY

BEGIN CATCH
   EXECUTE [dbo].[LogError]
END CATCH

