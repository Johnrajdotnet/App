
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,> (select  [dbo].[GetDateDifferenceInDays] ('2017-03-07 00:00:00.000') )

-- Description:	<Description, ,> 2017-03-07 00:00:00.000
-- =============================================
CREATE FUNCTION [dbo].[GetDateDifferenceInDays] 
(
	-- Add the parameters for the function here
	@StartDate Datetime
)
RETURNS VARCHAR(250)
AS
BEGIN
	-- Total seconds in a day

DECLARE @TotalSec int
DECLARE @DiffSecs int
SET @TotalSec = 24*60*60; 

-- Convert DateDiff into seconds

SET @DiffSecs = DATEDIFF(SECOND, @Startdate, GETDATE()) 

--Declare @days int,@Hours int,@minutes int,@difference nvarchar(200)
Declare @days nvarchar(20),@Hours nvarchar(20),@minutes nvarchar(20),@difference nvarchar(200)
Set @days = CONVERT(char(2), (@DiffSecs/@TotalSec))
Set @Hours =CONVERT(char(2), ((@DiffSecs%@TotalSec)/3600))
Set @minutes =CONVERT(char(2), (((@DiffSecs%@TotalSec)%3600)/60))


--Set @difference= CONCAT ( @days,'Days',' ',@Hours,'Hrs',' ',@minutes,'Min')  
Set @difference= @days + 'Days' + ' ' + @Hours + 'Hrs' + ' ' + @minutes + 'Min' 
    RETURN @difference

END
GO


