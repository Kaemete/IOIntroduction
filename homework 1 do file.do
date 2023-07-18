*** import data
*insheet using "...\homogenous\data.csv", delimiter(";") clear

// Question 1

*** summary statistics
su gr tqg lakes po

*** plotting against time. price and quantity have different units so they should not be plotted together
ge time=_n
graph twoway line gr time
graph twoway line tqg time

*** creat variables in logs
ge lntqg=ln(tqg)
ge lngr=ln(gr)

// Question 2

*** scatterplots of quantities and prices
graph twoway scatter gr tqg
graph twoway scatter lngr lntqg

*** analyze plots and correlations
corr gr tqg
corr lngr lntqg

* The choice of demand function should be based on observed dependence between price and quantity. Does this dependence appear to be linear, non-linear.
* Different functional forms can be estimated and you can check whether the error term is normally distributed or there is autocorrelation, which would suggest that alternative demand function should be used.
* Optimally, you should chekc different demand function and select the one which has the best fit.

* log-linear demand function: ln(tqg) = ln(-a0) + (a1)ln(gr) + (a2)Lt + ut

//Lt is a dummy variable equal to one if the Great Lakes are open to navigation,
//(a2) should be negative, reflecting a decrease in demand when the lake steamers are operating, and
//ut is normally distributed error term

* Alternative demand functions are (see paper by Genesove and Mullin (1998)): quadratic, linear, exponential

// Question 3

*** demand side regression
reg tqg gr lakes

reg lntqg lngr
reg lntqg lngr lakes
reg lntqg lngr lakes seas1-seas12

ivreg lntqg (lngr=po) lakes seas1-seas12
ivreg lntqg (lngr=po dm1 dm2 dm3 dm4) lakes seas1-seas12

* In the case of log-linear demand function, the elasticity of demand is the coefficient standing in front of log(price). It represents by what % demand decreases when price increases by 1%.
* The coefficient should be negative

* Estimating the model by means of OLS results in biased estimates of price coefficient and thus also elasticity of demand.
* This is because when there is an unobserved positive (negative) shock to demand, for instance, because of wheather conditions, we can expect that price increases (decreases).
* This means that price is endogenous and we need to use instrumental variables estimation to correct for this (IV estimation).
* We use entry and collusion to instrument for price. This is because collusion increases price and entry decreases price. These variables should not be correlated with unobserved demand shocks
* Because entry is a longer process and should not respond to short term shocks. Collusion was also subject to agreements between firms and should not respond to demand shocks.

// Question 4

* First order condition: price*(1+theta/a1)= MC
* when theta=1 firms collude , when theta=0 firms are price takers (perfect competition) and when 0<theta<1 firms are Cournot competitors
* a1 is the elasticity of demand and MC is marginal cost

* From this FOC we can derive our supply equation which is estimated (take logs):
* log(gr) = (bo) + (b1)log(tqg) + (b2)st + (b3)I + uit

// The parameter on price (b1) should be positive in supply estimation
// The parameter on collusion dummy b3=log(a1/(theta+a1)), where theta is conduct parameter

// Question 5

*** supply side regression
reg lngr dm1 dm2 dm3 dm4 po lntqg
ivreg lngr dm1 dm2 dm3 dm4 po (lntqg=lakes seas1-seas12), first
ivreg lngr dm1 dm2 dm3 dm4 po seas1-seas12 (lntqg=lakes), first

* Because of endogeneity of quantity in supply estimation, we should use IV estimation method
* The unobserved shock to price will also impact quantity
* We can use Lakes as instrumental variable for quantity, this is because the opening of Lakes was independent from any shocks to price (exogenous)

// Question 6

* You can transform b3=log(a1/(theta+a1)) to solve it for theta, so you can compute theta after estimating demand and supply as follows

*** conduct parameter
*theta=alpha1*(exp(-beta3)-1)

