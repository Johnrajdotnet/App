

-- =============================================
-- Author:      John Raj
-- Create date: 07/12/2017
-- Description: String into Table Record
-- =============================================

CREATE FUNCTION [dbo].[StringToTableValue] 
(          
    @string VARCHAR(MAX),
    @delimiter CHAR(1)
)
RETURNS @output TABLE(
    Item VARCHAR(256)
) 
BEGIN
       -- Add the SELECT statement with parameter references here
       DECLARE @start INT, @end INT
    SELECT @start = 1, @end = CHARINDEX(@delimiter, @string)

    WHILE @start < LEN(@string) + 1 BEGIN
        IF @end = 0 
            SET @end = LEN(@string) + 1

        INSERT INTO @output (Item) 
        VALUES(SUBSTRING(@string, @start, @end - @start))
        SET @start = @end + 1
        SET @end = CHARINDEX(@delimiter, @string, @start)
    END

    RETURN
END

GO