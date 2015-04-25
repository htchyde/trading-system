getLongStockRecommendations <- function(potential_stocks, num_stocks_to_recommend=100,
                                        # market parameters
                                        riskfree_rate=0.05,
                                        # recommendation requirements
                                        max_sharpe_ratio=3, min_sharpe_ratio=1,
                                        max_volatility=0.05, min_returns=0.01,
                                        # getQualifiedStocks(...) parameters
                                        start_date=20100101, end_date=format(Sys.time(), "%Y%m%d"), min_datapoints=1000, max_bidask_spread=0.005, min_marketcap=1000000, min_volume=10000,
                                        # fitARtoStock(...) parameters
                                        time_step=1, p_value=0.05)
  {
  loadLibraries()
  
  # YAHOO UNIVERSE OF STOCKS: stocks <- read.csv("All_Yahoo_Equity_Stocks.csv")
  # potential_stocks        - the list of stocks from which recommendations will be made
  # num_stocks_to_recommend - the maximum number of stocks that will be recommended
  
  #### MARKET PARAMETERS
  # riskfree_rate           - the risk-free rate used to calculate sharpe ratios - riskfree yearly rate
  ### RECOMMENDATION REQUIREMENTS
  # min_datapoints          - the minimum number of data points observed of stock price
  # max_sharpe_ratio        - the maximum sharpe ratio (imposed to remove unrealistic opportunities)
  # min_sharpe_ratio        - the minimum sharpe ratio a stock must have to be recommended
  # max_volatility          - the maximum volatility (risk) a stock can have to be recommend
  # min_returns             - the minimum percentage returns a stock must have to be recommended
  
  # min_sharpe_ratio
  
  ### QUALIFICATION REQUIREMENTS
  # See getQualifiedStocks(...) implementation for details
  
  # Get list of qualified stocks
  qualified_stocks <- getQualifiedStocks(potential_stocks, start_date, end_date, max_bidask_spread, min_marketcap, min_volume)
  if(length(qualified_stocks)==0){ stop("No qualified stocks") }

  # create empty table to store predicted returns, variance, sharpe ratio of tickers
  recommendation_table <- c()
  
  for(ticker in qualified_stocks){
    try({
        print("Currently modelling the following stock:")
        print(ticker)
         # Fit the best AR model to qualified ticker
         ar.fit <- fitARtoStock(ticker, start_date, end_date, time_step, min_datapoints, p_value)
        
         # compute variance of white noise
         var <- ar.fit$sigma2;
         
         # compute volatility of white noise of log returns (not stock price volatility!)
         vol <- sqrt(var)
         
         #compute cumulative return
         STOCK.keystatistics <- getQuote(ticker,what=yahooQF(c("Bid","Ask")))
         STOCK.bid <- STOCK.keystatistics[,"Bid"]
         STOCK.ask <- STOCK.keystatistics[,"Ask"]
         bidask_spread <- STOCK.ask - STOCK.bid
         cumulative_return <- cumulativeReturn(ar.fit, bidask_spread)
         
         # compute sharpe ratio
         sharpe_ratio <- sharpeRatio(cumulative_return, vol, riskfree_rate)

         # if the conditions to be recommended are met, 
         # then add ticker, return, variance, sharpe ratio to recommendation table
         if(cumulative_return > min_returns && sharpe_ratio<max_sharpe_ratio && sharpe_ratio>min_sharpe_ratio && vol<max_volatility){
              recommendation_table <- c(recommendation_table, ticker, cumulative_return, vol, sharpe_ratio)
              print("Stock Recommendation Made")
         }
    })
  }
  
  if(length(recommendation_table)==0){ stop("No recommendations found")}
  else{
  recommendation_table <- matrix(recommendation_table, nrow=4)
  rownames(recommendation_table) <- c("Ticker", "Cumulative Return", "Volatility", "Sharpe Ratio")
  write.table(t(recommendation_table),file="recommendation_table.txt")
  table <- read.table("recommendation_table.txt",header=TRUE,row.names=1)  
  # return table of all results ordered by their ascending sharpe ratios
  table <- table[order(-table[,4]),]
  }
  return(table[1:num_stocks_to_recommend,])
}
