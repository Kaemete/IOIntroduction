# import the data into a data frame, called 'cameras_raw', 

library(haven)
library(dplyr)

cameras_raw <- read_dta("differentiated/differentiated.dta")

## create population variable and save a new dataframe, 'cameras':
  
cameras <- cameras_raw %>%
  mutate(population = 0,
         population = case_when(country=="AUSTRIA" ~ 8451900,
                                country=="BELGIUM" ~ 11161600,
                                country=="BULGARIA" ~ 7284600,
                                country=="CZECH REPUBLIC" ~ 10516100,
                                country=="DENMARK" ~ 5602600,
                                country=="FRANCE" ~ 65633200,
                                country=="FINLAND" ~ 5426700,
                                country=="GERMANY" ~ 80523700,
                                country=="GREAT BRITAIN"~ 63730100,
                                country=="GREECE"~ 11062500,
                                country=="HUNGARY"~ 9908800,
                                country=="ITALY"~ 59685200,
                                country=="IRELAND"~ 4591100,
                                country=="NETHERLANDS"~ 16779600,
                                country=="POLAND"~ 38533300,
                                country=="PORTUGAL"~ 10487300,
                                country=="ROMANIA"~ 20057500,
                                country=="SLOVAKIA"~ 5410800,
                                country=="SLOVENIA"~ 2058800,
                                country=="SPAIN"~ 46704300,
                                country=="SWEDEN"~ 9555900),
         population = population/1000) %>%
  rename(Brand = brand,
         Country = country)
