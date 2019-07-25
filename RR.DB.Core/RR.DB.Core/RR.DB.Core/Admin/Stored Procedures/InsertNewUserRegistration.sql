-- =============================================
--PROCEDURE: [Admin]].[InsertNewUserRegistration] 
--PURPOSE: Insert new user data to Admin].[ST_Users]
--CREATED: Neethu 07/04/2017
-- ============================================= 
-- EXEC [Admin].[InsertNewUserRegistration] 1,'a','a','a','a',4,'hFqQgi5NkHLdjtOAAhlcMg==','neethu.peter@quest-global.com','12/5/2017 12:00:00 AM','a','hFqQgi5NkHLdjtOAAhlcMg=='

CREATE PROCEDURE [Admin].[InsertNewUserRegistration]
	@userId             int,
	@rrCareUsername     nvarchar(250),  
	@firstname          nvarchar(250), 
	@middlename         nvarchar(250), 
	@lastname           nvarchar(250), 
	@role               int,
	@password           nvarchar(250), 
	@email              nvarchar(250),
	@dob                date,
	@outflag            BIT OUTPUT
	--@rrCareId nvarchar(250), 
	--@rrCarePassword nvarchar(250) 

AS
BEGIN
DECLARE @userIdentity bigint,@alreadyregistered bigint,@rrCareIdentity bigint,@UserRoleModuleId uniqueidentifier

DECLARE @NewRoleModuleTable table([NewRoleModuleId] [uniqueidentifier]);
BEGIN TRY

SET @alreadyregistered=(select count(*) from [Admin].[ST_Users] where UserId=@userId)

IF(@alreadyregistered=0)
		BEGIN
	  ---------------- Insert to User Details Table -------------------------------                
				  INSERT INTO [Admin].[ST_Users]
						 (
							 UserId,
							 RRCareUserName,
							 FirstName,
							 MiddleName,
							 LastName,
							 Password,
							 EmailAddress,
							 ExpiryDate,
							 DateOfBirth,
							 Active
						 )
				  SELECT
							 @userId,
							 @rrCareUsername,
							 @firstname,
							 @middlename,
							 @lastname,
							 @password,
							 @email,
							 Getdate()+30,
							 @dob,
							 1
                                  
				   SET @userIdentity = SCOPE_IDENTITY()   
	   
				   INSERT INTO [Admin].[ST_User_Role_Module]
						 (
							 UserId,
							 RoleId,
							 BusinessModuleId
						 )
				   OUTPUT    INSERTED.Id INTO @NewRoleModuleTable
				   SELECT 
							 @userIdentity,
							 @role,
							 NULL

				  SELECT @UserRoleModuleId = NewRoleModuleId FROM @NewRoleModuleTable  	
				  SELECT @UserRoleModuleId
				  ------ Insert [RTMS.DB.App].LinkDB.LT_ST_User_Role_Module table
	                
				  EXEC [Admin].InsertDBLinkObject @UserRoleModuleId,1,'NewUser'
       
				  SELECT  @outflag=1
		END
	ELSE
		BEGIN 
		 SELECT  @outflag=null--already exist
		END 
END TRY
BEGIN CATCH
   SELECT  @outflag=0--error
   EXECUTE [dbo].[LogError]
END CATCH
END
