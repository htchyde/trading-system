#include <iostream>
#include <queue>
#include <vector>	// Think carefully about what data structure is approriate - do you want to use list or vector?
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
	std::queue< std::unique_ptr<Event> > 	event_queue; // ptr because we need polymorphic behaviour - all events should be created on the heap - this is necessary for extended scope reasons - unique pointers help with memory management issues and also it will mean the events can't be duplicated which could cause big problems if the same event gets added to the queue multiple times.
	
	// Declare the strategies you want to deploy:
	// Note we will have to turn off the whole system if we want to add a new strategy and then restart the system - one alternative solution would be to have a Strategy Event and Startegy Listener Object and somehow make it aware of the address to where the new strategy code is (or an old one we chose not to deploy earlier for some reason - maybe we were fixing bugs). We may also want an event to remove a strategy from the list of strategies to deploy..
	HoldAllStrategy				strategy_1;
	CrossSectionalMeanReversionStrategy	strategy_2;

	// Store list of strategies to be deployed in a list:		
	//std::vector<std::unique_ptr<Strategy>>	strategy_universe;		// I'm not sure if we can push the addresses of objects into unique_ptr objects without consequences. I need to study how it will behave when things get deleted. A concern is what should we do in the case we want to mix pointers to objects on the heap and stack and put into this vector of unique ptrs? But why would we ever need to allocate memory on the heap for a strategy? That doesn't seem like something we would ever want to do... With all the concerns I have in my head, the clearest way to avoid all problems with memory management would be to only create Strategy dervived objects on the stack. So that's what we'll do for now.

	//std::vector<Strategy*> strategy_universe;
	//strategy_universe.push_back(&strategy_1);
	//strategy_universe.push_back(&strategy_2);

	Strategy* strategy_arr[ ] = {&strategy_1, &strategy_2};
	std::vector<Strategy*> strategy_universe(strategy_arr, strategy_arr + sizeof(strategy_arr)/sizeof(Strategy*)); // WARNING: For memory management purposes it is essential all Strategy Derived Objects with references stored in strategy_universe are created on the stack and not the heap
	

	// Listen for the Market Events that the strategies need to know about 
	MarketListener		market_listener = MarketListener(strategy_universe);

	// Keep waiting for new events to occur - note in this is only correct for the live execution - for backtesting we need to stop this while loop once all of the past data has been seen
	while(true){
		// for backtesting version of system we need to have the following line: if(no more backtesting data) then {break;}

		std::queue< std::unique_ptr<Event> > new_market_events = market_listener.getNewMarketEvents();
		while(!new_market_events.empty()){
			event_queue.push(std::move(new_market_events.front()));
			new_market_events.pop();
		}

		while(!event_queue.empty()){ // Don't get the most recent market event until all current events have been dealt with
			// Deal with the first event in the event queue
			std::unique_ptr<Event> curr_event = std::move(event_queue.front());
			event_queue.pop(); // remove the null_ptr now stored in the front of the queue

			//curr_event.dealWithEvent(); // Polymorphic behavouir here - note if we want polymorphic behavouir we're going to need to use pointers - do we really want to do that?
			// There is an issue with attempting to dealWithEvents using polymorphic behavouir. As the arguements of dealWithEvent isn't void and in fact will depend on the event that is being dealt with. We could pass everything possible and having redudancy in doing so but that isn't very efficient. Hence we will need to use a switch-like behavouir instead with all of the arguements the dealWithEvent function in scope within this while loop. Though the resulting code won't be as modular or pretty, I currently can't see an efficient alternative.
			// OK. I've thought of a way - though it may not be great for performance. We can encapsulate the information an event needs when creating the event object. Then it will have the information it needs.

			curr_event->handleEvent();	// polymorphic behavouir here // note this action can cause more events to be created which won't be immeidately dealt with - therefore to increase the scope of the events to outside the current loop the events must be created on the heap
			// need to make sure curr_event isn't the null_ptr or else it won't know what to do when the handleEvent() method is called.

		} // Event Queue is empty

		std::cout << i++ << "\n";
		std::this_thread::sleep_for(std::chrono::seconds(2)); // wait for timer to complete before getting newest market events 

	} // All of the previous events have been dealt with. So get new market events.


	return 0;
}
