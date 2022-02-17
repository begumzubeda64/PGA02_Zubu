dev.off()
setwd("C:/zubeda/PGA02_Zubu/R Programming")
library("plyr")
library("dplyr")
library("ggplot2")
df_AP <- read.csv("ADANIPORTS.csv")
edit(df_AP)
names(df_AP)
head(df_AP)    #get first 6 rows
v <- c(8, 14, 26, 5, 43)
plot(v, type="o")  #Line plot with points
plot(v, type="p")  #Points plot
plot(v, type="l")  #Line plot without points
plot(v, type="o", col="red", xlab="Month", ylab="Rainfall", main="Rainfall Chart")
v <- c(12, 14, 28, 5, 44)
t <- c(15, 8, 8, 10, 13)
plot(v, type="o", col="blue", xlab="Month", ylab="Rainfall", main="Rainfall Chart")
lines(t, type="o", col="red")
#Data - The actual variables to be plotted, Aesthetics/aes - The scales on to which we will map our data, Geometries/geom - Shapes used to represent our data
df_aapl <- read.csv("AAPL.csv")
head(df_aapl)
df_waltdisney <- read.csv("DIS.csv")
head(df_waltdisney)
df_nike <- read.csv("NKE.csv")
head(df_nike)
df_aapl <- cbind(df_aapl, Stock="")
df_waltdisney <- cbind(df_waltdisney, Stock="")
df_nike <- cbind(df_nike, Stock="")
head(df_aapl)
head(df_waltdisney)
head(df_nike)
df_aapl$Stock <- paste(df_aapl$Stock, "Bertrandt", sep="")
df_waltdisney$Stock <- paste(df_waltdisney$Stock, "Deutsche Bank", sep="")
df_nike$Stock <- paste(df_nike$Stock, "Siemens", sep="")
head(df_aapl)
head(df_waltdisney)
head(df_nike)
df_allStocks <- rbind(df_aapl, df_waltdisney, df_nike)
df_allStocks
df_allStocks$Date <- as.character(df_allStocks$Date)
datesplit_list <- strsplit(df_allStocks$Date, "-")
df_dates <- ldply(datesplit_list)
colnames(df_dates) <- c("Year", "Month", "Day")
df_allStocks <- cbind(df_allStocks, df_dates)
names(df_allStocks)
head(df_allStocks)
g <- ggplot(data=df_aapl, aes(x=Date, y=Open, group=1))  # group 1st param
g <- g + geom_line(linetype="dashed")
g
g <- ggplot(data=df_aapl, aes(x=Date, y=Open, group=1))  # group 1st param
g <- g + geom_line(linetype="dashed", col="red")
g
g <- ggplot(data=df_aapl, aes(x=Date, y=Open, group=1))  # group 1st param
g <- g + geom_line(linetype="solid", col="red", size=1.5)
g <- g + labs(title="Apple Inc", subtitle="Open Prices", y="Open", x="Year", caption="Yearwise Apple Stock")
g
options(scipen = 999)
ggplot(data=df_allStocks, aes(x=Stock, y=Volume)) +
  geom_bar(stat="identity")   #if we want heights of the bars to represent values in the data, map a value to y aes
#scipen - avoid scientific notations by giving largest limit eg. 999
ggplot(data=df_allStocks, aes(x=Stock, y=Volume)) +
  geom_bar(stat="identity") + coord_flip()   #coord_flip to create horizontal plot
ggplot(data=df_allStocks, aes(x=Stock, y=Volume)) +
  geom_bar(stat="identity", width=0.5)   #change width of bars
ggplot(data=df_allStocks, aes(x=Stock, y=Volume)) +
  geom_bar(stat="identity", width=0.5, col="blue")
ggplot(data=df_allStocks, aes(x=Stock, y=Volume, fill=Stock)) +
  geom_bar(stat="identity", width=0.5)
#fill=Stock - fill colors automatically as per the levels of the bar
ggplot(df_nike, aes(x=Open)) + geom_histogram()
ggplot(df_waltdisney, aes(x=Open)) + geom_histogram()
ggplot(df_nike, aes(x=Volume)) + geom_histogram(fill="lightblue", color="darkblue")
ggplot(df_nike, aes(x=Close)) + geom_histogram(fill="lightblue", color="darkblue")
ggplot(df_nike, aes(x=Close)) + geom_histogram(fill="lightblue", color="darkblue", binwidth=3)
ggplot(df_nike, aes(x=Open)) + 
  geom_histogram(aes(y=..density..),fill="white", colour="black") +
  geom_density(alpha=.2, fill="Turquoise")   #alpha controls the transparency
ggplot(df_nike, aes(x=Open, col=Stock)) + geom_histogram(fill="light blue", binwidth=3)
ggplot(df_allStocks, aes(x=Open, col=Stock)) + geom_histogram(fill="light blue", binwidth=3)  #Different outline color for different stock category
ggplot(df_waltdisney, aes(x=Open, y=Close)) + geom_point()
ggplot(df_nike, aes(x=Open, y=Close)) + geom_point(size=2, shape=23) + geom_smooth(method="lm")
#size - size of point, shape - shape of point (0-25), method="lm" - draw linear model (linear regression) line
ggplot(df_nike, aes(x=Open, y=Close)) + 
  geom_point(shape=18, color="dark grey") + 
  geom_smooth(method="lm", linetype="dashed", color="red")
df_midwest = read.csv("http://goo.gl/G1K41K")
dim(df_midwest)
summary(df_midwest)
ggplot(df_midwest, aes(x=area, y=poptotal)) + 
  geom_point(shape=18, color="dark grey") + 
  geom_smooth(method="lm", linetype="dashed", color="red")
ggplot(df_midwest, aes(x=area, y=poptotal)) + geom_point(shape=18, color="dark grey")+geom_smooth(method="lm", linetype="dashed", color="red") + coord_cartesian(xlim=c(0,0.1), ylim=c(0,600000))
seq(1, 20, 3)
g <- ggplot(df_midwest, aes(x=area, y=poptotal)) + 
  geom_point(size=2) + 
  geom_smooth(method="lm",col="black") + 
  coord_cartesian(xlim=c(0,0.1), ylim=c(0,1000000)) +
  labs(title="Area Vs Population", subtitle = "Using midwest dataset", y="Population", x="area", caption = "Midwest Demographics")
g + scale_x_continuous(breaks=seq(0, 0.10, 0.01))
g + scale_y_continuous(breaks=seq(0, 1000000, 50000))
g <- ggplot(df_midwest, aes(x=area, y=poptotal)) + 
  geom_point(aes(color=state), size=2) + 
  geom_smooth(method="lm",col="black") + 
  coord_cartesian(xlim=c(0,0.1), ylim=c(0,1000000)) +
  labs(title="Area Vs Population", subtitle = "Using midwest dataset", y="Population", x="area", caption = "Midwest Demographics")
g + scale_x_continuous(breaks=seq(0, 0.10, 0.01))
g + scale_y_continuous(breaks=seq(0, 1000000, 50000))
ggplot(df_allStocks, aes(x=Month, y=Close)) + geom_boxplot()
ggplot(df_allStocks, aes(x=Month, y=Close)) + geom_boxplot() + coord_flip()
ggplot(df_allStocks, aes(x=Month, y=Close, color=Month)) + geom_boxplot() + coord_flip()
ggplot(df_midwest, aes(x=state, y=poptotal)) + geom_boxplot(outlier.color = "red", outlier.shape = 1, outlier.size = 2)
ggplot(df_allStocks, aes(x=Year, y=Close)) + geom_boxplot() + facet_grid(~ Stock)
ggplot(df_allStocks, aes(x=Month, y=Close)) + geom_boxplot() + facet_grid(Stock ~ Year)
ggplot(df_allStocks, aes(x=Open)) +
  geom_histogram(color="black", fill="white") +
  facet_grid(Stock ~ .)
ggplot(df_allStocks, aes(x=Open, color=Stock)) +
  geom_histogram(fill="white") +
  facet_grid(Stock ~ .)
ggplot(df_allStocks, aes(x=Close, color=Stock)) +
  geom_histogram(fill="white") +
  facet_grid(Stock ~ ., scales="free_y")