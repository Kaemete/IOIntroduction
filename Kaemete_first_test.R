# Test

#install.packages("readr")
library("readr")

ice_cream_sales <- read_csv("IOIntroduction/ice cream sales.csv")

str(ice_cream_sales)

head(ice_cream_sales)

plot(p ~ q, data = ice_cream_sales)