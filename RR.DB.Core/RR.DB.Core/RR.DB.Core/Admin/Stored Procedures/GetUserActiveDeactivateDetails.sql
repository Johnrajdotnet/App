-- =============================================
-- Author:		<Vyshna>
-- Create date: <Create Date,,>
-- Description:	<Get user active deactive details>
-- EXEC [Admin].[GetUserActiveDeactivateDetails]
-- ============================================= 

CREATE PROCEDURE [Admin].[GetUserActiveDeactivateDetails] 
       -- Add the parameters for the stored procedure here
AS
BEGIN
       -- SET NOCOUNT ON added to prevent extra result sets from
       -- interfering with SELECT statements.
       SET NOCOUNT ON;
 
    -- Insert statements for procedure here
       BEGIN TRY
       SELECT 
               FirstName+' '+LastName +'('+convert(nvarchar(10),u.UserId)+')' AS UserName,
               urm.Id     AS UserId,
               Active     AS Active
       FROM [Admin].[ST_Users] u
       INNER JOIN [Admin].[ST_User_Role_Module] urm ON urm.UserId=u.Id
 
       END TRY
 
       BEGIN CATCH
       EXECUTE [dbo].[LogError]
       END CATCH
END
 
