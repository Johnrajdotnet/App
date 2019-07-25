-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[ConvertDateFormatIntToDateTime]
(
	-- Add the parameters for the function here
	@datein int
)
RETURNS datetime 
AS
BEGIN
	-- Declare the return variable here
	DECLARE @dateOut datetime

	IF(@datein IS NOT NULL)
	BEGIN
		SET @dateOut=CAST(@datein -2 as SmallDateTime) 
	END
	ELSE
	BEGIN

		SET @dateOut=@datein
	END

	-- Return the result of the function
	RETURN @dateOut

END
