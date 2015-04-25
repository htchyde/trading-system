USE securities_master;

SELECT date,ticker_id FROM daily_prices 
	GROUP BY close HAVING COUNT(*)>1;
