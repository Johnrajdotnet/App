-- =============================================
-- Author:           Vyshna
-- Create date:      03/27/2018
-- Description:      Test the Syncupdate status
-- exec [TManual].[GetFailedCountSummaryReport]
-- =============================================
CREATE PROCEDURE [TManual].[GetFailedCountSummaryReport]
       
AS
BEGIN TRY

       DECLARE @summarySync TABLE
		(
			Id INT IDENTITY(1, 1)PRIMARY KEY,
			ActionName nvarchar(50),
			ActionValue INT,
			ActionReason nvarchar(50)
		)

        DECLARE @count INT
        DECLARE @list nvarchar(max)   
        BEGIN       

---------------------------Count of failed count of engine series--------------------------
		SET  @count = (SELECT COUNT(1) FROM [TManual].ST_Engine_Series_Type WHERE Active=1 AND IsManual =1 )
        SELECT @list= COALESCE(@list + ',', '')+CAST(Id as nvarchar) FROM [TManual].ST_Engine_Series_Type
		WHERE Active=1 AND IsManual =1

		      
		INSERT INTO @summarySync (ActionName,ActionValue,ActionReason)
		SELECT  'EngineSeries',@count,@list
              
---------------------------Count of failed count of engine publication----------------------
              
        SET  @count = (SELECT COUNT(1) FROM [TManual].ST_Engine_Publication_Details WHERE Active=1 AND IsManual =1)
        SELECT @list= COALESCE(@list + ',', '')+CAST(Id as nvarchar) FROM [TManual].ST_Engine_Publication_Details 
		WHERE Active=1 AND IsManual =1

		INSERT INTO @summarySync (ActionName,ActionValue,ActionReason)
        SELECT  'EPublication',@count,@list                                                                                                     
              
----------------------------Count of failed count of engine publication node----------------- 
                                                                                                                                                        
        SET  @count = (SELECT COUNT(1) FROM [TManual].ST_Publication_Node_Details WHERE Active=1 AND IsManual =1 )
		SELECT @list= COALESCE(@list + ',', '')+CAST(Id as nvarchar) FROM [TManual].ST_Publication_Node_Details 
		WHERE Active=1 AND IsManual =1

		INSERT INTO @summarySync (ActionName,ActionValue,ActionReason)
        SELECT  'EPublicationNode',@count,@list

----------------------------------------------------------------------------------------------
                                                                             
        SELECT Id as Id, ActionName as ActionName,  ActionValue as ManualCount, ActionReason as ActionReason FROM @summarySync

       END

END TRY
BEGIN CATCH
   EXECUTE [dbo].[LogError]
END CATCH

--DECLARE @list nvarchar(200)
--SELECT @list= COALESCE(@list + ',', '')+CAST(Id as nvarchar) FROM [TManual].ST_Engine_Publication_Details WHERE Active=1 AND IsManual =1
--SELECT @list

--select * FROM [TManual].ST_Engine_Publication_Details WHERE Active=1 AND IsManual =1







                           
              
       

