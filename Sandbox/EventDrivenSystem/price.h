// =============================================================================
// header guard
#ifndef _PRICE_H
#define _PRICE_H

// =============================================================================
// class definition
// open, high, low, close; // Note I want the price data type to be exact by using integers to represent decimal numbers up to a certain precision that is suitable for stock prices... look for a suitable library for this purpose... // We should actually use a derived class such as PoundPrice to specificy the currency... union structure may be useful here...

class Price{
	public:
		double 		quantity;
//		void 		convertToDifferentCurrency(...);
				Price(double quantity) : quantity(quantity){ };
};

#endif
