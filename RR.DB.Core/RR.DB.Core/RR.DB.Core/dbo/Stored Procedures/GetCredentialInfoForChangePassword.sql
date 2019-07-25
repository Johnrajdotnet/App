
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Get the user details on RTMSApp change password request/RTMSService changepassword request>
-- =============================================
CREATE PROCEDURE [dbo].[GetCredentialInfoForChangePassword]
	-- Add the parameters for the stored procedure here
	   @OracleId    int,
       @password    nvarchar(250),
	   @serviceType int
AS
BEGIN
 BEGIN TRY
       IF(@serviceType=1)  ---Application
		 BEGIN
		  
	   SELECT	    ur.Id                          AS [UserRoleId],
					ur.RoleId                      AS [RoleId],
					isnull(ur.BusinessModuleId,'') AS BuisnessModule,
					u.FirstName                    AS [FirstName],
					u.LastName                     AS [LastName]

       FROM			[Admin].[ST_User_Role_Module] ur
       INNER JOIN	[Admin].[ST_Users] u ON u.Id=ur.UserId
       WHERE		u.UserId=@OracleId 
	   AND			u.Password=@password 
	   AND          u.Active=1

	 END
 
		IF (@serviceType=2) -- Service
				 BEGIN
				  SELECT ur.Id                          AS [UserRoleId],  
					     ur.RoleId                      AS [RoleId],
					     isnull(ur.BusinessModuleId,'') AS BuisnessModule,
					     u.FirstName                    AS [FirstName],
					     u.LastName                     AS [LastName]

				 FROM  [Admin].[ST_User_Role_Module] ur
					   INNER JOIN [Admin].[ST_Users] u               ON u.Id=ur.UserId
					   INNER JOIN [Admin].[ST_User_RR_Credential] rr ON u.Id=rr.UserId
			     WHERE u.UserId=@OracleId 
				 AND   u.Active=1
				 END

	
 END TRY
BEGIN CATCH
   EXECUTE [dbo].[LogError]
   THROW
END CATCH
END



