
-- =============================================
-- Author:       Mira Kumari
-- Create date: 24/07/2018
-- Description:      Get the Parent or Manager Level  from bottom to top
--select * from [GetAllSPCDetailsByProgram]('9',null)
-- =============================================
CREATE FUNCTION [dbo].[GetAllSPCDetailsByProgram]
(
       -- Add the parameters for the function here
       @programList nvarchar(20),
       @managerRankLevel nvarchar(20)
)
RETURNS
@ManagerProgramList TABLE
(
       -- Add the column definitions for the TABLE variable here
       UserId INT,
       FirstName NVARCHAR(50),
       EmailId NVARCHAR(50),
       RoleLevelId INT
)
AS
BEGIN
       -- Fill the table variable with the rows for your result set
      
              DECLARE @mangerProgram TABLE (ManagerProgramId INT, ManagerProgram NVARCHAR(200),ParentId INT, RoleLevel INT,MenuId INT)
              DECLARE @mangerProgramRank TABLE (UserId INT, FirstName NVARCHAR(200),EmailId NVARCHAR(50), RoleLevelId INT)
 
              ;with aaList as
              (
 
              SELECT        p.Id as ManagerProgramId, p.ProgramName as ManagerProgram,p.ParentId as ParentId , p.RoleLevel as RoleLevel,p.MenuId as MenuId
              FROM
                                    [Admin].[ST_Program_Details] p
              WHERE         ISNULL(p.Id,-1) in (SELECT Item FROM [dbo].[StringToTableValue] (@programList,','))              
 
              UNION ALL
 
              SELECT        p.Id as ManagerProgramId, p.ProgramName as ManagerProgram,p.ParentId as ParentId , p.RoleLevel as RoleLevel,p.MenuId as MenuId
              FROM
                                    [Admin].[ST_Program_Details] p
              INNER JOIN    aaList l ON l.ParentId=p.Id
              )
              INSERT @mangerProgram
              SELECT * FROM aaList WHERE ManagerProgramId  IN (SELECT Item FROM [dbo].[StringToTableValue] (@programList,','))
              GROUP BY ManagerProgramId, ManagerProgram,ParentId, RoleLevel,MenuId
 
              INSERT @mangerProgramRank
              SELECT DISTINCT UserId,FirstName,EmailAddress,p.RoleId FROM (
                     SELECT    p.UserRoleId,p.ProgramId,p.UserId,p.RoleId,u.FirstName,u.EmailAddress
                     FROM      [dbo].[GetAllUserListByProgramList](null) p
                     INNER JOIN [Admin].[ST_Users] u ON u.Id=p.UserId
                     WHERE u.Active=1
                     AND   p.ProgramId  IN (SELECT ManagerProgramId FROM @mangerProgram)
                     AND      p.RoleId IN (SELECT RoleLevel FROM @mangerProgram)
              )p
 
              INSERT @ManagerProgramList
              SELECT UserId,FirstName,EmailId,RoleLevelId FROM (
              SELECT UserId,FirstName,EmailId,RoleLevelId,DENSE_RANK() OVER (ORDER BY RoleLevelId DESC) AS xRank FROM @mangerProgramRank
              )p
              WHERE p.xRank IN (SELECT Item FROM [dbo].[StringToTableValue] (ISNULL(@managerRankLevel,p.xRank),','))
 
       RETURN
END