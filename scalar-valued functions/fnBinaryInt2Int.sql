USE [KrugHistory]
GO

/****** Object:  UserDefinedFunction [dbo].[fnBinaryInt2Int]    Script Date: 24.01.2023 12:11:59 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE FUNCTION [dbo].[fnBinaryInt2Int]
(
	@BinaryInt BINARY(4)
)
RETURNS INT
AS
BEGIN
	RETURN	(CAST(@BinaryInt AS INT))
END

GO

