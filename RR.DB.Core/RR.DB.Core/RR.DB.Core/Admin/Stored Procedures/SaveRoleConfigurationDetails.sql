

-- =============================================
-- Author:		<Neethu>
-- Create date: <29-05-2018>
-- Description:	<Save Role Configuration Details>
-- =============================================
CREATE PROCEDURE [Admin].[SaveRoleConfigurationDetails]
	-- Add the parameters for the stored procedure here
	@selectedUserId   bigint,
	@selectedProgram  nvarchar(250),
	@selectedBusiness nvarchar(250),
	@selectedRole     int
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	DECLARE @userRoleId bigint
	
	SET NOCOUNT ON;

	BEGIN TRY

		SET @userRoleId=(SELECT Id FROM [Admin].[ST_Users] WHERE UserId=@selectedUserId)

		UPDATE  [Admin].[ST_User_Role_Module] 
		SET RoleId    = @selectedRole,
			ProgramId = @selectedProgram,
			BusinessModuleId=@selectedBusiness
		WHERE UserId=@userRoleId

	END TRY
	BEGIN CATCH
		 EXECUTE [dbo].[LogError]
	END CATCH

	 
END


