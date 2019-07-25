
-- =============================================
-- Author:           <JohnRaj>
-- Create date:		 <25/04/2018>
-- Description:      <Retrives Library Content Details>
-- [Admin].[GetLibraryContentDetails] null
CREATE PROCEDURE [Admin].[GetLibraryContentDetails]

       @documentTypeName nvarchar(50)       
AS
BEGIN
		
		SELECT 
				Id				  AS Id,
				DocumentTypeName  AS DocumentTypeName,
				FileNameExtension AS FileNameExtension,
				FileDisplayName   AS FileDisplayName,
				FileServerPath    AS FileServerPath,
				Active            AS Active,
				CreatedDate       AS CreatedDate,
				ModifiedDate      AS ModifiedDate
		FROM
				[Admin].[ST_Library_Content_Details]
		WHERE
				DocumentTypeName=ISNULL(@documentTypeName,DocumentTypeName)
				
END