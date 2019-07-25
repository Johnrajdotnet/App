-- =============================================
-- Author:		<Vyshna>
-- Create date: <Create Date,,>
-- Description:	<Get user active deactive details>
-- EXEC [Admin].[UpdateUserActiveDeactivateStatus] '0b33cb55-1089-4aae-9b7a-bebc3dfc6cb8', 1, '0c8b973d-569e-4521-9a9f-9b56fa22d06b'
-- ============================================= 

CREATE PROCEDURE [Admin].[UpdateUserActiveDeactivateStatus] 
	-- Add the parameters for the stored procedure here
	 @userId uniqueidentifier,
	 @active bit,
	 @logonUserId uniqueidentifier
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	DECLARE @Id int;
	BEGIN TRY
    -- Insert statements for procedure here
	SELECT @Id = UserId FROM [Admin].[ST_User_Role_Module] WHERE Id= @userId
	IF(@Id <> 0)
	BEGIN

	UPDATE [Admin].[ST_Users]
		 SET Active = @active
	WHERE Id = @Id

	END
	END TRY

	BEGIN CATCH
	 EXECUTE [dbo].[LogError]
	END CATCH
END