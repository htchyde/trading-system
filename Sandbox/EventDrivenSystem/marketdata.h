// =============================================================================
// header guard
#ifndef _MARKET_DATA_H
#define _MARKET_DATA_H

// =============================================================================
// include dependencies

#include "price.h"

// =============================================================================
// class definitions
// Market Data classes define the formats in which the data should be stored at sent as market events

class MarketData {
	public:
};

class OHLC_MarketData : public MarketData {
	public:
		Price 		open, high, low, close;

				OHLC_MarketData(Price open, Price high, Price low, Price close) : open(open), high(high), low(low), close(close) { };

};

#endif
