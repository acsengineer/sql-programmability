USE [KrugHistory]
GO

/****** Object:  UserDefinedFunction [dbo].[fnBorlandInt2Int]    Script Date: 24.01.2023 12:13:19 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE FUNCTION [dbo].[fnBorlandInt2Int]
(
	@BinaryInt BINARY(4)
)
RETURNS INT
AS
BEGIN

DECLARE @Btemp BINARY (1)
DECLARE @i int, @iLen int
SELECT @i = 0, @iLen = 4--DATALENGTH(@BinaryInt)

  while @i < @iLen/2
  BEGIN
  
    SET @Btemp = SUBSTRING(@BinaryInt, @i+1,1)
    set @BinaryInt = cast(stuff(@BinaryInt, @i+1, 1, SUBSTRING(@BinaryInt,@iLen-@i,1)) as binary(4))
    set @BinaryInt = cast(stuff(@BinaryInt, @iLen-@i, 1, @Btemp) as BINARY(4))
	SET  @i =  @i + 1
  END
--select @BFloat

	RETURN	(CAST(@BinaryInt AS INT))
END
GO

