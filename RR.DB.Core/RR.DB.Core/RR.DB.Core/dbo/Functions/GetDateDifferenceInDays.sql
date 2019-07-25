

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,> (select  [dbo].[GetDateDifferenceInDays] ('2017-03-07 00:00:00.000') )
-- Description:	<Description, ,> 2017-03-07 00:00:00.000
-- select [dbo].[GetDateDifferenceInDays] (GETDATE())
-- Version 1.1
-- =============================================
CREATE FUNCTION [dbo].[GetDateDifferenceInDays] 
(
	-- Add the parameters for the function here
	@StartDate Datetime,
	@actionFlag nvarchar(10)
)
RETURNS VARCHAR(250)
AS
BEGIN
		-- Total seconds in a day

		DECLARE @TotalSec int
		DECLARE @DiffSecs int
		SET @TotalSec = 24*60*60; 

		IF(@actionFlag='DAYSHHMM')
		BEGIN
			-- Convert DateDiff into seconds

			SET @DiffSecs = DATEDIFF(SECOND, @StartDate, GETDATE()) 

			--Declare @days int,@Hours int,@minutes int,@difference nvarchar(200)
			Declare @days nvarchar(20),@Hours nvarchar(20),@minutes nvarchar(20),@difference nvarchar(200)
			Set @days = CONVERT(char(10), (@DiffSecs/@TotalSec))
			Set @Hours =CONVERT(char(2), ((@DiffSecs%@TotalSec)/3600))
			Set @minutes =CONVERT(char(2), (((@DiffSecs%@TotalSec)%3600)/60))

			Set @difference= @days + 'Days' + ' ' + @Hours + 'Hrs' + ' ' + @minutes + 'Min' 
		END
		ELSE IF (@actionFlag='DAYS')
		BEGIN

			Set @difference =DATEDIFF(DAY,@StartDate,GETDATE())
		END
		RETURN @difference

END

