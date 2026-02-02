-- ================================================
-- PROCEDURE [dbo].[UpdateLastPackageRowVersion]
-- ================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Jose Alfredo Arroyo
-- Create date: 01/02/2026 11:27:39
-- Description:	Update table [dbo].[PackageConfig] 
-- =============================================

CREATE PROCEDURE [dbo].[UpdateLastPackageRowVersion]
	@tableName VARCHAR(50)
	,@lastRowVersion BIGINT
AS
BEGIN
	UPDATE [dbo].[PackageConfig]
	SET LastRowVersion = @lastRowVersion
	WHERE TableName = @tableName;
END
GO