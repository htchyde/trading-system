calculateRelevantRiskFreeRate <- function(riskfree_rate=0.05, days_ahead=14){
  # calculate the equivalent riskfree rate over the time period of length days_ahead
  # (1+rfr)^n = 1 + riskfree_rate =: 1 + r ==> rfr = (1+r)^(1/n) - 1
  n <- 365.0/days_ahead
  rfr <- (1+riskfree_rate)^(1/n) - 1
  return(rfr)
}