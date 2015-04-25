fitARtoStock <- function(ticker, start_date=20100101, end_date=format(Sys.time(), "%Y%m%d"), time_step=1, min_datapoints=1000, p_value=0.05){
  
  # p_value     - maximum signficance level (p-value) for covaraince stationary test
  
  ###############################################
  # STEP 1: Collect data and check data quality
  ###############################################
  # Collect stock price data from the Yahoo Finance server.
  STOCK.timeseries <- getStockTimeSeriesData(ticker, start_date, end_date, time_step)
  
  # Check Quality of stock time series data
  checkTimeSeriesDataQuality(STOCK.timeseries,min_datapoints)
  
  ###############################################
  # STEP 2: Transform the data
  ###############################################
  # Transform the stock data to log daily returns and store as a time series.
  logreturns <- na.omit(diff(log(STOCK.timeseries)))
  stock_timeseries <- ts(logreturns);

  # Exit if series isn't covariance stationarity 
  if(adf.test(stock_timeseries)$p.value>p_value){ stop("Time series isn't covariance stationary") }
  
  ###############################################
  # STEP 3: Fit AR model to collected data
  ###############################################
  # Fit AR model to log returns
  ar.model <- fitAR(logreturns, min_datapoints)
  return(ar.model)
}
