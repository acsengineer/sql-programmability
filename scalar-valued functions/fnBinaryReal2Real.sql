USE [KrugHistory]
GO

/****** Object:  UserDefinedFunction [dbo].[fnBinaryReal2Real]    Script Date: 24.01.2023 12:12:23 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[fnBinaryReal2Real]
(
	@BinaryFloat BINARY(4)
)
RETURNS REAL
AS
BEGIN
	RETURN	SIGN(CAST(@BinaryFloat AS INT))
		* (1.0 + (CAST(@BinaryFloat AS INT) &  0x007FFFFF) * POWER(CAST(2 AS REAL), -23))
		* POWER(CAST(2 AS REAL), (CAST(@BinaryFloat AS INT) & 0x7f800000) / 0x00800000 - 127)
END
GO

