#install.packages("broom")
#install.packages("ggpubr")
library(ggplot2)
library(dplyr)
library(broom)
library(ggpubr)
setwd("C:/zubeda/PGA02_Zubu/R Programming/Models")
dev.off()

#Importing Data
income.data <- read.csv("income.data.csv")
income.data
dim(income.data)
summary(income.data)

#Assumptions
hist(income.data$happiness)   #normally distributed
plot(happiness ~ income, data=income.data)   #linearity x ~ y
#Homoscedasticity or homogeneity of variance will be checked after model building

#Linear Regression Analysis
income.happiness.lm <- lm(happiness ~ income, data=income.data)
summary(income.happiness.lm)
par(mfrow=c(2, 2))  
plot(income.happiness.lm)   #Homoscedasticity, Residuals normally distributed
par(mfrow=c(1, 1))

#Visualize results
income.graph <- ggplot(income.data, aes(x=income, y=happiness)) + geom_point()
income.graph
income.graph <- income.graph + geom_smooth(method = "lm", col="black")
income.graph
income.graph <- income.graph + stat_regline_equation(label.x=3, label.y=7)  #regression line eq. y = mx + c
income.graph
income.graph + theme_bw() +
  labs(title="Reported Happiness as a function of Income", x="Income(x$10,000)", y="Happiness(1 to 10)")