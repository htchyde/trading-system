cumulativeReturn <- function(logreturn.arima.model, bidask_spread, days_ahead = 14){
  # days_ahead = the time-horizon to forecast holding stock over
  
  # calculates expected cumulative percentage return over a period of "days_ahead" from a fitted ARIMA mdoel
  arma.forecast <- forecast(logreturn.arima.model, h = days_ahead)
  arma.forecast.expectation <- arma.forecast$mean
  
  cumulative_logreturn <- 0
  for(r in arma.forecast.expectation)
  {
    cumulative_logreturn <- (cumulative_logreturn + r);
  }
  cumulative_return <- exp(cumulative_logreturn)-1
  
  # take account of bid-ask spread
  cumulative_return <- cumulative_return - bidask_spread
  
  return(cumulative_return)
}