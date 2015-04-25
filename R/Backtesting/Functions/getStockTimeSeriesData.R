getStockTimeSeriesData <- function(ticker, start_date=20100101, end_date=format(Sys.time(), "%Y%m%d"), timestep=1){
  STOCK <- getYahooData("YHOO", start=20100101, end=end_date)[, "Close"]
  return(STOCK)
}