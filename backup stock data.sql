USE [Stockdata_qdd]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Dang Dinh Quy>
-- Create date: <2021/09/15>
-- Description:	<backup data>
-- =============================================
CREATE PROCEDURE [dbo].[Backup_stock_data] 

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	declare
	@cnt_rows int,
	@start datetime;

	--###########################
    -- VN_EOD
	--###########################
	set @start = SYSDATETIME();

	delete 
	--select count(1) 
	from Stockdata_qdd.dbo.VN_EOD
	where CAST(date as date) >= dateadd(day,-1,CAST(SYSDATETIME() as date));

	select @cnt_rows = count(1) 
	from StockData.dbo.VN_EOD a
	where not exists
	(select 1
	from Stockdata_qdd.dbo.VN_EOD b
	where a.SYMBOL = b.SYMBOL
		and a.DATE = b.DATE
	);

	insert into Stockdata_qdd.dbo.VN_EOD
	select a.* 
	from StockData.dbo.VN_EOD a
	where not exists
	(select 1
	from Stockdata_qdd.dbo.VN_EOD b
	where a.SYMBOL = b.SYMBOL
		and a.DATE = b.DATE
	);

	insert into Stockdata_qdd.dbo.backup_monitor 
	values
	('VN_EOD',
	@start,
	SYSDATETIME(),
	@cnt_rows,
	CONVERT(VARCHAR(8), DATEADD(SECOND, DATEDIFF(SECOND,@Start, SYSDATETIME()),0), 108) 
	);

	--###########################
	-- VN_EOD2
	--###########################

	set @start = SYSDATETIME();

	delete 
	--select count(1) 
	from Stockdata_qdd.dbo.VN_EOD2
	where CAST(date as date) >= dateadd(day,-1,CAST(SYSDATETIME() as date));

	select @cnt_rows = count(1) 
	from StockData.dbo.VN_EOD2 a
	where not exists
	(select 1
	from Stockdata_qdd.dbo.VN_EOD2 b
	where a.SYMBOL = b.SYMBOL
		and a.DATE = b.DATE
	);

	insert into Stockdata_qdd.dbo.VN_EOD2
	select a.* 
	from StockData.dbo.VN_EOD2 a
	where not exists
	(select 1
	from Stockdata_qdd.dbo.VN_EOD2 b
	where a.SYMBOL = b.SYMBOL
		and a.DATE = b.DATE
	);

	insert into Stockdata_qdd.dbo.backup_monitor 
	values
	('VN_EOD2',
	@start,
	SYSDATETIME(),
	@cnt_rows,
	CONVERT(VARCHAR(8), DATEADD(SECOND, DATEDIFF(SECOND,@Start, SYSDATETIME()),0), 108) 
	);
	
	--###########################
	-- VN_Intraday
	--###########################

	set @start = SYSDATETIME();

	delete 
	--select count(1) 
	from Stockdata_qdd.dbo.VN_Intraday
	where CAST(date as date) >= dateadd(day,-1,CAST(SYSDATETIME() as date));

	select @cnt_rows = count(1) 
	from StockData.dbo.VN_Intraday a
	where not exists
	(select 1
	from Stockdata_qdd.dbo.VN_Intraday b
	where a.SYMBOL = b.SYMBOL
		and a.DATE = b.DATE
	);

	insert into Stockdata_qdd.dbo.VN_Intraday
	select a.* 
	from StockData.dbo.VN_Intraday a
	where not exists
	(select 1
	from Stockdata_qdd.dbo.VN_Intraday b
	where a.SYMBOL = b.SYMBOL
		and a.DATE = b.DATE
	);

	insert into Stockdata_qdd.dbo.backup_monitor 
	values
	('VN_Intraday',
	@start,
	SYSDATETIME(),
	@cnt_rows,
	CONVERT(VARCHAR(8), DATEADD(SECOND, DATEDIFF(SECOND,@Start, SYSDATETIME()),0), 108) 
	);
	
	--###########################
	-- VN_symbol
	--###########################

	set @start = SYSDATETIME();

	select @cnt_rows = count(1) 
	from StockData.dbo.VN_symbol a
	where not exists
	(select 1
	from Stockdata_qdd.dbo.VN_symbol b
	where a.SYMBOL = b.SYMBOL
	);

	insert into Stockdata_qdd.dbo.VN_symbol
	select a.* 
	from StockData.dbo.VN_symbol a
	where not exists
	(select 1
	from Stockdata_qdd.dbo.VN_symbol b
	where a.SYMBOL = b.SYMBOL
	);

	insert into Stockdata_qdd.dbo.backup_monitor 
	values
	('VN_symbol',
	@start,
	SYSDATETIME(),
	@cnt_rows,
	CONVERT(VARCHAR(8), DATEADD(SECOND, DATEDIFF(SECOND,@Start, SYSDATETIME()),0), 108) 
	);
END
GO

