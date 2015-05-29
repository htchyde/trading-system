// =============================================================================
// header guard
#ifndef _PORTFOLIO_OPTIMISER_H
#define _PORTFOLIO_OPTIMISER_H

// =============================================================================
// include dependencies
#include <vector>

// =============================================================================
// class definition
// Our trading system will use factor portfolios - so we won't have signals for individual stocks - but instead we have target portfolios from each factor strategy.

class PortfolioOptimiser{
// Given an optimiser_function, trader constrainers and the suggested target_factor_portfolios the Portfolio Optimiser constructs the optimal portfolio and passes this information on to be executed live
	public:
		double			total_capital;
		Constraints		constraints;
		Function		optimiser_function;
		vector<Portfolio>	factor_portfolios;

		Portfolio		constructTargetPortfolio(...);
		void			sendTargetPortfolio(void); // pass on the target portfolio information to the ExecutionHandler
};

class ExecutionHandler{
	// Connects to Broker API and attempts to execute trades to get from current_portfolio to target_portfolio
	// Constructs approriate orders to attempt to fill and keeps track of those which fail to fill and which successfully get filled - then passes this information on so that the everyone is aware of what the current porfolio is.

};

#endif
