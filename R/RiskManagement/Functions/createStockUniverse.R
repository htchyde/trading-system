createStockUniverse <- function(num_stocks=1000, start=1, rand=FALSE){
  # for createStockUniverse(...) to work:
  # working directory must be set to the src/ directory of this repository
  
  # rand        - set equal to TRUE to generate a random stock universe
  allYahooStocks <- (read.csv("All_Yahoo_Equity_Stocks.csv"))[,"Ticker"]

  if(num_stocks+start-1 >= length(allYahooStocks)){ stop("Cannot create stock universe") }
  else if(rand==TRUE){
        stock_universe <- sample(allYahooStocks, num_stocks, replace=FALSE)
  } 
  else{
        stock_universe <- (allYahooStocks)[start:(start+num_stocks-1)]
  }
  
  return(stock_universe)
}