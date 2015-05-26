Project Name: Trading System
Author: Jamie Hamit
Date: 26/05/15

The sole purpose of this document is to aid in the creation of the program it describes.
This document contains a description of the project requirements, actors, main-objects, interactions and the accumulation of the preceeding to create class diagrams.
This document will be continually updated alongside the iterative growth of program; it doesn't have to be perfect and complete first time - only to provide enough to serve its sole purpose of aiding the completion of the program.

We use the nemonic RAMIC to structure the object-orientated design process of this program. Note the from completing the below exercise is to end up with a class diagram to implement and then improve further.
Each part of RAMIC need not be comleted sequentially, but often it will help to bounce around each part and return to completing more details of a particular part later after considering some other part.

##### Contents
1. ** Requirements **
	* What must the application do?
	* What regulations must it comply with?
	* What are the business requirements?
	* Nemonic to help answer these questions: FURPS+ (REQUIREMENT TYPES: Functional, Usability, Reliability, Performance, Supportability [ +  Design, Implementation, Interface, Physical ]) 
	* Reminder: It doesn't need to be perfect! You can leave requirement types with NA or TO BE SPECIFIED. That's OK. Remember the sole purpose of this document.
2. ** Actors **
	* Who will use/interact with the application? The users can be non-human, e.g. external computer system. Anything that communicates with application is a user.
	* How will the users interact with it?
	* Method to help answer these questions: TEST CASES (Describe the goal of a paritcular user and then how they would go about achieving it within the application.) Start with a collection of possible uses of the program THEN identify the actors involved from these uses.
3. ** Main Objects **
	* What are the fundamental objects/classes within the program?
	* Method to help answer these questions: Use the ideas from the requirement and actors specification to identify the main objects.
4. ** Interactions **
	* How do the main objects interact with one another?
	* Method to help answer these questions: Use the ideas from the requirement, actors and main objects to identify the iteractions.
5. ** Class Diagram **
	* Inheritance hierarchy of the main objects with an indication of their specific fields and methods.
 	* Method to help answer these questions: Combine the spefication of all the previous areas to draw a class diagram.
	* Keep in mind: Standard Design Patterns, Data Structures.
6. ** Final Step **
	* Use the class diagram drawn in the previous step to create a new iteration of the program and return to begining of this document.

***

##### 1. Requirements

The absolute bare necessities that you can currently think of. Specification does not include what would be a "nice" feature.

#### Functional
What features and cabilities does the program have. What does the program do?

Capabilities:
* Signal Generation: Able to create trading signals from constantly added strategies in a strategy-indepedent way
* Risk Management: Able to quantify the risk of a particular strategy/portfolio (VaR - Value at Risk) and determine  what leverage to use - Leverage optimisation (Kelly Criterion), measure sector exposures, covariance between strategies
* Execution Cost Modelling: Able to estimate the trading costs of executing a specific trade order; Able to estimate the trading cost of a strategy based on historical data;
* Portfolio Construction: Able to take the trading signals, execution cost estimates and risk analysis to construct the optimal portfolio; Create trade order executions in order to get to the target portfolio
* Trade Order Execution: Able to take trade orders and send orders to be fulfilled by the brokerage that your interfacing with; able to determine what sort of trade order to send and at what time the order should be fulfilled;
* Alpha Generation Backtesting: Able to take historical data - instead of live data - and simulate the performance of a strategy;
* Performance Analysis: Able to measure the trading costs, divergence from model predictions, draw-down/sharpe ratio measurements;
* Data Collection: Able to scrape data;
* Data Cleansing: Able to clean and correct data;

Features:
* Atleast one trading strategy that generates trading signals - we will implement the Cross-Sectional Mean Reversion Linear Long-Short Model Strategy;
* Data Storage: Masters Securities Database.

#### Usability
Examples: Help, documentation, tutorials

Documentation:
* The assumptions, methodology and mathematics of a particular trading strategy.
* Documentation of the problems involved in trying to fulfill the functional requirements, how they were solved currently in this application and why they were solved this way and why the implementation of the solution is the way it is.
* Useful information (for implementation purposes and general understanding) on Orderbook, Regulations, etc.

#### Reliability
Examples: Disaster recovery, acceptable failure rates 

* System fails less than twice a year.
* A text message, email must be sent in the event of failure so that I'm aware.
* In the event of failure no trades are executed. The portfolio must be held. 

#### Performance
Availability, capacity, resources

Examples:
Does it need to respond to an action in less than 2 seconds?
Maximum message length capatiy is 100 characters?

* TO BE SPECIFIED (Strategies used will drive performance requirements)

#### Supportability
Examples: Who mantains it? Could it be internationalised? Would it need to be internationalised?

* NOT APPLICABLE

#### Design
Examples: Must be an iPhone App. Must use a relational database.

* NOT APPLICABLE

#### Implementation
Examples: What language are you going to use? Do you need to comply to some standard or methodology?

* Implementation requirements are driven by performance requirements.

#### Iterface
Doesn't refer to user inferface but instead to any other external interfaces the program must interface with.

* Must be able to inferface with any brokerage API and easily adapted if necessary when changing to a new brokerage.

#### Physical
Examples: Needs to run on a device with a camera. Data storage minimum requirements.

* Access to internet.
* Access to Securities Master Database.
* Trading System must be easy to colocate to a new location.

### Security
* TO BE SPECIFIED

### Legal
* TO BE SPECIFIED

***

##### Actors
	* Who will use/interact with the application? The users can be non-human, e.g. external computer system. Anything that communicates with application is a user.
	* How will the users interact with the application?
	* Method to help answer these questions: TEST CASES (Describe the goal of a paritcular user and then how they would go about achieving it within the application.) Start with a collection of possible uses of the program THEN identify the actors involved from these uses.

Test Cases:
	User Objective:
	* Use the trading system to execute a collection of specified strategies in the optimal way given user constraints (maximum investment, stock universe, maximum leverage, maximum drawdown, sharpe ratio requirements, risk-appetite)
	* The strategies a trader uses should be based on some fundamental reason that it exploits combined with empirical/historical results. The trader should specify when a strategy should no longer be used.

External Actors:
* Electronic Brokerage Service: Sends market events (tick data) to Execution system.
* The Trader looking to profit from the Trading System

Internal Actors:
* Signal Generator System
* Portfolio Constructor System
* Order Creation/Sender System
* Transcation Cost Modeller System
* Execution System
* Performance Analyser
* Data Collection System
* Data Cleaning System

***

##### Main Objects
What are the main objects involved in the program?

* Market Events which encapsulate the data from the external brokerage service.

Handlers for each of the Interal Actors:
* Signal Generator System
* Portfolio Constructor System
* Order Creation/Sender System
* Transcation Cost Modeller System
* Execution System
* Performance Analyser System
* Data Collection System
* Data Cleaning System


Data Collection System:
Method 1: Given a ticker and exchange the data collector downloads all the data it can from all data vendors it is aware of and puts the data into the Securities Master Database.


Data Cleaning System:
	Method 1: Given a ticker and exchange the data cleaner corrects all missing or incorrect data from the Securities Master Database (SMD) and updates SMD with corrected data.
	Method 2: Corrects all missing or incorrect data from the Securities Master Database and updates the SMD with the corrected data. The old data should probably be deleted to remove duplicated data and information stored on where the information is from and where it has been "corrected" or filled with a missing value. But we will err on the side of caution and not delete the dirty vendor data as it could conceivably be useful later.
	We will use a simple technique of filling the missing data with previous values. Warnings need to be made when there is a long sequence of missing data, which should not be "corrected" and the data shouldn't be used at all for strategy implementation.
	We store a cleaned data for each price series because we don't want to reclean data every time backtest a strategy on the data. Store clean data in clean_daily_data daily in SMD.
	Error Detection/Correction Methods: Cross-validation, padding missing data, spike filtration

***

##### Interactions
How do the main objects interact with one another?

To see the interactions that will occur we go through step by step what will happen.

0) The Zeroth step is to collect and clean data.

1) First the trader specifies their requirements and constraints. These may include maximum drawdown, sharpe ratio expectations, what strategies to use, what stock universe to use, risk-apetite. Also need an optimiser function for the Portfolio Constructor to maximise.
The trading strategies to be used should be based on empircal evidence of previous success but also fundamental reasons for why it will succeed in the future. Has there been regulation changes, market changes since the backtest performance results were peformed?

2) The next step is gather the empircal evidence for each of the strategies used and to check that it is working at the moment. To do so we use hypothesis tests (which are strategy dependent) to justify the assumptions of a particular strategy.
We also gather statistics on the maximum drawdown and sharpe ratios in the past by simulating the strategy as if it was regoing through the past. Recordings of trading costs, number of trades execution, average holding periods will also be useful data.
The historical data is drip fed from the Master Security Database into the overall Trading System. The historical data is treated as a market event, which is stored in an event queue. 
This market event is then passed onto each of Signal Generators for each the trading strategies we have opted to consider using. The Singal Generator then passes on advice on whether to buy, hold or sell to Portfolio Constructor - as aswell as what PROPORTION of the allocation capital to the particular strategy should be given to each buy,hold,sell position suggested.
In the backtesting phase we are only considering using one strategy (plus the "Do nothing/hold portfolio" strategy), so the Portfolio Constructor will go all in on this strategy (if it has positive Sharpe Ratio). 
In order to determine if the expected Sharpe Ratio is positive (i.e. for the Portfolio Constructor to do its job) it will talk with the Transcation Cost Modeller who will estimate transcation costs for a particular allocation of capital to this strategy, which in an advanced implementation it will take account of predicted volatilities and the order size. Our simple transcation cost model will probably take a moving average of the slippage that had occurred up to that point and will ignore market impact. 
The Portfolio Constructor will need to keep talking to the Transcation Cost Modeller in order to optimise the property (say Sharpe Ratio) that the trader wants to optimise.
Our simple Transcation Cost Modeller will only take account of the comission cost and ignore any other transcation costs that can occur. I'm not sure how to actually implement an advanced Transcation Cost Modeller but that is not important for now.
Using the Transcation Cost Modeller, the Portfolio Constructor creates the optimal portfolio. It then creates Market Orders based on the difference between the target portfolio and the current portfolio. 
The Market Orders are passed to the Execution System that talks with the External Brokerage Service Provider and asks it to execute the trades. 
Once the External Brokerage Service Provider confirms an order has been filled the Trading System captures this event and passes it onto the Portfolio Constructor which then updates its current portfolio.
This completes the backtesting execution process but we need to becareful trades aren't repeatedly made if there is a delay in execution. To avoid this the Portfolio Constructor should only be asked to create a new target portfolio AFTER all market orders have been attempted to be executed (and either succeeded or failed to be filled). Also what's going to happen if an order fails to be filled? (We'll use MARKET ORDERS and not LIMIT ORDERS so we don't have to worry about this too much)

3) From the backtest results we calculate statistics of interest (Sharpe Ratio, Maximum Drawdown, etc), moving average covariances between strategies returns. We may also want to optimise the strategy - but you must be careful not to introduce optimisaition bias. You will want to do some sensitivity analysis in the case. For simplicity our strategies will be parameterless so that we don't need to worry about optimisation bias.

4) Once the properties of the strategy have been determined a paper forward test should be performed on each successful strategy.

5) We now have a collection of tested strategies with historical properties that we assume they will continue to have in the future. If this isn't the case the strategy needs to be temporarily paused, investigated to see what is causing the problem and either removed or adpated in response to your hypothesis to why it no longer works.

6) Note the "Do nothing/hold current portfolio" is a strategy that should be implemented and one that the Portfolio Constructor should be able to use and invest capital in. 

7) When should you stop executing a particular strategy? My method would be to see if the statistical properties of the price series continue to exhibt the behavouir you're exploiting. For example if a pair of stocks stop cointegrating according to some significance testing test results then you remove the strategy from the list of strategies you've suggested the system uses AND sell the positions that the strategy has suggested to take in the overall portfolio. The Portfolio Constructor should then redistribute the capital gained (or lost) from selling the factor portfolio suggested by the strategy amongst the other strategies.
Even if the prices behave exactly as predicted - bad transaction costs can make the strategy unprofitable - so if transcation costs aren't what were expected you may need to pause the strategy. I'm not sure how you would systemise the pausing in this case...
We would also want to stop if the current drawdown is far greater than what was seen in backtests.
Each stock (or atleast each factor portfolio) should have an individual Transcaction Cost Model. This will be used in backtests to measure the profitability and riskiness of a strategy. 
If the live transcation costs associated with a particular factor portfolio are significantly larger than the live predicted transaction costs THEN the strategy which produced that factor portfolio should be removed from the portfolio.
This is because the reason for choosing to execute the strategy was based on backtest results that are incorrect and inflated. 
The properties of a trading strategy should be tested with different transcation cost models and the critical values for which the strategy should no longer be considered could be determined. If we see these transcation costs in live trading then we no we need to remove the strategy. In fact this may not be the correct approach. The strategy itself should just hold everything in the event it sees these transaction costs appearing. The transaction cost model should be updated as it receives new information. A.k.a. use MACHINE LEARNING TECHNIQUES!


***

##### Class Diagram
To start our project we will make all of the actors very simple.

The Portfolio Constructor will simply weight each of the strategies equally (in terms of capital depoloyed in strategy). A more advanced solution would take account of the (moving average updated) covaraince between strategies and weight according to some optimisation problem (i.e. maximal sharpe ratio).

The Transcation Cost Modeller will simply only take account of commision costs and assume it takes some fixed rate.

The Data Collection System will simply collect OHLC data on Large Cap Market Indices Consituients/ETFs. 

The Order Creation/Execution System will simply execute trade orders as MARKET Orders (no Limit orders) at or near Market Open/Close, it won't do anything like break the orders up into smaller chunks (iceberg).

The Signal Generator will simply return ADVICE on whether to buy or sell a stock and pass onto the Portfolio Constructor.

The Performance Analyser will simply measure the moving-average correlations between strategies, the moving-average sharpe ratio and whether the market is behaving as expected. Also the time it takes for trade to be executed through the external brokerage service.







Data Cleaning System:
	Method 1: Given a ticker and exchange the data cleaner corrects all missing or incorrect data from the Securities Master Database (SMD) and updates SMD with corrected data.
	Method 2: Corrects all missing or incorrect data from the Securities Master Database and updates the SMD with the corrected data. The old data should probably be deleted to remove duplicated data and information stored on where the information is from and where it has been "corrected" or filled with a missing value. But we will err on the side of caution and not delete the dirty vendor data as it could conceivably be useful later.
	We will use a simple technique of filling the missing data with previous values. Warnings need to be made when there is a long sequence of missing data, which should not be "corrected" and the data shouldn't be used at all for strategy implementation.
	We store a cleaned data for each price series because we don't want to reclean data every time backtest a strategy on the data. Store clean data in clean_daily_data daily in SMD.
	Error Detection/Correction Methods: Cross-validation, padding missing data, spike filtration


Class Fields

|	Field Name					|	Description/Purpose of Class				|
|	----------------------				|	----------------------------				|					
|							|								|					
|							|								|					
|							|								|					

Class Methods

|	Method Name					|	Description/Purpose of Method				|
|	----------------------				|	----------------------------				|
|							|								|
|							|								|
|							|								|

I feel like the class diagram should actually be created alongside implementing the class in code because it will allow you to see what problems there will be. So that's what we'll do. Let's begin coding!
The most useful thing that I can take from creating this project specification is the iteractions description provided about, which made it much clearer in my head how everything will link together and also provides a guide to the order in which the program should be completed (in the same order as the progression of the steps).
