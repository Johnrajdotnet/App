

-- =============================================
-- Author:		<Neethu Rose Peter>
-- Create date: <16/02/2018>
-- Description:	<Get User Based On Role>
-- ============================================= [Admin].[GetUsersBasedOnRole] 2
CREATE PROCEDURE [Admin].[GetUsersBasedOnRole]
	-- Add the parameters for the stored procedure here
	@userRole int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	BEGIN TRY

	IF(@userRole=1)
	BEGIN

		SELECT u.Id AS UserId,
			   UPPER(u.FirstName+' '+u.LastName) AS Username	    
		
		FROM       [Admin].[ST_Users] u 
		INNER JOIN [Admin].[ST_User_Role_Module] ur ON u.Id=ur.UserId
		WHERE ur.RoleId=1 
		AND   u.Active=1

	END

	ELSE IF(@userRole=2)
	BEGIN

		SELECT u.Id AS UserId,
			   UPPER(u.FirstName+' '+u.LastName) AS Username	   
		
		FROM       [Admin].[ST_Users] u 
		INNER JOIN [Admin].[ST_User_Role_Module] ur on u.Id=ur.UserId
		WHERE ur.RoleId=2 
		AND    u.Active=1

	END

	ELSE IF(@userRole=3)
	BEGIN

		SELECT u.Id AS UserId,
			   UPPER(u.FirstName+' '+u.LastName) AS Username		    
		
		FROM       [Admin].[ST_Users] u 
		INNER JOIN [Admin].[ST_User_Role_Module] ur ON u.Id=ur.UserId
		WHERE ur.RoleId=3 
		AND   u.Active=1

	END

	ELSE IF(@userRole=4)
	BEGIN

		SELECT u.Id AS UserId,
			   UPPER(u.FirstName+' '+u.LastName) AS Username	  
		
		FROM       [Admin].[ST_Users] u 
		INNER JOIN [Admin].[ST_User_Role_Module] ur ON u.Id=ur.UserId
		WHERE ur.RoleId=4 
		AND    u.Active=1

	END
		
	ELSE IF(@userRole=5)
	BEGIN

		SELECT u.Id AS UserId,
			   UPPER(u.FirstName+' '+u.LastName) AS Username		    
		
		FROM       [Admin].[ST_Users] u 
		INNER JOIN [Admin].[ST_User_Role_Module] ur ON u.Id=ur.UserId
		WHERE ur.RoleId=5 
		AND    u.Active=1

	END
		
	END TRY
		BEGIN CATCH
		EXECUTE [dbo].[LogError]
		END CATCH
END




GO


