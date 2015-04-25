#!/usr/bin/env Rscript

# DESCRIPTION
# Collects the full historical Open-High-Low-Close (OHLC) Data from Data Vendors

# IMPORTANT NOTE
# This script is highly dependent on the webpage:
#	en.wikipedia.org/wiki/Stock_exchange
# If the webpage is moved or the layout is altered the script will break

###############################################################################
# IMPLEMENTATION
###############################################################################
require("quantmod")
require("RMySQL")

# Current data vendors supported by quantmod's getSymbols(...) function
#		google, yahoo, FRED, oanda

source("../Functions/getAllSymbols.R")
source("../Functions/savePriceData.R")
source("../Functions/getVendorID.R")

symbols <- getAllSymbols()
num_symbols <- nrow(symbols)

tradingsystem_db <- dbConnect(MySQL(), user="tradingsystem", password='password', dbname='securities_master', host='localhost')

for(i in 1:num_symbols){
	ticker_id <- symbols[i,"id"]
	ticker <- symbols[i,"symbol"]

	# get data from Google Finance
	try({
	prices.google <- getSymbols.google(ticker,auto.assign=FALSE)

	vendor_id <- getVendorID("Google")
	dates <- index(prices.google)
	opens <- prices.google[,1]
	highs <- prices.google[,2]
	lows <- prices.google[,3]
	closes <- prices.google[,4]
	adj_closes <- NULL

	savePriceData(vendor_id, ticker_id, dates,
			 opens, highs, lows, closes, adj_closes)
	})

	# get data from Yahoo Finance
	try({
	prices.yahoo <- getSymbols.yahoo(ticker,auto.assign=FALSE)

	vendor_id <- getVendorID("Yahoo")
	dates <- index(prices.yahoo)
	opens <- prices.yahoo[,1]
	highs <- prices.yahoo[,2]
	lows <- prices.yahoo[,3]
	closes <- prices.yahoo[,4]
	adj_closes <- prices.yahoo[,6]

	savePriceData(vendor_id, ticker_id, dates,
			 opens, highs, lows, closes, adj_closes)
	})
}

dbDisconnect(tradingsystem_db)
