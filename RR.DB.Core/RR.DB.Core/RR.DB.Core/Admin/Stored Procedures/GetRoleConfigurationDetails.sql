
-- =============================================
-- Author:		<Neethu>
-- Create date: <28/5/2018>
-- Description:	<Return the Program Details/Business details based on flag for Role Configuration,>
-- ============================================= [Admin].[GetRoleConfigurationDetails] 'UserRoleProgramList',NULL,2

CREATE PROCEDURE [Admin].[GetRoleConfigurationDetails] 
	-- Add the parameters for the stored procedure here
 @flag nvarchar(50),
 @loginUserProgramId nvarchar(200)=null,
 @selectedUserRoleLevelId int
 --@loginUserRoleLevelId int

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

   BEGIN TRY

		 IF(@flag='UserRoleProgramList')
		 BEGIN
			  
		 ;WITH ListProgram
			AS
			(
			SELECT        p.Id, p.ProgramName,
			              p.RoleLevel,
						  p.MenuId,
						  p.Description,
						  p.SubMenuId
			FROM 
						  [Admin].[ST_Program_Details] p
			WHERE         ISNULL(p.ParentId,-1) in (SELECT Item FROM [dbo].[StringToTableValue] (ISNULL(@loginUserProgramId,-1),',')) 	
			UNION ALL
			SELECT        p.Id,p.ProgramName,
			              p.RoleLevel,
						  p.MenuId,
						  p.Description,
						  p.SubMenuId
			FROM 
						  [Admin].[ST_Program_Details] p
			INNER JOIN    ListProgram m ON m.Id=p.ParentId
			)

			SELECT        lp.Id           AS Id, 
				          lp.ProgramName  AS ProgramName,
				          lp.RoleLevel    AS RoleLevel,
				          p.[Description] AS ProgramTitle,
				          lp.Description  AS [Description],
				          lp.SubMenuId    AS SubMenuId  

			FROM          ListProgram lp 
			INNER JOIN    [Admin].[ST_Program_Details] p ON p.Id=isnull(lp.MenuId,lp.Id)
			WHERE         lp.RoleLevel= (@selectedUserRoleLevelId) 
			ORDER BY      lp.Id,lp.RoleLevel ASC
		 END

   END TRY
   BEGIN CATCH
   EXECUTE [dbo].[LogError]
   END CATCH

	
END