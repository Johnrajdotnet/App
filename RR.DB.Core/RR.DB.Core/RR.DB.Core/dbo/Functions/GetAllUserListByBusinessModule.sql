-- =============================================
-- Author:		John Raj
-- Create date: 24/07/2018
-- Description:	Get the Role User List By BusinessModuleId 
--select * from GetAllUserListByBusinessModule1('1,2')
-- =============================================
CREATE FUNCTION [dbo].[GetAllUserListByBusinessModule]
(
	-- Add the parameters for the function here
	@businessModuleList nvarchar(20)=null
)
RETURNS 
@BusinessModuleUserRoleList TABLE 
(
	-- Add the column definitions for the TABLE variable here
	UserRoleId	UNIQUEIDENTIFIER,
	ProgramId INT, 
	UserId INT,
	RoleId INT
)
AS
BEGIN
	-- Fill the table variable with the rows for your result set

		IF(LEN(ISNULL(@businessModuleList,''))=0)
		BEGIN
			INSERT INTO @BusinessModuleUserRoleList
			SELECT rm.Id as UserRoleId,p.Item as ProgramId,rm.UserId as UserId,rm.RoleId as RoleId 
			FROM [Admin].[ST_User_Role_Module]  rm
			CROSS APPLY [dbo].[StringToTableValue] (rm.BusinessModuleId,',') p	
		END
		ELSE
		BEGIN
			INSERT INTO @BusinessModuleUserRoleList
			SELECT rm.Id as UserRoleId,CAST(p.Item as INT) as ProgramId,rm.UserId as UserId,rm.RoleId as RoleId 
			FROM [Admin].[ST_User_Role_Module]  rm
			CROSS APPLY [dbo].[StringToTableValue] (rm.BusinessModuleId,',') p
			WHERE p.Item IN (SELECT Item FROM [dbo].[StringToTableValue] (@businessModuleList,','))
		END
	RETURN 
END
