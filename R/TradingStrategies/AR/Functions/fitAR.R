fitAR <- function(timeseries_data, min_datapoints=1000){
  # input: 3-dim matrix (dimension names: timestamp, stock_price, ticker)
  
  ###############################################
  # STEP 1: Examine quality of data
  ###############################################
  # Check Quality of stock time series data
  checkTimeSeriesDataQuality(timeseries_data, min_datapoints)
  
  # Fit best AR model according to AIC criterion
  ar.fit <- ar(timeseries_data)
  
  # Store the order and residuals of the best AR model
  ar.fit.order <- ar.fit$order
  #ar.fit.res <- ar.fit$resid
  #ar.fit.var <- ar.fit$sigma2
  
  # Convert best ar.fit from an AR object to an ARIMA object (so we can use ARIMA methods)
  ar.fit<-arima(timeseries_data, order = c(ar.fit.order, 0, 0))
  
  return(ar.fit) 
}