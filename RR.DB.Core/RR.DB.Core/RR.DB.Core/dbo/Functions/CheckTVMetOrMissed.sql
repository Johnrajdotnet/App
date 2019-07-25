-- =============================================
-- Author:           <John Raj>
-- Create date: 12 June 2018
-- Description: Check MET or MISSED TV
-- Version 1.6 change in requirement
-- [dbo].[CheckTVMetOrMissed] ('2013-04-03 00:00:00.000','SERVICE','2018-12-03 00:00:00.000','2','-RPN-',17,'A')
-- [dbo].[CheckTVMetOrMissed] ('2013-04-03 00:00:00.000','SERVICE','2018-11-03 00:00:00.000','1','-FFG-',1,'N')
--declare @dateIn datetime=cast('2013-04-03 00:00:00.000' as datetime)
--declare @dateIn1 datetime=cast('2013-04-03 00:00:00.000' as datetime)
--print  [dbo].[CheckTVMetOrMissed1] (@dateIn,'SERVICE',@dateIn1,'1','-FFG-',1,'N')
-- =============================================
CREATE FUNCTION [dbo].[CheckTVMetOrMissed] 
(
       -- Add the parameters for the function here
       @dateIn Datetime,
       @tvType nvarchar(30),
       @validateDate Datetime,
	   @category nvarchar(MAX),
	   @team	nvarchar(200),
	   @StatusSeqCode int,
       @statusFlag   char(5)      
)
RETURNS VARCHAR(250)
AS
BEGIN
       DECLARE @status VARCHAR(250)=''
       DECLARE @HeadDays DATETIME
	   DECLARE @dueDays INT
       --SET @diffDays=DATEDIFF(DAY,@dateIn,GETDATE())
       -------------------HeadUP
       IF(@statusFlag='H' OR @statusFlag='N')
       BEGIN

			  --print @dueDays
			  --NON RPN
			  IF(CHARINDEX('RPN', ISNULL(@team,''))<=0 AND @StatusSeqCode<=7)
			  BEGIN
			  			  --@validateDate-headdUpDate
					  SET @HeadDays= DATEADD(DD,5,@dateIn)
					  SET @dueDays=DATEDIFF(DAY,GETDATE(),@HeadDays)	
					  --By @dateIn
					  IF(@dueDays <0)
					  BEGIN
							 SET @status='MISSED'
					  END
					  IF(@dueDays>=0 AND @dueDays <=3)--0 to 3 days left at risk
					  BEGIN
							 SET @status='RISK'
					  END
					  IF(@dueDays>3) -- due days=4 and 5 days left 
					  BEGIN
							 SET @status='ONTRACK'
					  END					
			  END									
			  --RPN NON CRT
			  IF(CHARINDEX('RPN', ISNULL(@team,''))>0 AND ( @category='2' OR CHARINDEX('CRT', ISNULL(@category,'') )<=0 )
				AND @StatusSeqCode<=7)
			  BEGIN
			  		  SET @HeadDays= DATEADD(DD,10,@dateIn)
					  SET @dueDays=DATEDIFF(DAY,GETDATE(),@HeadDays)
					  --By @dateIn
					  IF(@dueDays <0)
					  BEGIN
							 SET @status='MISSED'
					  END
					  IF(@dueDays>=0 AND @dueDays <=6)--0 to 6 days left at risk
					  BEGIN
							 SET @status='RISK'
					  END
					  IF(@dueDays>6) -- due days=above 6- 10 left
					  BEGIN
							 SET @status='ONTRACK'
					  END					
			  END	
			  				  		       
       END
       -------------------Draft Service
       IF(@statusFlag='D' AND @tvType='SERVICE')
       BEGIN
			  
			  --NON RPN AND CRT AND Seq 10 to 12
			  IF(CHARINDEX('RPN', ISNULL(@team,''))<=0 AND  
			  (@StatusSeqCode=8 OR @StatusSeqCode=14 OR (@StatusSeqCode>=10 AND @StatusSeqCode<=12))
			  )
			  BEGIN
					  --@validateDate- if CRT -CUSTOMER REQUIRED DATE
					  --@validateDate- if NON CRT -RR PROMISE DATE					  
					  SET @dueDays=DATEDIFF(DAY,GETDATE(),DATEADD(DD,15,@dateIn))	
					  
					  IF(@dueDays <0)
					  BEGIN
							 SET @status='MISSED'
					  END
					  IF(@dueDays>=0 AND @dueDays <=6)--0 to 6 days left at risk
					  BEGIN
							 SET @status='RISK'
					  END
					  IF(@dueDays>6) --more than 6 days left
					  BEGIN
							 SET @status='ONTRACK'
					  END					
			  END	

			  --RPN AND NON CRT AND Seq 10 to 12
			  IF(CHARINDEX('RPN', ISNULL(@team,''))>0 AND ( @category='2' OR CHARINDEX('CRT', ISNULL(@category,'') )<=0 )
				AND (@StatusSeqCode=8 OR @StatusSeqCode=14 OR (@StatusSeqCode>=10 AND @StatusSeqCode<=12)))
			  BEGIN
					  --@validateDate- if NON CRT -RR PROMISE DATE
					  SET @dueDays=DATEDIFF(DAY,GETDATE(),DATEADD(DD,36,@dateIn))	
					 
					  IF(@dueDays <0)
					  BEGIN
							 SET @status='MISSED'
					  END
					  IF(@dueDays>=0 AND @dueDays <=6)--0 to 6 days left at risk
					  BEGIN
							 SET @status='RISK'
					  END
					  IF(@dueDays>6) --more than 6 days left
					  BEGIN
							 SET @status='ONTRACK'
					  END					
			  END	             
			                
       END
       -------------------Draft REPAIR
       IF(@statusFlag='D' AND @tvType='REPAIR')
       BEGIN
			  --NON RPN AND CRT AND Seq 10 to 12
			  IF(CHARINDEX('RPN', ISNULL(@team,''))<=0 AND  
			  (@StatusSeqCode=8 OR @StatusSeqCode=14 OR(@StatusSeqCode>=10 AND @StatusSeqCode<=12))
			  )
			  BEGIN
					  --@validateDate- if CRT -CUSTOMER REQUIRED DATE
					  --@validateDate- if NON CRT -RR PROMISE DATE
					  SET @dueDays=DATEDIFF(DAY,GETDATE(),DATEADD(DD,18,@dateIn))	
					  
					  IF(@dueDays <0)
					  BEGIN
							 SET @status='MISSED'
					  END
					  IF(@dueDays>=0 AND @dueDays <=7)--0 to 7 days left at risk
					  BEGIN
							 SET @status='RISK'
					  END
					  IF(@dueDays>7) --more than 7 days left
					  BEGIN
							 SET @status='ONTRACK'
					  END					
			  END	

			  --RPN AND NON CRT AND Seq 10 to 12
			  IF(CHARINDEX('RPN', ISNULL(@team,''))>0 AND ( @category='2' OR CHARINDEX('CRT', ISNULL(@category,'') )<=0 )
					AND (@StatusSeqCode=8 OR @StatusSeqCode=14 OR (@StatusSeqCode>=10 AND @StatusSeqCode<=12))
				)
			  BEGIN
					  --@validateDate- if NON CRT -RR PROMISE DATE
					  SET @dueDays=DATEDIFF(DAY,GETDATE(),DATEADD(DD,36,@dateIn))	
					 
					  IF(@dueDays <0)
					  BEGIN
							 SET @status='MISSED'
					  END
					  IF(@dueDays>=0 AND @dueDays <=7)--0 to 7 days left at risk
					  BEGIN
							 SET @status='RISK'
					  END
					  IF(@dueDays>7)--more than 7 days left
					  BEGIN
							 SET @status='ONTRACK'
					  END					
			  END	                  
       END
       -------------------Approve Service
       IF(@statusFlag='A' AND @tvType='SERVICE')
       BEGIN
			  
			  --NON RPN AND CRT AND Seq 13 to 20
			  IF(CHARINDEX('RPN', ISNULL(@team,''))<=0 AND  (@StatusSeqCode=13 OR (@StatusSeqCode>=15 AND @StatusSeqCode<=19)))
			  BEGIN
					  --@validateDate- if CRT -CUSTOMER REQUIRED DATE
					  --@validateDate- if NON CRT -RR PROMISE DATE
					  SET @dueDays=DATEDIFF(DAY,GETDATE(),DATEADD(DD,20,@dateIn))	
					  
					  IF(@dueDays <0)
					  BEGIN
							 SET @status='MISSED'
					  END
					  IF(@dueDays>=0 AND @dueDays <=2)--0 to 2 days left at risk
					  BEGIN
							 SET @status='RISK'
					  END
					  IF(@dueDays>2)--more than 2 days left
					  BEGIN
							 SET @status='ONTRACK'
					  END					
			  END	

			  --RPN AND NON CRT AND Seq 13 to 20
			  IF(CHARINDEX('RPN', ISNULL(@team,''))>0 AND ( @category='2' OR CHARINDEX('CRT', ISNULL(@category,'') )<=0 )
					AND (@StatusSeqCode=13 OR (@StatusSeqCode>=15 AND @StatusSeqCode<=19))
				)
			  BEGIN
					  --@validateDate- if NON CRT -RR PROMISE DATE
					  SET @dueDays=DATEDIFF(DAY,GETDATE(),DATEADD(DD,55,@dateIn))	
					 
					  IF(@dueDays <0)
					  BEGIN
							 SET @status='MISSED'
					  END
					  IF(@dueDays>=0 AND @dueDays <=9)--0 to 9 days left at risk
					  BEGIN
							 SET @status='RISK'
					  END
					  IF(@dueDays>9)--more than 9 days left
					  BEGIN
							 SET @status='ONTRACK'
					  END					
			  END	             
			                
       END
	    -------------------Approve REPAIR
	   IF(@statusFlag='A' AND @tvType='REPAIR')
       BEGIN
			  --NON RPN AND CRT AND Seq 13 to 20
			  IF(CHARINDEX('RPN', ISNULL(@team,''))<=0 AND  (@StatusSeqCode=13 OR (@StatusSeqCode>=15 AND @StatusSeqCode<=19)))
			  BEGIN
					  --@validateDate- if CRT -CUSTOMER REQUIRED DATE
					  --@validateDate- if NON CRT -RR PROMISE DATE
					  SET @dueDays=DATEDIFF(DAY,GETDATE(),DATEADD(DD,20,@dateIn))	
					  
					  IF(@dueDays <0)
					  BEGIN
							 SET @status='MISSED'
					  END
					  IF(@dueDays>=0 AND @dueDays <=2)--0 to 2 days left at risk
					  BEGIN
							 SET @status='RISK'
					  END
					  IF(@dueDays>2)--more than 2 days left
					  BEGIN
							 SET @status='ONTRACK'
					  END					
			  END	

			  --RPN AND NON CRT AND Seq 13 to 20
			  IF(CHARINDEX('RPN', ISNULL(@team,''))>0 AND (@category='2' OR CHARINDEX('CRT', ISNULL(@category,'') )<=0 )
					AND (@StatusSeqCode=13 OR (@StatusSeqCode>=15 AND @StatusSeqCode<=19))
				)
			  BEGIN
					  --@validateDate- if NON CRT -RR PROMISE DATE
					  SET @dueDays=DATEDIFF(DAY,GETDATE(),DATEADD(DD,55,@dateIn))	
					 
					  IF(@dueDays <0)
					  BEGIN
							 SET @status='MISSED'
					  END
					  IF(@dueDays>=0 AND @dueDays <=9)
					  BEGIN
							 SET @status='RISK'
					  END
					  IF(@dueDays>9)--more than 9 days left
					  BEGIN
							 SET @status='ONTRACK'
					  END					
			  END	                  
       END


    RETURN @status

END