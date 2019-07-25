
-- =============================================
-- Author:		<Neethu>
-- Create date: <Create Date,,>
-- Description:	<get child user details of current parent- Role Configuration>
-- =============================================  [Admin].[GetUserDetails] 1,''

CREATE PROCEDURE [Admin].[GetUserDetails] 
	-- Add the parameters for the stored procedure here
 @LoginUserRoleId bigint,
 @LoginUserProgram nvarchar(200)
AS
BEGIN
	CREATE TABLE #tempTable(programId int)  
	DECLARE @AMSCount int=0,@MECount int=0,@roleLevelId int

	SET NOCOUNT ON;

	SET @roleLevelId=(SELECT RoleLevel from [Admin].[ST_Roles] where Id=@LoginUserRoleId)
    -- Insert statements for procedure here
	IF(@LoginUserProgram ='')
	BEGIN
		SELECT 
			  u.UserId                   AS UserId,
			  u.FirstName+' '+u.LastName AS UserName,
			  rm.RoleId                  AS RoleId,
			  rm.BusinessModuleId        AS BusinessId,
			  rm.ProgramId               AS ProgramId

		FROM       [Admin].[ST_Users] u
		INNER JOIN [Admin].[ST_User_Role_Module] rm ON u.Id=rm.UserId
		INNER JOIN [Admin].[ST_Roles] r             ON r.Id=rm.RoleId
	    WHERE  r.Active=1 
		 AND   r.RoleLevel > @roleLevelId 
		 AND   u.Active='TRUE'  
		 ORDER BY UserName ASC
	END
	ELSE
	BEGIN
	
		INSERT INTO #tempTable(programId)  
		SELECT CAST(Item as int) FROM [dbo].[StringToTableValue] (@LoginUserProgram,',')

		SET @AMSCount=(SELECT COUNT(*) FROM #tempTable where programId<=100)
		SET @MECount=(SELECT COUNT(*) FROM #tempTable where programId>100 )

		IF(@AMSCount>0)
		BEGIN
				SELECT 
					u.UserId                   AS UserId,
					u.FirstName+' '+u.LastName AS UserName,
					rm.RoleId                  AS RoleId,
					rm.BusinessModuleId        AS BusinessId,
					rm.ProgramId               AS ProgramId

				FROM [Admin].[ST_Users] u
				INNER JOIN [Admin].[ST_User_Role_Module] rm ON u.Id=rm.UserId
				INNER JOIN [Admin].[ST_Roles] r             ON r.Id=rm.RoleId
				WHERE r.RoleLevel > @roleLevelId 
				AND   u.Active='TRUE' 
				AND   r.Active=1 
				AND ((SELECT top 1 CAST(Item as int) FROM [dbo].[StringToTableValue] (rm.ProgramId ,',')) <=100  OR rm.ProgramId is null)
				ORDER BY UserName ASC 
				
			
		END
		ELSE IF(@MECount>0)
		BEGIN
		SELECT 
					u.UserId                   AS UserId,
					u.FirstName+' '+u.LastName AS UserName,
					rm.RoleId                  AS RoleId,
					rm.BusinessModuleId        AS BusinessId,
					rm.ProgramId               AS ProgramId

				FROM [Admin].[ST_Users] u
				INNER JOIN [Admin].[ST_User_Role_Module] rm ON u.Id=rm.UserId
				INNER JOIN [Admin].[ST_Roles] r             ON r.Id=rm.RoleId
				WHERE r.RoleLevel > @roleLevelId 
				AND u.Active='TRUE' 
				AND r.Active=1
				AND ((SELECT top 1 CAST(Item as int) FROM [dbo].[StringToTableValue] (rm.ProgramId ,',')) >100  OR rm.ProgramId is null)
				ORDER BY UserName ASC 
		
		END

	END

END



