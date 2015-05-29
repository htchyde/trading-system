#include "marketlistener.h"

std::queue< std::unique_ptr<Event> > MarketListener::getNewMarketEvents(void){ 
	// Before connecting to Securities Master Database or Brokerage PI, I will implement a simple getMarketEvents function that will create a simple OHLC event

	std::queue< std::unique_ptr<Event> >	new_market_events;

	// START - Temp code
	// Creates a OHLC_MarketDataEvent object...
	Price 					open = Price(1.0), high = Price(3.0), low = Price(0.5), close = Price(2.0);
	OHLC_MarketData 			OHLC = OHLC_MarketData(open,high,low,close);
	Strategy*				strategy_ptr =  strategy_universe[0];
	std::unique_ptr<OHLC_MarketEvent> 	ohlc_event = std::make_unique<OHLC_MarketEvent>(OHLC, strategy_ptr); // NOTE: the following is incorrect syntax and won't compile:	std::unique_ptr<OHLC_MarketEvent> 	ohlc_event = new OHLC_MarketEvent(OHLC, strategy_ptr);

	new_market_events.push(std::move(ohlc_event)); // push(...) is a method so the copy constructor is called when you pass the unique_ptr as an arguement... therefore you need to use std::move
	// END - Temp code

	return new_market_events; 
}; 

