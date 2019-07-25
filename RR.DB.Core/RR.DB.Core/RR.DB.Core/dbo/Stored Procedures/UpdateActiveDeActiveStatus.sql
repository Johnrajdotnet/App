-- =============================================
-- Author:		<Neethu>
-- Create date: <09-01-2018>
-- Description:	<Activate/Deactivate User/Services>
-- =============================================
CREATE PROCEDURE [dbo].[UpdateActiveDeActiveStatus]
	-- Add the parameters for the stored procedure here
	@userId int,
	@applicationType int,
	@isValidCredential bit
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	DECLARE @rrId int
	
	SET NOCOUNT ON;

	IF (@applicationType = 1)
	  BEGIN
		  SELECT @rrId = Id FROM [Admin].[ST_User_RR_Credential] WHERE UserId = @UserId

		  UPDATE [Admin].OT_User_RR_Credential_Active SET RRCredentialActive = @isValidCredential  WHERE RRCredentialId = @rrId
	  END
	ELSE IF(@applicationType = 2)
	  BEGIN
		UPDATE [Admin].ST_Users SET Active = @isValidCredential where Id = @userId
	  END

	 
END