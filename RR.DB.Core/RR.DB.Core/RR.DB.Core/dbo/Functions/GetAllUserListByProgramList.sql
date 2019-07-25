-- =============================================
-- Author:		John Raj
-- Create date: 24/07/2018
-- Description:	Get the Role User List By ProgramIdList 
--select * from GetAllUserListByProgramList()
-- =============================================
CREATE FUNCTION [dbo].[GetAllUserListByProgramList]
(
	-- Add the parameters for the function here
	@programList nvarchar(20)=null
)
RETURNS 
@ProgramUserRoleList TABLE 
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

		IF(LEN(ISNULL(@programList,''))=0)
		BEGIN
			INSERT INTO @ProgramUserRoleList
			SELECT rm.Id as UserRoleId,p.Item as ProgramId,rm.UserId as UserId,rm.RoleId as RoleId 
			FROM [Admin].[ST_User_Role_Module]  rm
			CROSS APPLY [dbo].[StringToTableValue] (rm.ProgramId,',') p	
		END
		ELSE
		BEGIN
			INSERT INTO @ProgramUserRoleList
			SELECT rm.Id as UserRoleId,CAST(p.Item as INT) as ProgramId,rm.UserId as UserId,rm.RoleId as RoleId 
			FROM [Admin].[ST_User_Role_Module]  rm
			CROSS APPLY [dbo].[StringToTableValue] (rm.ProgramId,',') p
			WHERE p.Item IN (SELECT Item FROM [dbo].[StringToTableValue] (@programList,','))
		END
	RETURN 
END