-- ================================================
-- PROCEDURE [dbo].[GetLastPackageRowVersion]
-- ================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Jose Alfredo Arroyo
-- Create date: 01/02/2026 11:27:39
-- Description:	Obtain record [dbo].[PackageConfig] 
-- =============================================

CREATE PROCEDURE [dbo].[GetLastPackageRowVersion]
	-- Add the parameters for the stored procedure here
	@tableName VARCHAR(50)
AS
BEGIN
	SELECT LastRowVersion
	FROM [dbo].[PackageConfig]
	WHERE TableName = @tableName;
END
GO