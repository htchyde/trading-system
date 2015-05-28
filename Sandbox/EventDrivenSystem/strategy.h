// =============================================================================
// header guard
#ifndef _STRATEGY_H
#define _STRATEGY_H

// =============================================================================
// included dependencies
#include <vector>
#include <queue>

#include "stock.h"
#include "portfolio.h"
#include "marketdata.h"

// =============================================================================
// forward declarations
class Event;

// =============================================================================
// class definition
class Strategy{
// Determines the target portfolio of the strategy given new stock price information and the current portfolio of the factor strategy.
// The target portfolio cannot depend on the amount of capital invested because we do not know that in advance - the portfolio optimiser will determine that
// Strategy must contain information on when it needs to hear about near market events and which stocks it needs to here events on

	public:
		std::vector<Stock>	stock_universe;
		int			market_listener_information;	// int class type has just been used a dummy as I haven't determined its class type yet... this will contain information on what market data it needs and when it needs it... this information will be passed onto the market listener
		Portfolio		current_portfolio; // encapsulated because the constructTargetPortfolio method needs to keep track of this constantly (presumably this is true for all strategies but this isn't necessarily the case - so you may want to remove this from the strategy base class...)
		std::queue< std::unique_ptr<Event> >* 	event_queue_ptr;	// constructTargetPortfolio sends FactorEvent to the event queue
		virtual Portfolio	constructTargetPortfolio(MarketData market_data) = 0; // abstract method
};


class HoldAllStrategy : public Strategy{
// Do nothing / hold all positions strategy
		virtual Portfolio	constructTargetPortfolio(MarketData market_data){ return Portfolio(); };

		// std::queue< std::unique_ptr<Event> >*		event_queue_ptr;
		//virtual Portfolio	constructTargetPortfolio(MarketData market_data){ event_queue_ptr->push_back(new FactorEvent( Portfolio() ))};
};

class CrossSectionalMeanReversionStrategy : public Strategy{
// Cross-sectional mean reversion strategy
		virtual Portfolio	constructTargetPortfolio(MarketData market_data){ return Portfolio(); };
};

#endif
