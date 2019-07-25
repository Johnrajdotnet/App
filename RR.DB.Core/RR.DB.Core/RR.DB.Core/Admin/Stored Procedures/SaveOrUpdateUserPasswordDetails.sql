
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,> 
-- =============================================
CREATE PROCEDURE [Admin].[SaveOrUpdateUserPasswordDetails]
	-- Add the parameters for the stored procedure here
@newPassword nvarchar(50)
,@UserRoleId  uniqueidentifier
,@ServiceType int
AS
BEGIN
BEGIN TRY

	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
 
 Declare @UserId bigint,@passwordCheck nvarchar(50)

 select @UserId=UserId from [Admin].[ST_User_Role_Module] where Id=@UserRoleId
 select @passwordCheck=Password from [Admin].[ST_Users]  where Id=@UserId

  if(@ServiceType=1)  ---Application
	  begin
		 Update [Admin].[ST_Users]
		 set [Password] = @newPassword,
		      ModifiedDate=GETDATE()
		 where Id=@UserId
	   end

		
 END TRY
BEGIN CATCH
   EXECUTE [dbo].[LogError]
   THROW
END CATCH
END
