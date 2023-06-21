USE [Stockdata_qdd]
GO

/****** Object:  StoredProcedure [dbo].[insert_finance_data]    Script Date: 21/06/2023 10:33:06 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Dang Dinh Quy>
-- Create date: <2021/09/15>
-- Description:	<backup data>
-- =============================================
CREATE PROCEDURE [dbo].[insert_finance_data] @table int

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	declare
	@cnt_rows int,
	@start datetime;


	set @start = SYSDATETIME();
if @table = 1 
begin
	Select @cnt_rows = count(1) 
	from Stockdata_qdd.dbo.financial_info_tmp tmp
	where not exists 
	(select *
	from stockdata_qdd.dbo.financial_statement fs 
	where tmp.criteria = fs.criteria
	and tmp.YEAR = fs.year
	and tmp.ticket = fs.ticket
	and tmp.value = fs.value
	);

	insert into stockdata_qdd.dbo.financial_statement
	select *
	from Stockdata_qdd.dbo.financial_info_tmp tmp
	where not exists 
	(select *
	from stockdata_qdd.dbo.financial_statement fs 
	where tmp.criteria = fs.criteria
	and tmp.YEAR = fs.year
	and tmp.ticket = fs.ticket
	and tmp.value = fs.value
	);
	
	insert into Stockdata_qdd.dbo.finance_monitor 
	values
	('financial_statement',
	@start,
	SYSDATETIME(),
	@cnt_rows,
	CONVERT(VARCHAR(8), DATEADD(SECOND, DATEDIFF(SECOND,@Start, SYSDATETIME()),0), 108) 
	);
end
ELSE if (@table = 2)
begin
	Select @cnt_rows = count(1) 
	from Stockdata_qdd.dbo.financial_info_tmp tmp
	where not exists 
	(select *
	from stockdata_qdd.dbo.income_statement fs 
	where tmp.criteria = fs.criteria
	and tmp.YEAR = fs.year
	and tmp.ticket = fs.ticket
	and tmp.value = fs.value
	);

	insert into stockdata_qdd.dbo.income_statement
	select *
	from Stockdata_qdd.dbo.financial_info_tmp tmp
	where not exists 
	(select *
	from stockdata_qdd.dbo.income_statement fs 
	where tmp.criteria = fs.criteria
	and tmp.YEAR = fs.year
	and tmp.ticket = fs.ticket
	and tmp.value = fs.value
	);
	
	insert into Stockdata_qdd.dbo.finance_monitor 
	values
	('income_statement',
	@start,
	SYSDATETIME(),
	@cnt_rows,
	CONVERT(VARCHAR(8), DATEADD(SECOND, DATEDIFF(SECOND,@Start, SYSDATETIME()),0), 108) 
	);
end
else if @table = 3
begin
	Select @cnt_rows = count(1) 
	from Stockdata_qdd.dbo.financial_info_tmp tmp
	where not exists 
	(select *
	from stockdata_qdd.dbo.cashflow_statement fs 
	where tmp.criteria = fs.criteria
	and tmp.YEAR = fs.year
	and tmp.ticket = fs.ticket
	and tmp.value = fs.value
	);

	insert into stockdata_qdd.dbo.cashflow_statement
	select *
	from Stockdata_qdd.dbo.financial_info_tmp tmp
	where not exists 
	(select *
	from stockdata_qdd.dbo.cashflow_statement fs 
	where tmp.criteria = fs.criteria
	and tmp.YEAR = fs.year
	and tmp.ticket = fs.ticket
	and tmp.value = fs.value
	);
	
	insert into Stockdata_qdd.dbo.finance_monitor 
	values
	('cashflow_statement',
	@start,
	SYSDATETIME(),
	@cnt_rows,
	CONVERT(VARCHAR(8), DATEADD(SECOND, DATEDIFF(SECOND,@Start, SYSDATETIME()),0), 108) 
	);
end
else if @table = 4
begin
	Select @cnt_rows = count(1) 
	from Stockdata_qdd.dbo.financial_info_tmp tmp
	where not exists 
	(select *
	from stockdata_qdd.dbo.financial_basic_index fs 
	where tmp.criteria = fs.criteria
	and tmp.YEAR = fs.year
	and tmp.ticket = fs.ticket
	and tmp.value = fs.value
	);

	insert into financial_basic_index
	select *
	from Stockdata_qdd.dbo.financial_info_tmp tmp
	where not exists 
	(select *
	from stockdata_qdd.dbo.financial_basic_index fs 
	where tmp.criteria = fs.criteria
	and tmp.YEAR = fs.year
	and tmp.ticket = fs.ticket
	and tmp.value = fs.value
	);
	
	insert into Stockdata_qdd.dbo.finance_monitor 
	values
	('financial_basic_index',
	@start,
	SYSDATETIME(),
	@cnt_rows,
	CONVERT(VARCHAR(8), DATEADD(SECOND, DATEDIFF(SECOND,@Start, SYSDATETIME()),0), 108) 
	);
end
END
GO

