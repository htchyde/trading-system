#!/usr/bin/env Rscript

# DESCRIPTION
# Collects list of top 20 Stock Exchanges

# IMPORTANT NOTE
# This script is highly dependent on the webpage:
#	en.wikipedia.org/wiki/Stock_exchange
# If the webpage is moved or the layout is altered the script will break

###############################################################################
# IMPLEMENTATION
###############################################################################
require("XML")
require("RMySQL")

# STEP 1: Collect list of Stock Exchanges from Wikipedia
url <- "http://en.wikipedia.org/wiki/Stock_exchange"
webpage_tables <- readHTMLTable(url)
exchange_table <- webpage_tables[2]$'NULL'
num_exchanges <- nrow(exchange_table)


# STEP 2: Insert Exchange Data into MySQL Database
tradingsystem_db <- dbConnect(MySQL(), user="tradingsystem", password='password', dbname='securities_master', host='localhost')

for(i in 1:num_exchanges){
	sql <- paste("INSERT INTO exchanges(name,hq_country,
			date_created,date_updated) VALUES('",
			exchange_table[i,"Exchange"],
			"', '",
			exchange_table[i,"Headquarters"],
			"', NOW(), NOW())",
			sep=""
			)

	dbGetQuery(tradingsystem_db, sql)
}

dbDisconnect(tradingsystem_db)
