sharpeRatio <- function(expected_return, vol, riskfree_rate=0.05, days_ahead=14){
  # riskfree rate over same time horizon as forecast
  rfr <- calculateRelevantRiskFreeRate(riskfree_rate, days_ahead)
  return((expected_return - rfr)/vol);
}