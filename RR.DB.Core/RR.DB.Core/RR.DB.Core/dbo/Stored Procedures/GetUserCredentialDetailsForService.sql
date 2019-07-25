
/****** Object:  StoredProcedure [dbo].[GetUserCredentialDetailsForService]    Script Date: 4/17/2018 5:58:27 PM ******/
-- =============================================
-- Author:           <NEETHU ROSE PETER>
-- Create date: <09,01,2018>
-- Description:      <SP TO Fetch USER CREDENTIALS>
-- EXEC [dbo].[GetUserCredentialDetailsForService] 1
-- =============================================
CREATE PROCEDURE [dbo].[GetUserCredentialDetailsForService] 
@serviceType int 
AS
BEGIN
       
       SET NOCOUNT ON;

       BEGIN TRY

	   IF (@serviceType = 1)

		BEGIN
		   SELECT 
				   a.Id             AS UserId,
				   a.UserId         AS OracleUserId,
				   a.EmailAddress   AS EmailId,
				   b.RRCareId       AS RRCareID,
				   b.RRCarePassword AS RRCarePassword,
				   b.CreatedDate    AS CreatedDate,
				   ur.Id            AS UserRoleId		   
	                
		   FROM   	        
				      [Admin].[ST_Users] a 
		   INNER JOIN [Admin].[ST_User_RR_Credential] b         ON a.Id=b.UserId 
		   INNER JOIN [Admin].[OT_User_RR_Credential_Active] c  ON b.Id=c.RRCredentialId 
		   INNER JOIN [Admin].[ST_User_Role_Module] ur          ON ur.UserId = a.Id 
		   WHERE   c.RRCredentialActive=1
       
       END

	   IF (@serviceType = 2)

	   BEGIN
	   SELECT 
				   a.Id             AS UserId,
				   a.UserId         AS OracleUserId,
				   a.EmailAddress   AS EmailId,
				   b.RRCareId       AS RRCareID,
				   b.RRCarePassword AS RRCarePassword,
				   b.CreatedDate    AS CreatedDate,
				   ur.Id            AS UserRoleId
	                
		   FROM   	        
				      [Admin].[ST_Users] a 
		   INNER JOIN [Admin].[ST_User_RR_Credential] b        ON a.Id=b.UserId 
		   INNER JOIN [Admin].[OT_User_RR_Credential_Active] c ON b.Id=c.RRCredentialId 
		   INNER JOIN [Admin].[ST_User_Role_Module] ur         ON ur.UserId = a.Id 
		   WHERE   c.RRCredentialActive=1 
		   AND     c.EDCActive=1
	   END
       END TRY

       BEGIN CATCH
              EXECUTE [dbo].[LogError]
   END CATCH
END


