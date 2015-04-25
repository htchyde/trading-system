isStockQualified <- function(ticker, start_date=20100101, end_date=format(Sys.time(), "%Y%m%d"), max_bidask_spread=0.005, min_marketcap=1000000, min_volume=10000){

  # qualifies stock based on current or recent data - not large amounts of historical data
  
  #########################################
  # Additional Contraint Parameters       #
  #########################################
  # max_bidask_spread - the maximum bid-ask spread as percentage of buy price
  # min_marketcap     - the minimum market capitalisation in dollars
  # min_volume        - the minimum volume of trades in stock
  

  ###############################################
  # STEP 2: Uphold Additional Constraints
  ###############################################
  
  # Collect Key Statistics from Yahoo Finance Server
  STOCK.keystatistics <- getQuote(ticker,what=yahooQF(c("Bid","Ask","Market Capitalization","Volume")))
  STOCK.bid <- STOCK.keystatistics[,"Bid"]
  STOCK.ask <- STOCK.keystatistics[,"Ask"]
  STOCK.marketcap <- STOCK.keystatistics[,"Market Capitalization"]
  STOCK.volume <- STOCK.keystatistics[,"Volume"]
  
  # Check minimum bid-ask spread condition qualified
  if(is.na(STOCK.bid) || is.na(STOCK.ask) ) { stop("Missing bid-ask data") }
  if((STOCK.ask - STOCK.bid)/STOCK.ask > max_bidask_spread) { stop("Bid-ask spread too large") }
  
  # Check minimum market capitalisation condition qualified
  if(is.na(STOCK.marketcap) ) { stop("Missing Market Capitalization data") }
  if(STOCK.marketcap <= min_marketcap) { stop("Bid-ask spread too large") }
  
  # Check minimum volume condition qualified
  if(is.na(STOCK.volume) ) { stop("Missing Market Capitalization data") }
  if(STOCK.volume <= min_volume) { stop("Bid-ask spread too large") }
  
  ###############################################
  # STEP 3: Return TRUE: Stock is Qualified
  ###############################################

  return(TRUE)
  
}