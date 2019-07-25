
-- =============================================
-- Author:		<Anupa>
-- Create date: <14-08-2017>
-- Description:	<Activate/Deactivate User/Services>
-- =============================================
CREATE PROCEDURE [Admin].[GetActiveOrDeActiveDetails]--'SErvices','Init','1007939'
	-- Add the parameters for the stored procedure here
	@flag varchar(50),
	@typetoLoad varchar(50),
	@userId int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.

	DECLARE @Id bigint
	SELECT @Id = Id FROM Admin.ST_Users WHERE UserId= @userId
	SET NOCOUNT ON;

	IF(@typetoLoad = 'Init' AND @flag = 'Application')

	   BEGIN
	  --Object activate or deactivate
		SELECT  Active AS UserStatus,
		        UserId AS OracleId 
		FROM Admin.ST_Users
		--WHERE UserId= @userId
	   END
	ELSE IF(@typetoLoad = 'DDL' AND @flag = 'Application')

		BEGIN

				SELECT  u.UserId                    AS DDLValue , 
				        u.FirstName+' '+u.LastName  AS DDLText 
			    FROM [Admin].[ST_Users] u
				INNER JOIN [Admin].[ST_User_Role_Module] rm ON u.Id=rm.UserId ORDER BY u.FirstName+' '+u.LastName ASC
		END
END
