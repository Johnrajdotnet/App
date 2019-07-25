
-- =============================================
-- Author:           <John Raj>
-- Create date: 12 June 2018
-- Description: Check MET or MISSED TV
-- [dbo].[CheckTVMetOrMissedForRBody]  ('2013-04-03 00:00:00.000','SERVICE','2013-04-04 00:00:00.000','1','H')
-- =============================================
CREATE FUNCTION [dbo].[CheckTVMetOrMissedForRBody] 
(
       -- Add the parameters for the function here
       @dateIn Datetime,
       @tvType nvarchar(30),
       @validateDate Datetime,
	   @category nvarchar(MAX),
       @statusFlag   char(5)      
)
RETURNS VARCHAR(250)
AS
BEGIN
       DECLARE @status VARCHAR(250)=''
       DECLARE @diffDays INT
	   DECLARE @actualDays INT
       SET @diffDays=DATEDIFF(DAY,@dateIn,GETDATE())
       -------------------HeadUP
       IF(@statusFlag='H')
       BEGIN
			  --@validateDate-headdUpDate
			  SET @actualDays=DATEDIFF(DAY,@dateIn,@validateDate)				  
			  --By @dateIn
              IF(@diffDays >5 AND @validateDate is null)
              BEGIN
                     SET @status='MISSED'
              END
              IF(@diffDays<=5 AND @validateDate is null)
              BEGIN
                     SET @status='RISK'
              END

			  --By @actualDays
              IF(@actualDays<=5 AND @validateDate is not null)
              BEGIN
                     SET @status='MET'
              END      
              IF(@actualDays>5 AND @validateDate is not null)
              BEGIN
                     SET @status='MISSED'
              END			       
       END
       -------------------Draft Service
       IF(@statusFlag='D' AND @tvType='SERVICE')
       BEGIN
			  --@validateDate-Inital PRE/CVE IN
			  SET @actualDays=DATEDIFF(DAY,@dateIn,@validateDate)				  
			  --By @dateIn
              IF(@diffDays>10 AND @validateDate is null)
              BEGIN
                     SET @status='MISSED'
              END
              IF((@diffDays >=7 AND @diffDays<=10) AND @validateDate is null)
              BEGIN
                     SET @status='RISK'
              END
			   IF(@diffDays<=10 AND @validateDate is null)
              BEGIN
                     SET @status='YTD'
              END


			   --By @actualDays
              IF(@actualDays <=10 AND @validateDate is not null)
              BEGIN
                     SET @status='MET'
              END    
              IF(@actualDays >10 AND @validateDate is not null)
              BEGIN
                     SET @status='MISSED'
              END                  
			                
       END
       -------------------Draft REPAIR
       IF(@statusFlag='D' AND @tvType='REPAIR')
       BEGIN
			  --@validateDate-Inital PRE/CVE IN
			  SET @actualDays=DATEDIFF(DAY,@dateIn,@validateDate)				  
			  --By @dateIn
              IF(@diffDays>13 AND @validateDate is null)
              BEGIN
                     SET @status='MISSED'
              END
              IF((@diffDays >=7 AND @diffDays<=13) AND @validateDate is null)
              BEGIN
                     SET @status='RISK'
              END
			  IF(@diffDays<=13 AND @validateDate is null)
              BEGIN
                     SET @status='YTD'
              END


			   --By @actualDays
              IF(@actualDays <=13 AND @validateDate is not null)
              BEGIN
                     SET @status='MET'
              END    
              IF(@actualDays >13 AND @validateDate is not null)
              BEGIN
                     SET @status='MISSED'
              END                
       END
       -------------------Approve REPAIR
       IF(@statusFlag='A')
       BEGIN
			   --@validateDate-customer required date
			  SET @actualDays=DATEDIFF(DAY,GETDATE(),@validateDate)		

			  --Critial

			  IF((@category='1' OR CHARINDEX('CRT', ISNULL(@category,'') )>0) AND @actualDays<0)
			  BEGIN
					SET @status='MISSED'
			  END	

			  IF((@category='1' OR CHARINDEX('CRT', ISNULL(@category,'') )>0)  AND @actualDays>=0)
			  BEGIN
					SET @status='YTD'
			  END
			   --NON Critial
			  IF(( @category='2' OR CHARINDEX('CRT', ISNULL(@category,'') )<=0 ) AND @diffDays<21)
			  BEGIN
					SET @status='ONTRACK'
			  END	

			  IF((@category= '2' OR CHARINDEX('CRT', ISNULL(@category,'') )<=0 ) AND @diffDays>20)
			  BEGIN
					SET @status='MISSED'
			  END	

       END

    RETURN @status

END

