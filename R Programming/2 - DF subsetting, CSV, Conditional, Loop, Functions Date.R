X <- matrix(c(50, 70, 40, 90, 60, 80, 50, 90, 100, 50, 30, 70), nrow = 3)
X
rowSums(X)
colSums(X)
X <- rbind(X, apply(X, 2, mean))  #Add a row and apply mean function columnswise - 2, for rowwise its 1
X
X <- cbind(X, apply(X, 1, var))   #Add a column and apply variance function rowwise - 1
X
X <- matrix(c(50, 70, 40, 90, 60, 80, 50, 90, 100, 50, 30, 70), nrow = 3)
X <- cbind(X, apply(X, 1, sd))    #Add a column and apply standard deviation function rowwise - 1
X
X <- rbind(X, apply(X, 2, max))   #Add a row and apply maximum function columnswise - 2, for rowwise its 1
X
stock_df[[1]]   #1st column
stock_df[[2]]   #2nd column
stock_df
stock_df[1:2, 2]
stock_df[1:3, 1:2]
stock_df[, 1:2]
stock_df[c(1, 3), 1:2]
stock_df[-1, 1]
stock_df[-c(1, 3), 1:2]
v_sub <- stock_df[1:3, 2]
v_sub
df_subsetdata <- stock_df[1:3, 2, drop=F]
df_subsetdata
class(v_sub)
class(df_subsetdata)
setwd("C:/zubeda/PGA02_Zubu/R Programming")  #Set current working directory
housing_df <- read.csv("Housing.csv")
housing_df
dim(housing_df)  #no. of rows, no. of columns
filter_df <- housing_df[housing_df$price > 10000000, ]
filter_df
filt_df <- housing_df[housing_df$area > 6000, ]
filt_df
price <- 5
if(price > 5) {
  print("Sell the stock")
} else {
  print("Buy the stock")
}
source("Conditional.R")
stock_df
stock_df$BuyOrSell <- ifelse(stock_df$`Close Price` < 80, "Buy", "Sell")
stock_df
for (x in 1:10) { print(x ^ 2) } #i raised to 2
mtcars   #inbuilt dataset
iris     #inbuilt dataset
names(mtcars)  #variable/column names
for (c in names(mtcars)) { print(c) }
price <- 12.99
while (price < 15) {
  price <- price + 1
  print(price)
}
check_price <- function(x) {
  if(x > 110) {
    print("Price beyond threshold")
  } else {
    print("Price within threshold")
  }
}
check_price(200)
myvect <- c(10, 20, 30, NA, 60, 80)
mean(myvect)
sd(myvect)
min(myvect)
mean(myvect, na.rm = TRUE)
stock_price <- c(10, 5, 20, 15, 12, 22)
matrix_form <- matrix(stock_price, ncol = 2, byrow = TRUE)
matrix_form
apply(matrix_form, 1, sum)
apply(matrix_form, 2, sum)
lapply(1:3, function(x) x ^ 2)  #Returns list
sapply(1:3, function(x) x ^ 2)  #Returns vector
l <- lapply(1:3, function(x) x ^ 2) 
class(l)
s <- sapply(1:3, function(x) x ^ 2)  
class(s)
#Initial Date: 1/1/1970
purchase_on <- 365
class(purchase_on) <- "Date"  #Convert to Date & Adds 365 days to the default date
purchase_on
purchase_on <- -10
class(purchase_on) <- "Date"  #Convert to Date & Subtracts 10 days from the default date
purchase_on
purchase_date <- as.Date(365, origin=as.Date("2015-03-31"))  #365 days added to origin date
purchase_date
sale_date <- as.Date(-10, origin=as.Date("2015-02-10"))      #10 days subtracted from origin date
sale_date
format(sale_date, "%Y")
format(sale_date, "%m")
format(sale_date, "%b")
format(sale_date, "%B")
Sys.Date()
format(Sys.Date(), "%d/%m/%Y")
as.Date("2021/02/04", format="%Y/%m/%d")   #convert a format of date to date type
as.Date(purchase_date) > as.Date(sale_date)
as.Date(purchase_date) < as.Date(sale_date)
first_date <- "2020-05-16"
second_date <- "2020-12-24"
as.Date(first_date) > as.Date(second_date)
as.Date(first_date) < as.Date(second_date)
dim(housing_df)
str(housing_df)
summary(housing_df)