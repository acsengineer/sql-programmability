USE [KrugHistory]
GO

/****** Object:  UserDefinedFunction [dbo].[fnBorlandDouble2Float]    Script Date: 24.01.2023 12:12:59 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE FUNCTION [dbo].[fnBorlandDouble2Float]
(
	@BinaryFloat BINARY(8)
)
RETURNS FLOAT
AS
BEGIN

DECLARE @RESULT FLOAT
DECLARE @Btemp BINARY (1)
DECLARE @i int, @iLen int
if @BinaryFloat!=0x000000000000F07F and @BinaryFloat!=0x000000000000F8FF BEGIN
SELECT @i = 0, @iLen = 8--DATALENGTH(@BinaryFloat)

  while @i < @iLen/2
  BEGIN
  
    SET @Btemp = SUBSTRING(@BinaryFloat, @i+1,1)
    set @BinaryFloat = cast(stuff(@BinaryFloat, @i+1, 1, SUBSTRING(@BinaryFloat,@iLen-@i,1)) as binary(8))
    set @BinaryFloat = cast(stuff(@BinaryFloat, @iLen-@i, 1, @Btemp) as BINARY(8))
	SET  @i =  @i + 1
  END
--select @BFloat
	SET @RESULT=SIGN(CAST(@BinaryFloat AS BIGINT))
		* (1.0 + (CAST(@BinaryFloat AS BIGINT) & 0x000FFFFFFFFFFFFF) * POWER(CAST(2 AS FLOAT), -52))
		* POWER(CAST(2 AS FLOAT), (CAST(@BinaryFloat AS BIGINT) & 0x7ff0000000000000) / 0x0010000000000000 - 1023)
	END
	ELSE SET @RESULT=0
	RETURN @RESULT
END
GO

