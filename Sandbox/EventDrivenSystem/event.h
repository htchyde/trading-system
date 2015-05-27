#ifndef _EVENT_H_
#define _EVENT_H_

// Note by using events and not going through some procedual process - dealing with the absence of certain events is more efficient (you don't call a function with null passed in and then the receipient function will need to check for null and it becomes pointless if you could of just cut off the procedure immediately. Also by using events we can EASILY make things occur only if certain other event conditions are met - if you go through several precedual functions you would need to keep track of everything in the previous functions - using flags of some kind - and it would just get really messy. That's why we're using events. As our program responds to unknown events. Events are useful whenever something may or may not occur.
// Also we will parrallise the code - so the order in which code is executed is not the same. Since we don't want to be waiting around we will have an event queue.

class Event{
	public:
		void 	dealWithEvent(void){ };
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

#endif
