
-- =============================================
-- Author:           John Raj
-- Create date: 25/10/2017
-- Description:      Get Engineer full name by role Guid
-- =============================================
CREATE FUNCTION [dbo].[GetEngineerNameByRoleGuid] 
(
       -- Add the parameters for the function here
       @roleGuid uniqueidentifier
)
RETURNS NVARCHAR(200)
AS
BEGIN
       -- Declare the return variable here
       DECLARE @EngineerFullName NVARCHAR(200)

       -- Add the T-SQL statements to compute the return value here
       SELECT @EngineerFullName = CONCAT(u.FirstName,' ',u.LastName) FROM Admin.ST_Users u
       INNER JOIN Admin.ST_User_Role_Module rm ON rm.UserId=u.Id
       WHERE rm.Id=@roleGuid AND u.Active=1

       -- Return the result of the function
       RETURN @EngineerFullName

END
