
/****** Object:  StoredProcedure [dbo].[GetFeedbackDisplayDetails]   Script Date: 5/8/2018 2:41:05 PM ******/
-- =============================================
-- Author:		Arathy
-- Create date: 05/08/2018
-- Description:	get feedback Details
-- exec [dbo].[GetFeedbackDisplayDetails] 
-- =============================================
CREATE PROCEDURE [dbo].[GetFeedbackDisplayDetails] 
	-- Add the parameters for the stored procedure here
	

AS
DECLARE @CreatedUser nvarchar(50);
BEGIN TRY
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
    -- Insert statements for procedure here
		SELECT
				 fd.[Id]                        AS Id,
				 [FeedbackQuery]                AS Feedback,
				 [Remarks]                      AS Remarks,
				 [Status]                       AS Status,
		      -- [CreatedBy]                    AS CreatedBy,
				 ud.FirstName +' '+ ud.LastName AS CreatedUser,
				 fd.[CreatedDate]               AS CreatedDate 

		 FROM	 [dbo].[FeedbackDetails] fd
		 INNER JOIN [Admin].[ST_User_Role_Module] urm ON fd.CreatedBy =urm.Id
		 INNER JOIN [Admin].[ST_Users] ud             ON urm.UserId = ud.Id
END TRY

BEGIN CATCH
   EXECUTE [dbo].[LogError]
END CATCH