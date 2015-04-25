getQualifiedStocks <- function(potential_stocks, start_date=20100101, end_date=format(Sys.time(), "%Y%m%d"), max_bidask_spread=0.005, min_marketcap=1000000, min_volume=10000){

  # potential_stocks  - the list of stocks to check for qualification
  # note we can query Yahoo with more than one stock at a time for data - so we should probably
  # do that!!!
  
  #########################################
  # Additional Contraint Parameters       #
  #########################################
  # max_bidask_spread - the maximum bid-ask spread as percentage of buy price
  # min_marketcap     - the minimum market capitalisation in dollars
  # min_volume        - the minimum volume of trades in stock
  
  #########################################
  # getQualifiedStocks(...) output        #
  #########################################
  # Qualified stocks will be stored in the qualified_stocks variable and returned by this function
  qualified_stocks <- c()
  
  for(ticker in potential_stocks){
    try({ if(isStockQualified(ticker, start_date, end_date, 
                            max_bidask_spread, min_marketcap, min_volume)){
                  # Add stock to list of qualified stocks
                  qualified_stocks <- c(qualified_stocks, ticker)
        }
    })
  }
  
  return(qualified_stocks)
}