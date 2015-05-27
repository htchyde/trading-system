# trading-system (DRAFT)
Algorithmic Trading System: Data Collection, Backtesting, Order Execution 

###### Repository created: 26th April 2015.

###### This document is a draft.

###### See [projectSpecification.MD](projectSpecification.MD) for the project specification.

This repository will contain the implementation of an algorithmic trading system.

Historical data is stored in a MySQL Database named "securities_master".

Some scripts written in R that scrape historical data from external sources can be found in [R/DataManagement/Scripts](R/DataManagement/Scripts).

Functions and scripts written in R from the "equity-arma-modelling" repository have been spread across the directories of this repository.
To correctly fit into the new structure of this repository significant changes need to be made.

###### Attempting to execute these scripts/functions in this repository will likely fail. 

###### This is the initial transition towards a complete trading system that is independent of any trading strategy implemented. 

See [ServerScripts/DirectoryStructurer/createRepositoryStructure](ServerScripts/DirectoryStructurer/createRepositoryStructure) for an understanding of the repository structure.

#### Implementation - Programming Language Choice

The Trading System will be implemented in a mixture of two programming languages, namely C++, R. These languages have been chosen because I have knowledge and experience with them, in addition to being free (with free libraries).
Anything that requires optimal execution speed will be written in C++ due to its high performance in this regard. C++ also doesn't have automatic garabage collection which allows us to optimise for speed further, 
many brokerage APIs are written in C++, the C++ STL provides ready-made optimised data structures/algorithms, LAPACK provides high performance linear algebra solutions for portfolio construction. Since we aren't attempting
to create high-frequency/ultra high-frequency strategies (due to the technological hardware required) we do not require super optimal speed for everything. We therefore opt to code everything else in R. This is because 
coding in C++ generally requires more lines of code to do the same thing in R (partly due to less quant specific libraries avaliable), is harder to debug and create statistical methods or time series analysis methods than in R - this all leads to relatively longer development times
in the name of increasing speed performance. We'll I'm more interested in profitability of my trading system and the effectiveness of the strategies being executed, so we drop the speed performance benefits of using C++ and gain
the benefits outlined above of using R. Overtime we may choose to optimise more and more of the trading system for speed by switching out R code for C++ code if this is the best use of our development time.
Python could be used instead of R in some places if there are better libraries/packages available for the particular strategy that you're looking to implement. The choice of language used will depend on which one has the
most robust, stress tested, space/time optimised algorithms that are of use for the particular strategy.

With all of the above said, essentially what I currently plan to do is implement the RESEARCH/BACKTESTING parts of the trading system in R and the EXECUTION/LIVE parts in C++. Note that speed performance is really important in
executing orders due to the slippage that will result from large latencies. As mentioned above, however, we may start by implementing in R and then shifting to C++ for speed optimisation. Reading more about OOP in R, I'm having
second thoughts about converting this eventually into C++. We can always use Python instead however. So it's decided that we will code everything in Python except where speed is necessary we will use C++ and strategies we may
use R or Python... Actually, I've changed my mind again. We will always use C++ unless there are better packages avaliable in Python or R.

C++ communicates with the MySQL Securities Master Database using MySQL C++ Connector, Python communicates with the MySQL SMD using MySQL Python Connector, R doesn't need to communicate directly to the SMD.
We need to be careful in choosing a Broker API so that either C++ or Python can communicate with it - either directly or through some community wrapper class such as IBPy plugin for Interactive Brokerage. 
R and Python can communicate using the RPy plugin. For data analysis in Python we will use the SciPy, NumPy and Pandas libraries. Python is great at communicating with any other system or protocol - including the internet - so
it will be our choice for data scraping. Finally, there are ways to embed C++ code into R and Python thus completing the required communications between the different languages/databases/apis. Rcpp allows R an C++ to communicate.

Final Decision: We will create strategies in R or Python (dependning on the statisitical/library needs of the strategy) and everything else will be prototyped in C++ as I have the most experience with C/C++ - so python will slow
me down. Of course, whenever necessary/beneficial we can diverge from this plan. Also I plan to learn more Python so that I become skilled enough to outspeed my development speed in C++.
