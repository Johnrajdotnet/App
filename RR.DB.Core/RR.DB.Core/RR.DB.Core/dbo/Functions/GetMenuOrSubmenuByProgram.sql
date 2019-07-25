
	-- =============================================
	-- Author:           <Mira Kumari>
	-- Create date:		 <09/11/2018>
	-- Description:      < Get Mwnu and submenu>
	-- exec [dbo].[GetMenuOrSubmenuByProgram] '19,21,17,49,51,53,81,83,85','Menu'
	-- =============================================
	CREATE FUNCTION [dbo].[GetMenuOrSubmenuByProgram]
	(
		@ProgramModulId varchar(500), 
		@Flag varchar(30)
	) 
	RETURNS varchar(500)   
	AS   
	BEGIN  
	     Declare @MenuList varchar(500)
		 DECLARE @temptable TABLE
				(
				Id INT IDENTITY(1,1),
				MenuOrSubmenuId INT
				) 

		 if(@Flag='Menu')
		 BEGIN
				
				insert into @temptable
				SELECT DISTINCT [MenuId] as MenuOrSubmenuId FROM [Admin].[ST_Program_Details]
				WHERE Id in(SELECT * from [dbo].[StringToTableValue](@ProgramModulId,','))

				SELECT @MenuList = COALESCE(@MenuList + ',', '') + CAST(MenuOrSubmenuId AS VARCHAR(MAX))
				FROM @temptable
	      
		 END
		 ELSE IF(@Flag='Submenu')
		 BEGIN
			 insert into @temptable
			 SELECT DISTINCT SubMenuId as MenuOrSubmenuId FROM [Admin].[ST_Program_Details]
			 WHERE Id in(SELECT * from [dbo].[StringToTableValue](@ProgramModulId,','))

			 SELECT @MenuList = COALESCE(@MenuList + ',', '') + CAST(MenuOrSubmenuId AS VARCHAR(MAX))
			 FROM @temptable
		 END
			 return @MenuList

	END


