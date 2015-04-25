# DESCRIPTION
# Saves Price Data in Securities Master Database
# where the data is collected for a fixed Ticker Symbol
# and fixed Data Vendor

require("RMySQL")

savePriceData <- function(vendor_id,ticker_id,dates,opens=NULL,highs=NULL,
			lows=NULL,closes=NULL,adj_closes=NULL){

# All arguements should be passed as lists - except for vendor_id, ticker_id

tradingsystem_db <- dbConnect(MySQL(), user="tradingsystem", password='password', dbname='securities_master', host='localhost')

num_dates <- length(dates)

for(i in 1:num_dates){

	sql<-paste("INSERT INTO daily_prices(vendor_id, ticker_id, date,
					open, high, low, close, adj_close,
					date_created, date_updated) 
				VALUES('",
				vendor_id,
				"', '",
				ticker_id,
				"', STR_TO_DATE('",
				dates[i],
				"','%Y-%m-%d'), '",
				opens[i],
				"', '",
				highs[i],
				"', '",
				lows[i],
				"', '",
				closes[i],
				"', '",
				adj_closes[i],
				"', NOW(), NOW())",
				sep="")

		dbGetQuery(tradingsystem_db, sql)
	}

dbDisconnect(tradingsystem_db)

}

