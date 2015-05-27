// The below is just prototype code. It may not compile!

// Our trading system will use factor portfolios - so we won't have signals for individual stocks - but instead we have target portfolios from each factor strategy.
/////
#include <list>

class Portfolio{
	public:
		
}

class MasterPortfolio{
	public:
		list<FactorPortfolio> 	factor_portfolio;
		void			constructTargetPortfolio(...);	// cancel out shorts and longs from the different factor portfolios to construct to global target portfolio. We also need to then put on risk concerns on top of this and optimise the optimisation functor to weight the factor portfolios.
		void			sendTargetPortfolio(void); // pass on the target portfolio information to the Order Creation Handler Object
}

class FactorPortfolio{
	// Factor Portfolio getTargetPortfolio method does not care about risk concerns
	public:
		void			constructTargetPortfolio(...);
}



//////////////

class Strategy{
// Determines the target portfolio of the strategy given new stock price information and the current portfolio of the factor strategy.
// The target portfolio cannot depend on the amount of capital invested because we do not know that in advance - the portfolio optimiser will determine that
	public:
		Portfolio		current_portfolio; // encapsulated because the constructTargetPortfolio method needs to keep track of this constantly (presumably this is true for all strategies but this isn't necessarily the case - so you may want to remove this from the strategy base class...)
		virtual Portfolio	constructTargetPortfolio(...) = 0; // abstract method
};


class HoldAllStrategy : public Strategy{
// Do nothing / hold all positions strategy
};

class CrossSectionalMeanReversionStrategy : public Strategy{
// Cross-sectional mean reversion strategy
};

//////////////

class PortfolioOptimiser{
// Given an optimiser_function, trader constrainers and the suggested target_factor_portfolios the Portfolio Optimiser constructs the optimal portfolio and passes this information on to be executed live
	public:
		double			total_capital;
		Constraints		constraints;
		Function		optimiser_function;
		list<Portfolio>		factor_portfolios;

		Portfolio		constructTargetPortfolio(...);
		void			sendTargetPortfolio(void); // pass on the target portfolio information to the ExecutionHandler
};

class ExecutionHandler{
	// Connects to Broker API and attempts to execute trades to get from current_portfolio to target_portfolio
	// Constructs approriate orders to attempt to fill and keeps track of those which fail to fill and which successfully get filled - then passes this information on so that the everyone is aware of what the current porfolio is.

};


/////////////////

// Note by using events and not going through some procedual process - dealing with the absence of certain events is more efficient (you don't call a function with null passed in and then the receipient function will need to check for null and it becomes pointless if you could of just cut off the procedure immediately. Also by using events we can EASILY make things occur only if certain other event conditions are met - if you go through several precedual functions you would need to keep track of everything in the previous functions - using flags of some kind - and it would just get really messy. That's why we're using events. As our program responds to unknown events. Events are useful whenever something may or may not occur.
// Also we will parrallise the code - so the order in which code is executed is not the same. Since we don't want to be waiting around we will have an event queue.

class Event{

};

class MarketEvent : public Event{
// Data from the Market has been received

};

class OrderEvent : public Event{
// Order to be filled has been provided

};

class FilledEvent : public Event{
// Order has been successfully/unsuccessfully filled

};

class FactorEvent : public Event{
// Factor Target Portfolio determined

};
