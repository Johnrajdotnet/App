
-- =============================================
-- Author:		<Anupa>
-- Create date: <10-04-2017>
-- Description:	<To get the businessModulename correspondimng to Ids>
-- =============================================
create PROCEDURE [Admin].[GetBusinessNameByBusinessId] --'1,16'
	@Ids Varchar (8000)
AS
BEGIN
	SELECT BusinessName FROM [Admin].ST_Business_Module 
    WHERE Id IN (select * from [dbo].[StringToTableValue] (@Ids,','))
END
