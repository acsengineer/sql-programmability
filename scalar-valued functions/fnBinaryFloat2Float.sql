USE [KrugHistory]
GO

/****** Object:  UserDefinedFunction [dbo].[fnBinaryFloat2Float]    Script Date: 24.01.2023 12:11:34 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE FUNCTION [dbo].[fnBinaryFloat2Float]
(
	@BinaryFloat BINARY(8)
)
RETURNS FLOAT
AS
BEGIN
	RETURN	SIGN(CAST(@BinaryFloat AS BIGINT))
		* (1.0 + (CAST(@BinaryFloat AS BIGINT) & 0x000FFFFFFFFFFFFF) * POWER(CAST(2 AS FLOAT), -52))
		* POWER(CAST(2 AS FLOAT), (CAST(@BinaryFloat AS BIGINT) & 0x7ff0000000000000) / 0x0010000000000000 - 1023)
END
/*
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
*/
GO

