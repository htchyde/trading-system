# trading-system (DRAFT)
Algorithmic Trading System: Data Collection, Backtesting, Order Execution 

###### Repository created: 26th April 2015.

###### This document is a draft.

This repository will contain the implementation of an algorithmic trading system.

Historical data is stored in a MySQL Database named "securities_master".

Some scripts written in R that scrape historical data from external sources can be found in [R/DataManagement/Scripts](R/DataManagement/Scripts).

Functions and scripts written in R from the "equity-arma-modelling" repository have been spread across the directories of this repository.
To correctly fit into the new structure of this repository significant changes need to be made.

###### Attempting to execute these scripts/functions in this repository will likely fail. 

###### This is the initial transition towards a complete trading system that is independent of any trading strategy implemented. 

See [ServerScripts/DirectoryStructurer/createRepositoryStructure](ServerScripts/DirectoryStructurer/createRepositoryStructure) for an understanding of the repository structure.
