require("RMySQL")

getVendorID <- function(vendor_name){

	tradingsystem_db <- dbConnect(MySQL(), user="tradingsystem", password='password', dbname='securities_master', host='localhost')

	sql <- paste("SELECT id FROM data_vendors WHERE name='",
			vendor_name,
			"' LIMIT 1",
			sep="") 

	vendor_id <- dbGetQuery(tradingsystem_db, sql)

	dbDisconnect(tradingsystem_db)

	return(vendor_id)
}
