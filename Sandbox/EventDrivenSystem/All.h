#ifndef _PORTFOLIO_H
#define _PORTFOLIO_H

#include <list>

// Our trading system will use factor portfolios - so we won't have signals for individual stocks - but instead we have target portfolios from each factor strategy.

class Portfolio{
	public:
		
};

class MasterPortfolio{
	public:
		list<FactorPortfolio> 	factor_portfolio;
		void			constructTargetPortfolio(...);	// cancel out shorts and longs from the different factor portfolios to construct to global target portfolio. We also need to then put on risk concerns on top of this and optimise the optimisation functor to weight the factor portfolios.
		void			sendTargetPortfolio(void); // pass on the target portfolio information to the Order Creation Handler Object
};

class FactorPortfolio{
	// Factor Portfolio getTargetPortfolio method does not care about risk concerns
	public:
		void			constructTargetPortfolio(...);
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

#endif
