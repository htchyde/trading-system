### Cross-Sectional Mean Reversion (Trading Strategy)
The cross-sectional mean reversion trading strategy will be implemented in R in order to make use of its statistical packages.

###### Factor Portfolio Construction Method Description
The strategy looks to exploit serial anti-correlations of the relative returns of a universe of stocks that exhibts this behavouir.
In this case, by relative returns, we mean relative to the average returns across the universe of stocks.

Suppose there is a stock universe (S_1, ..., S_n) exhibting the serial anti-correlation behavouir described above. (We will use R's packages to check for this property through hypothesis/confidence testing methods.)
Let r_i be the return of buying stock S_i at market open and selling at market close on the previous trading day.
Let r be the average return of the stocks in the universe, that is let r = (1/n)*(\sigma^n_{i=1} r_i).

Let C be the total amount of capital we have to invest in the strategy.
Then on each day the market opens, we invest C_i worth of capital into stock S_i, where C_i is proportional to -(r_i - r).
Explicitly C_i = - (r_i - r)*N, where N is scaling constant defined by N = C / (\sigma^n_{i=1} |r_i - r|).

Note that the cost of creating this portfolio is zero because (\sigma^n_{i=1} C_i) = -N*(\sigma^n_{i=1} (r_i - r)) = N*(nr - nr) = 0. (Of course we've ignore transcation costs in this calculation.)
However, we would be very risk hungry to just create as many copies of this portfolio as we liked because the sum of the amount of money shorted plus the amount longed PER DAY is \sigma^n_{i=1}(|C_i|) = 1 FOR EACH COPY of the portfolio.
This is dangerous and the job of the portfolio constructor/risk mangement to solve. My simple weighted factor portfolio construction method stated in the project specification isn't going to be able to handle this, so we will
need to solve this problem when the time comes. An obvious (simple) solution would be to simple weight by the total amount shorted plus longed instead of weighting by the value of the portfolio. However, to execute this strategy
you will need to increase the amount invested in it every day - so we wouldn't be able to keep the weights constant... To solve this we could execute the strategy with slightly less than what it was allocated then increase it
every day till it hits its limit of capital allocation. When it reaches this point we would scale back the portfolio but selling copies of it (for zero pounds + transcation costs) and repeat the process as before.

The property we are trying to exploit is mean-reversion of the return of a stock in the universe to the average return of all the stocks in the stock universe. We need a way to know whether the stocks in a stock universe exhibt
this behavouir. To check if mean-reversion is indeed occurring we shall use the ADF test and also the Hurst Exponent tests. Another problem is we need a way of creating a mean-reverting returns stock universe. How do we go
about picking the stock universe? We need a way to systemise this picking of the stock universe. For the moment, we will ignore this important point and deal with it later.

#### Implementation Details
The strategy will be implemented in R will need to be usable by the Event Driven System. When creating a Strategy object it must keep track of what positions it is long and which positions it is short (and by how much).
That is, a Strategy needs to keep track of its factor portfolio. This is because, the buy/sell/hold decisions it needs to make is dependent on the current factor portfolio it is holding. The Strategy should have a method
that outputs its trading signals - and to make this capital investment independent - it will output what proportion (instead of exact amounts) of capital should be invested in the factor portfolio. In order for it to create
trading signals it also needs to be fed the relevant Market Events which includes the newest stock price of each of the stocks in the factor portfolios stock universe. It also clearly requires a specified stock universe to be
decided on also.

class Strategy
StrategyConstructor


***
The Strategy Object needs to be aware of its current factor portfolio holdings in terms of the proportions.
