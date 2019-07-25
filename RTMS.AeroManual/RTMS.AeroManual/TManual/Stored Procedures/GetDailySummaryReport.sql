/****** Object:  StoredProcedure [TManual].[GetDailySummaryReport] Script Date: 3/14/2018 2:47:26 PM ******/

-- =============================================
-- Author:           Arathy
-- Create date: 1/12/2018
-- Description:      Test the Syncupdate status
-- exec [TManual].[GetDailySummaryReport] 
-- =============================================
CREATE PROCEDURE [TManual].[GetDailySummaryReport]
       
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
          
        BEGIN       
-------------------------------SyncUpdate------------------------------------------------

---------------------------   **COUNT OF ALL RECORDS**-----------------------------------
              SET  @count = (SELECT COUNT(1) FROM [TManual].ST_Publication_Node_Details WHERE Active=1 )
              
              INSERT INTO @summarySync (ActionName,ActionValue,ActionReason)
              SELECT  'TotalNoOfRecordsToSync',@count,'Total number of records to sync'
              
--------------------------------count of records synced today----------------------------
              
        SET  @count = (SELECT COUNT(1) FROM [TManual].ST_Publication_Node_Details WHERE Active=1 
                                                                    AND CONVERT(nvarchar,SyncDate,112)=CONVERT(nvarchar(10),GETDATE(),112))
              INSERT INTO @summarySync (ActionName,ActionValue,ActionReason)
        SELECT  'NoOfRecordsSynced',@count,'Number of records synced'                                                                                                     
              
----------------------------------count of records  with  failed/is manual count---------------------    
                                                                                                                                                        
        SET  @count = (SELECT COUNT(1) FROM [TManual].ST_Publication_Node_Details WHERE Active=1 AND IsManual = 1 )

              INSERT INTO @summarySync (ActionName,ActionValue,ActionReason)
        SELECT  'NoOfFailedOrIsManualRecords',@count,'Number of failed/is manual records' 
              
------------------------------------count of records yet to sync----------------------------   

        SET  @count = (SELECT COUNT(1) FROM [TManual].ST_Publication_Node_Details WHERE Active=1
                                                        AND CONVERT(nvarchar,SyncDate,112) < CONVERT(nvarchar(10),GETDATE(),112))
              INSERT INTO @summarySync (ActionName,ActionValue,ActionReason)
        SELECT  'NoOfRecordsYetTosync',@count,'Number of records yet to sync'                                                                                                                                                                             
              
----------------------------------------collection--------------------------------------------
---------------------------   **COUNT OF ALL RECORDS For collection**-------------------------

        SET  @count = (SELECT COUNT(1) FROM [TManual].ST_Publication_Node_Details WHERE Active=1 AND UPPER(SyncStatus) = 'INPROGRESS')

              INSERT INTO @summarySync (ActionName,ActionValue,ActionReason)
        SELECT  'TotalNoOfRecordsToCollect',@count,'Total number of records to collect'  
              
--------------------------------count of records Collected Today------------------------------
              
        SET  @count = (SELECT COUNT(1) FROM [TManual].ST_Publication_Node_Details WHERE Active=1 
                                                                    AND CONVERT(nvarchar,SyncDate,112)=CONVERT(nvarchar(10),GETDATE(),112) 
                                                                    AND UPPER(SyncStatus) = 'COMPLETED')
                                                                                                                               
              INSERT INTO @summarySync (ActionName,ActionValue,ActionReason)
        SELECT  'NoOfRecordsCollected',@count,'Number of records collected'                                                                                                          
              
----------------------------------count of records  Downloaded---------------------------------     
                                                                                                                                                        
        SET  @count = (SELECT COUNT(1) FROM [TManual].ST_Publication_Node_Details  pn
                                                                INNER JOIN [TManual].OT_Manual_Information_Details  mi ON pn.Id = mi.PublicationNodeId
                                                                where Active=1 AND IsDownloadSuccess =1)

              INSERT INTO @summarySync (ActionName,ActionValue,ActionReason)
        SELECT  'NoOfDownloadedRecords',@count,'Number of downloaded records'     
                                                                             
          SELECT Id as Id, ActionName as ActionName,  ActionValue as ManualCount, ActionReason as ActionReason FROM @summarySync 

       END

END TRY
BEGIN CATCH
   EXECUTE [dbo].[LogError]
END CATCH

