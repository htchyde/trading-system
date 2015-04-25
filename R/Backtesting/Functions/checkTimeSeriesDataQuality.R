checkTimeSeriesDataQuality <- function(timeseries_data, min_datapoints=1000){
  ###############################################
  # STEP 1: Check data quality
  ###############################################
  
  # Exit if there is missing data
  if(apply(is.na(timeseries_data),2,sum)>0) { stop("Missing time series data") }
  
  # Count the number of data points collected
  num_datapoints <- length(timeseries_data)

  # Exit if not enough observations of the stock price are made
  if(num_datapoints < min_datapoints) { stop("Not enough observations") }

  return(timeseries_data)
}