
-- =============================================
-- Author:		<Blessy Babu>
-- Create date: <20-12-2018>
-- Description:	<For inserting the data in [RTMS.DB.App].LinkDB.LT_ST_User_Role_Module >
-- =============================================
CREATE PROCEDURE [Admin].[InsertDBLinkObject]
	-- Add the parameters for the stored procedure here
	@UserRoleModuleId UNIQUEIDENTIFIER ,
	@Id               INT,
	@Flag             VARCHAR(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
    BEGIN TRY
		-- Insert statements for procedure here
			IF(@Flag='NewUser')
				BEGIN
		  
				   INSERT INTO [RTMS].LinkDB.LT_ST_User_Role_Module
					   (
						   [UserRoleModuleId],
						   [CreateDate],
						   [ModifiedDate]
					   )
				   SELECT		       
						   @UserRoleModuleId,
						   GETDATE(),
						   NULL
			   
				END
    END TRY
	BEGIN CATCH
      EXECUTE [dbo].[LogError]
    END CATCH     
END
