#ifndef _PORTFOLIO_H
#define _PORTFOLIO_H

#include <vector>

// Our trading system will use factor portfolios - so we won't have signals for individual stocks - but instead we have target portfolios from each factor strategy.

class Portfolio{
	public:
		
};

class FactorPortfolio{
	// Factor Portfolio getTargetPortfolio method does not care about risk concerns
	public:
		void			constructTargetPortfolio(void);
};

class MasterPortfolio{
	public:
		std::vector<FactorPortfolio> 	factor_portfolio;
		void				constructTargetPortfolio(void);	// cancel out shorts and longs from the different factor portfolios to construct to global target portfolio. We also need to then put on risk concerns on top of this and optimise the optimisation functor to weight the factor portfolios.
		void				sendTargetPortfolio(void); // pass on the target portfolio information to the Order Creation Handler Object
};


#endif
