# DESCRIPTION
# Gets all Symbols from Securities Master Database

###############################################################################
# IMPLEMENTATION
###############################################################################
require("RMySQL")

getAllSymbols <- function(){
	tradingsystem_db <- dbConnect(MySQL(), user="tradingsystem", password='password', dbname='securities_master', host='localhost')
	sql <- "SELECT id, symbol FROM tickers"
	res <- dbGetQuery(tradingsystem_db, sql)
	
	list_of_symbols <- res

	dbDisconnect(tradingsystem_db)

	return(list_of_symbols)
}
