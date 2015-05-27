#include <iostream>
#include <queue>
#include <chrono>	// std::chrono::seconds
#include <thread>	// std::this_thread::sleep_for

#include "event.h"
#include "marketListener.h"

// Note an event-driven system allows for the events to be dealt with in the order that they were created, instead of taking the first event then pursuing all of the events that this first event generates and then finally moving onto the second event.
// We use event-driven programming because the trading system is not procedual in the sense a number of conditions (events) need to be fulfilled before it executes another part of the code and we don't know exactly where in the code all of the necessary events will be completed - hence we add an event loop listener to wait around until it hears the necessary events have occurred in order to continue.
// Also when events are always dealt in the same way, we can reduce code duplication using event-driven programming, as otherwise we would just have some if clause repeated across several parts of the code.
// IMPROVEMENT SUGGESTION: Research useful event libraries implemented by the community (or possibly in the STL?) such as libevent and use the library! 
// IMPLEMENTATION LIMITATIONS: As prototyped below (using a queue object), each event is handle on its own without knowledge of any other events - but what happens if we wanted to do something only if we got 3 buy signal events in the last 10 seconds
// or as a less relevant example what happens if we press up and right simulatenously on the keyboard - how can we treat that as a single event "up+right" instead of seperately as "up" and then as "right"?

int main(void){
	int i = 0;
	std::queue<Event> 	event_queue;
	MarketListener		market_listener;

	while(true){ // Keep waiting for new events to occur - note in this is only correct for the live execution - for backtesting we need to stop this while loop once all of the past data has been seen
		// if(no more backtesting data) then {break;}

		market_listener.getNewMarketEvents(); // Get most recent market events
		
		while(!event_queue.empty()){ // Don't get the most recent market event until all current events have been dealt with
			// Deal with all of the events in the event queue
			Event curr_event = event_queue.front();
			event_queue.pop();

			// Pass event onto whoever has to deal with it...
			curr_event.dealWithEvent(); // Polymorphic behavouir here - note if we want polymorphic behavouir we're going to need to use pointers - do we really want to do that?

		} // Event Queue is empty

		std::cout << i++ << "\n";
		std::this_thread::sleep_for(std::chrono::seconds(2)); // wait for timer to complete before getting newest market events 
	}


	return 0;
}
