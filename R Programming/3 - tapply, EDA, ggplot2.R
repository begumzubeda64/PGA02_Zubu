ages <- c(34, 45, 26, 32, 21)
location <- c("Urban", "Rural", "Urban", "Rural", "Urban")
tapply(ages, location, mean)    #location wise age mean
#history()           #get previous command
setwd("C:/zubeda/PGA02_Zubu/R Programming")  #Set current working directory
housing_df = read.csv("Housing.csv")
housing_df
dev.off()            #clear plot window
par(mfrow=c(2,1))    #subplots/partions of 2 rows, 1 col
#Univariate Analysis
hist(housing_df$area, col = "orange")
boxplot(housing_df$area, col = "light blue")
dev.off() 
boxplot(housing_df$area, horizontal = T, col = "light blue")
dev.off()
summary(mtcars)
#Bivariate Analysis
table(mtcars$vs, mtcars$gear)   #Frequency table/Cross table
#row index - vs, col index - gear
df_numeric_vars <- Filter(is.numeric, housing_df)   #Filter(condition, df)
names(df_numeric_vars)
df_categorical_vars <- Filter(is.factor, housing_df)
names(df_categorical_vars)
rownames(mtcars)
#?data/fn/keyword - get help documentation internally 
#??data/fn/keyword - get help documentation online 
?mtcars
?iris
counts <- table(mtcars$vs, mtcars$gear)
#Side by Side barplot
barplot(counts, main="Car Distribution by Gears and VS", xlab="Number of Gears", ylab="Frequency", col=c("darkblue", "red"), legend=rownames(counts), beside=TRUE)
dev.off()
#Stacked barplot
barplot(counts, main="Car Distribution by Gears and VS", xlab="Number of Gears", ylab="Frequency", col=c("darkblue", "red"), legend=rownames(counts), names.arg=c("3", "4", "5"))
#names.arg - label appear at the bottom of each bar
nas <- sapply(housing_df, function(X) sum(is.na(x)))   #Missing value checking
nas
missing_percent <- (nas * 100) / (nrow(housing_df))
missing_percent
colnames(mtcars)
names(mtcars)
dev.off()
library(dplyr)
library(ggplot2)
data.frame(missing_percent, variable=colnames(housing_df))%>%  #redirection operator/pipe operator for chaining commands with dependency, passing output of one to another
  ggplot(aes(variable, missing_percent)) +
  geom_bar(stat="identity") +  #height of bars to represent values in the data
  labs(x="Features", y="Percent of Missing values") +
  theme(axis.text.x=element_text(angle=90, hjust=1))
#aes(reorder(variable col, - or + the variable to be sorted)) sorts output in asc or desc order
paste("Hello", "Everybody")   #Concats elements seperated by spaces
paste("A", "1", sep="")       #Concats elements with no spaces
x <- c(32, 12, 30, 45)
labels <- c("Mumbai", "Chennai", "Pune", "Banglore")
pct <- round(x / sum(x) * 100)
lbls <- paste(labels, pct)
lbls <- paste(lbls, "%", sep="")
pct
lbls
pie(x, labels=lbls, col=rainbow(length(lbls)), main="City Pie Chart")   #rainbow(length) will generate 4 hexdecimal values
legend("topright", c("Mumbai", "Chennai", "Pune", "Banglore"), cex=0.5, fill=rainbow(length(x)))   #cex=Controls zoom of the font
legend("topright", c("Mumbai", "Chennai", "Pune", "Banglore"), cex=1, fill=rainbow(length(x)))   
#install.packages("Quandl")
library("Quandl")
#Quandl.api_key("wwKzShNWxFtrAVj1q863")
Quandl.api_key("59ScuqMQTyq1gh_TkU7Z")
df_aapl = Quandl("EOD/AAPL", collapse="daily", start_date="2014-09-01", type="raw")    #collapse daily data to monthly that is next higher hierarchy
df_waltdisney = Quandl("EOD/DIS", collapse="daily", start_date="2014-09-01", type="raw")
df_nike = Quandl("EOD/NIKE", collapse="daily", start_date="2014-09-01", type="raw")