
-- =============================================
-- Author:		<Neethu>
-- Create date: <20/03/2017>
-- Description:	<Retrives User Login Data>
-- =============================================
--EXEC [dbo].[GetUserCredentialsApp] 'c1fb2b99-e381-4a65-b337-0617eaff3552'
CREATE PROCEDURE [dbo].[GetUserCredentialsApp]

	@userRoleid uniqueidentifier
AS
BEGIN
	SET NOCOUNT ON;
	BEGIN TRY
	 
	 SELECT 
			 u.UserId         AS [UserId],
		   --u.RRCareUserName AS [UserName],
			 u.FirstName      AS [FirstName],
			 u.MiddleName     AS [MiddleName],
			 u.LastName       AS [LastName],
			 u.EmailAddress   AS [EmailAddress],
			 u.ExpiryDate     AS [ExpiryDate],
			 u.Active         AS [Active]
	 
	 FROM       [Admin].[ST_Users] u
	 INNER JOIN [Admin].[ST_User_Role_Module] ur ON ur.UserId=u.Id
	 WHERE ur.Id=@userRoleid 
	 AND   u.Active = 1
	  
	END TRY

	BEGIN CATCH
	 EXECUTE [dbo].[LogError]
	END CATCH
END
