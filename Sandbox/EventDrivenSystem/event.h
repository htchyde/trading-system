// =============================================================================
// header guard
#ifndef _EVENT_H_
#define _EVENT_H_

// =============================================================================
// include dependencies
#include <queue>
#include <iostream>
#include "price.h"
#include "marketdata.h"
#include "strategy.h"

// =============================================================================
// forward declarations

// =============================================================================
// class definition
// Note by using events and not going through some procedual process - dealing with the absence of certain events is more efficient (you don't call a function with null passed in and then the receipient function will need to check for null and it becomes pointless if you could of just cut off the procedure immediately. Also by using events we can EASILY make things occur only if certain other event conditions are met - if you go through several precedual functions you would need to keep track of everything in the previous functions - using flags of some kind - and it would just get really messy. That's why we're using events. As our program responds to unknown events. Events are useful whenever something may or may not occur.
// Also we will parrallise the code - so the order in which code is executed is not the same. Since we don't want to be waiting around we will have an event queue.

class Event{
	public:
		// datetime 		datetime_created   		// time the event was created - either use the <ctime.h> library or boost date_time library...
		virtual void 		handleEvent(void){ std::cout << "Event occurred \n";};

					Event(void){ }; // default constructor should set the datetime_created value
};

class TriggerEvent : public Event{
// A trigger event is an event that may trigger further events through the handleEvent method
	public:
		std::queue< std::unique_ptr<Event> >*	event_queue_ptr;  // which event queue should the event and further events be sent to? // WARNING: What will happen if the external event queue is deleted? How will you deal with this?
};

class MarketEvent : public Event{
// Data from the Market has been received
	public:
		Strategy*		strategy_ptr; // The Market Listener created this OHLCMarketEvent and the Market Listener knows which strategy needs this market event data and it knows when it needs it. 	
					// the issue now is that the Strategy that receives this event is going to need to know who to send its FactorEvent to - so we will need to provide this OHLCMarketEvent with this information also
					MarketEvent(Strategy* strategy_ptr): strategy_ptr(strategy_ptr){ };
};

class OHLC_MarketEvent : public MarketEvent{
// OHLC Data from the Market has been received
	public:
		OHLC_MarketData		OHLC;

//					OHLC_MarketEvent(Price open, Price high, Price low, Price close, Strategy* strategy_ptr): OHLC(open, high, close, low), MarketEvent(strategy_ptr) { };
					OHLC_MarketEvent(OHLC_MarketData OHLC, Strategy* strategy_ptr): OHLC(OHLC), MarketEvent(strategy_ptr) { };
//		virtual void		handleEvent(void){ strategy_ptr->constructTargetPortfolio(open,high,low,close); }; // Feeds OHLC Market data into each of the relevant strategies so that they can provide their trading signals / factor portfolio
		virtual void		handleEvent(void){ std::cout<<"OHLC MARKET EVENT OCCURRED.\n"; strategy_ptr->constructTargetPortfolio(OHLC); }; // Feeds OHLC Market data into each of the relevant strategies so that they can provide their trading signals / factor portfolio
};

class OrderEvent : public Event{
// Order to be filled has been provided
	public:
		virtual void		handleEvent(void){}; // Pass order event onto Execution Handler so that the order can be filled

};

class FilledEvent : public Event{
// Order has been successfully/unsuccessfully filled
	public:
		virtual void		handleEvent(void){}; // Update the currently held portfolio to reflect the order that was filled - note it is also possible an order fails to be filled - you need to deal with this

};

class FactorEvent : public Event{
// Factor Target Portfolio determined
	public:
		virtual void		handleEvent(void){}; // Pass information that the factor portfolio has been determined for the strategy onto risk management / portfolio optimiser
		Strategy*		strategy_ptr; // the strategy for which the target portfolio was determined
};

#endif
