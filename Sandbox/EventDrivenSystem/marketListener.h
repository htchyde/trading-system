#ifndef _MARKET_LISTENER_H
#define _MARKET_LISTENER_H

#include <list>
#include <queue>

#include "stock.h"
#include "event.h"


class MarketListener{
	// abstract class that listens for new market information
	// needs to know what data to get, i.e. OHLC, tickers for every second of the day
	// needs to know when to get the data? Interested in only near market open and close data?
	// needs to know when to stop listening, i.e. don't listen when the markets haven't opened and don't listen after it has closed? Therefore needs to know what exchange the stocks are listed in
	// Note different strategies will need different market listeners, so this could be annoying to implement. I guess each strategy should have its own market listener - but then two different strategies might listen for the same information which would be inefficient
	public:
		std::list<Stock> 		stock_universe;		// list of all stocks that the market listener should continually get information on 
		std::queue<MarketEvent>		getNewMarketEvents(void){ return std::queue<MarketEvent>(); };		
	private:
};

class BrokerMarketListener : public MarketListener{
	// recieves market data from a broker
};


// Implementation for specific Broker API's
// Derived Class Example 1:
class InteractiveBrokersListener : public BrokerMarketListener{
	// broker market listener that gets its information through the Interactive Brokers API
};


class SimulatedMarketListener : public MarketListener{
	// recieves market data from the Securities Master Database
};

// Specialisation example 1:
class DailyOHLC_SimulatedMarketListener : public SimulatedMarketListener{
	// receive daily OHLC market data from SMD
};

#endif
