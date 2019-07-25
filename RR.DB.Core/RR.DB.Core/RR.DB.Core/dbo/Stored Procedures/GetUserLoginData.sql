
-- =============================================
-- Author:           <Neethu>
-- Create date: <20/03/2017>
-- Description:      <Retrives User Login Data>
-- ============================================= [dbo].[GetUserLoginData] 1000001,'YW6t5xNtnRO9wZS+5sttdw=='
CREATE PROCEDURE [dbo].[GetUserLoginData]

       @OracleId int,
       @password nvarchar(250)
AS
BEGIN
       Select ur.Id  AS [UserRoleId],  
       ur.RoleId     AS [RoleId],
       isnull(ur.BusinessModuleId,'') AS BusinessModule,
	   u.FirstName   AS [FirstName],
	   u.LastName    AS [LastName],
	   [dbo].[GetMenuOrSubmenuByProgram](ur.ProgramId,'Menu')    AS MenuModule,
	   [dbo].[GetMenuOrSubmenuByProgram](ur.ProgramId,'SubMenu') AS SubMenuModule,
	   isnull(ur.ProgramId,'')      AS ProgramModule

       FROM       [Admin].[ST_User_Role_Module] ur
       INNER JOIN [Admin].[ST_Users] u ON u.Id=ur.UserId
       WHERE u.UserId=@OracleId 
	   AND   u.Password=@password  COLLATE SQL_Latin1_General_CP1_CS_AS  and u.Active=1
END