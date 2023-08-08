insheet using "D:\cape town - pc\grzybek\teaching\2012\ECO5026S\exercizes\homogenous\dutch_coffee.csv", clear
 
* deflating prices by price index
sort year month 
generate time=_n
label var time "time period"

replace cprice=cprice/oprice
replace tprice=tprice/oprice
replace bprice=bprice/oprice 
replace wprice=wprice/oprice 
replace incom=incom/oprice

* variation in prices over time
line(qu time)
line(cprice time)
line(bprice time)
line(tprice time)
line(wprice time) 
line(incom time) 
line(oprice time) 

* summary statistics 
tabstat qu cprice tprice wprice bprice incom, s(min mean p50 max sd)
tabstat qu cprice tprice wprice bprice incom if q1==1, s(min mean p50 max sd)
tabstat qu cprice tprice wprice bprice incom if q2==1, s(min mean p50 max sd)
tabstat qu cprice tprice wprice bprice incom if q3==1, s(min mean p50 max sd)
tabstat qu cprice tprice wprice bprice incom if q4==1, s(min mean p50 max sd)

* price of coffee and consumption 
scatter cprice qu
scatter cprice qu if q1==1
scatter cprice qu if q2==1
scatter cprice qu if q3==1
scatter cprice qu if q4==1

* price of tea and consumption
scatter tprice qu

* price of coffee and labor
scatter cprice wprice

* price of coffee and price of tea
scatter cprice tprice

corr qu cprice tprice wprice bprice incom

* create  logs variables     
ge ln_qu=ln(qu)
ge ln_cprice=ln(cprice)
ge ln_tprice=ln(tprice)
ge ln_bprice=ln(bprice)
ge ln_wprice=ln(wprice)
ge ln_incom=ln(incom)

* demand regressions
regress ln_qu ln_cprice 

regress ln_qu ln_cprice q1 q2 q3
regress ln_qu ln_cprice ln_tprice q1 q2 q3
regress ln_qu ln_cprice ln_tprice ln_incom q1 q2 q3

ivreg ln_qu (ln_cprice = ln_bprice) q1 q2 q3
ivreg ln_qu (ln_cprice = ln_bprice) q1 q2 q3, first 
ivreg ln_qu (ln_cprice = ln_bprice) ln_tprice ln_incom   q1 q2 q3

* adjusted Lerner index
ge k=1.19
ge c0=4
ge eta=-0.277
ge cost=c0+k*bprice

ge Ln= (cprice-cost)/cprice  
ge Ln_adj=-eta*Ln

tabstat  Ln Ln_adj, s(min mean p50 max sd)
tabstat  Ln Ln_adj if q1==1, s(min mean p50 max sd)
tabstat  Ln Ln_adj if q2==1, s(min mean p50 max sd)
tabstat  Ln Ln_adj if q3==1, s(min mean p50 max sd)
tabstat  Ln Ln_adj if q4==1, s(min mean p50 max sd)

* estimating conduct parameter
regress  cprice cost q1 q2 q3, noconst
regress  cprice cost, noconst

* from the FOC we have: p=(eta/(eta+theta))c
* the estimate standing in front of cost
ge b=1.47

* we have b=eta/(eta+theta), which can be solved for theta
ge theta=eta*(1-b)/b
tabstat theta, s(mean)

ge n=1/theta
tabstat n, s(mean)      

*************************************************************
** linear demand Q=beta(alpha-P)
ivreg qu (cprice = bprice) incom q1 q2 q3
ivreg qu (cprice = bprice) q1 q2 q3

* adjusted Lerner index
ge eta_l=-0.015*cprice/qu
ge Ln_adj_l=-eta_l*Ln

tabstat  Ln Ln_adj_l, s(min mean p50 max sd)
tabstat  Ln Ln_adj_l if q1==1, s(min mean p50 max sd)
tabstat  Ln Ln_adj_l if q2==1, s(min mean p50 max sd)
tabstat  Ln Ln_adj_l if q3==1, s(min mean p50 max sd)
tabstat  Ln Ln_adj_l if q4==1, s(min mean p50 max sd)

* demand rotators
ge cprice_q1=cprice*q1
ge bprice_q1=bprice*q1

ge cprice_q2=cprice*q2
ge bprice_q2=bprice*q2

ge cprice_q3=cprice*q3
ge bprice_q3=bprice*q3

ge cprice_q4=cprice*q4
ge bprice_q4=bprice*q4

ivreg qu (cprice cprice_q1 = bprice bprice_q1) q1 q2 q3

* beta_L=-0.0137, alpha=0.90/0.015=60.0
* beta_H=-0.0190, alpha=0.90/0.019=47.4

ge alpha=0.90/0.015
replace alpha=0.90/0.019 if q1==1

** pricing equation
ivreg cprice alpha bprice

* theta = 0.7/0.014?
