### Working with R scripts (slide X-XX) 
# Simple operations
2+4
2*3
3^4

# creating a  vector of 1 row and 5 columns. Alternative: c(1,2,3,4,5)
c(1:5)

# creating a  vector of 5 rows and 1 column
cbind(1:3)

# you can also use rbind() instead of c()
rbind(1:3)

# creating matrices. Alternative is function matrix()
cbind(1:3,1:3)
rbind(1:3,1:3)

### Functions
sqrt(64)

# taking the square root of vector. Alternative: sqrt(c(1,2,3,4,5))
sqrt(c(1:5))

### variables + operations
# storing vector in variable x (aka object)
x <- c(1:5)
x <- sqrt(c(1:5))

# showing output: variant 1 
x

# showing output: variant 2
(x <- sqrt(c(1:5)) )

# showing output: variant 2
x <- sqrt(c(1:5)); x

# operation using variable x (aka object)
x + 2

# defining a new x will overwrite the previous x
x <- 6+3

#### data sets
# create fake vectors
year <- c(2001:2010)
revenues <- sample.int(100, 10)
costs <- sample.int(10, 10)

# gather fake vectors in data frame
my_df <- data.frame(year,revenues,costs)

# view data
my_df

# extract vector / variable name from data frame
my_df$revenues

# transform variable from data and store as new variable (e.g., cost increase)
new_cost = 5 + my_df$costs

# add variable to data frame
my_df$new_cost <- new_cost 

# add variable directly to data frame
my_df$profit <- my_df$revenues - my_df$new_cost

# save data
save(my_df, file="C:/Users/Anonymouse/CERNA Dropbox/Dennis Rickert/UJ Quant/IO_Introduction_main/my_df.Rdata")

# install package rio (we usually put this in the beginning of each script)
install.packages("rio")
library("rio")

# import data set using command import from package rio (do not use backslash but instead forward slash!)
df <- import("C:/Users/Anonymouse/CERNA Dropbox/Dennis Rickert/UJ Quant/IO_Introduction_main/ice cream sales.csv")

# set working directory and load data
setwd("C:/Users/Anonymouse/CERNA Dropbox/Dennis Rickert/UJ Quant/IO_Introduction_main/")
df <- import("ice cream sales.csv")

#### graphs
install.packages("ggplot2") #https://cran.r-project.org/bin/windows/Rtools/rtools43/rtools.html
library(ggplot2)

# line graph
ggplot() + 
  geom_line(data=my_df,
            mapping=aes(x=year, y=revenues))

# dot graph
ggplot() + 
  geom_point(data=my_df,
            mapping=aes(x=year, y=revenues))

# combine both
ggplot() + 
  geom_point(data=my_df,
             mapping=aes(x=year, y=revenues)) +
  geom_line(data=my_df,
            mapping=aes(x=year, y=revenues))

# or shorter: 
ggplot(data=my_df,
       mapping=aes(x=year, y=revenues)) + 
  geom_point() +
  geom_line()

# save graph intoi working directory
ggsave("revenues.png", height=2.4,width=4)
