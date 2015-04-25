#!/usr/bin/env Rscript

# DESCRIPTION
# Collects list of FTSE100 Ticker Symbols

# IMPORTANT NOTE
# This script is highly dependent on the webpage:
#	en.wikipedia.org/wiki/FTSE_100_Index
# If the webpage is moved or the layout is altered the script will break

###############################################################################
# IMPLEMENTATION
###############################################################################
require("XML")
require("RMySQL")

# STEP 1: Collect list of FTSE100 Ticker Symbols from Wikipedia
url <- "http://en.wikipedia.org/wiki/FTSE_100_Index"
webpage_tables <- readHTMLTable(url)
FTSE100_constituents_table <- webpage_tables$constituents
num_symbols <- nrow(FTSE100_constituents_table)


# STEP 2: Insert Ticker Symbols into MySQL Database
tradingsystem_db <- dbConnect(MySQL(), user="tradingsystem", password='password', dbname='securities_master', host='localhost')

for(i in 1:num_symbols){
	sql <- "SELECT id FROM exchanges WHERE name='London Stock Exchange Group' LIMIT 1"
	res <- dbGetQuery(tradingsystem_db, sql)
	ex_id <- res[1,'id']

	sql <- paste("INSERT INTO tickers(exchange_id,symbol,instrument,name,
			sector,date_created,date_updated) VALUES('", 
			ex_id, "', '",
			FTSE100_constituents_table[i,"Ticker"],
			"', 'stock', '",
			FTSE100_constituents_table[i,"Company"],
			"', '",
			FTSE100_constituents_table[i,"Sector"],
			"', NOW(), NOW())",
			sep="")

	dbGetQuery(tradingsystem_db, sql)
}

dbDisconnect(tradingsystem_db)
