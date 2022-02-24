# In this case study we build a linear regression model
# We use the model to predict our test data
# We check the model performance using
# RMSE metric
# We demonstrate tests for autocorrelation & heteroskedasticity
# We demonstrate VIF to detect multicollinearity

library(ggplot2)
library(dplyr)
library(broom)
library(ggpubr)
# Set your working directory. 
setwd("C:/zubeda/PGA02_Zubu/R Programming/Models")

#Importing Data
propertytrainData <- read.csv("PropertyTrainData.csv")
head(propertytrainData)
dim(propertytrainData)
summary(propertytrainData)
propertytestData <- read.csv("PropertyTestData.csv")
head(propertytestData)
dim(propertytestData)
summary(propertytestData)

#EDA ~ Assumptions
#Check for normality of dependent variable
hist(propertytrainData$Price)   
shapiro.test(propertytrainData$Price)   #Price is not normality distributed
logPrice <- log(propertytrainData$Price)
hist(logPrice)
shapiro.test(logPrice)   #Price is now normality distributed (p-value > 0.05)
propertytrainData$Logprice <- logPrice
dim(propertytrainData)
names(propertytrainData)
summary(propertytrainData)

#Check Correlation
cor(propertytrainData[, -1])  #Read all rows, skip 1st column. Use a negative index to skip the column from the left
cormat <- round(cor(propertytrainData[, -1]), 3)
cormat
write.csv(cormat, "corrmatrix.csv")

#install.packages("GGally")
library(GGally)
GGally::ggpairs(propertytrainData[, -1])   #Pairplot - histogram & lineplot
# Note we see variables which are faily correlated with log(price) 
# are Elevation, Sewer, Date & Flood
# Note we also see some of the IVs are also correlated with each other 
# like Elevation & Sea, Distance & Sea, Area & Distance and so on

# Another way to better appreciate the relationship 
# between variables is to look at scatter plot
# Lets plot log(price) and Date
plot(propertytrainData$Logprice, propertytrainData$Days)
plot(propertytrainData$Logprice, propertytrainData$Area)
#Plot shows steady increase of Logprice over Time

#Linear Regression Analysis
reg_model <- lm(Logprice ~ ., data = propertytrainData[, -1])   # . refers to rest all variables
summary(reg_model)
#White Spaces - Not significant, . - Poorly Significant(0.05-0.1), * - Average Significance(0.01-0.05), ** - Significant(0.001-0.01), *** - Highly Significant(0-0.001) (in Coefficients)

#New models without Sea, Area
reg_model1 <- lm(Logprice ~ Area+Days+Distance+Flood+Elevation+Sewer, data = propertytrainData[, -1])
summary(reg_model1)
reg_model2 <- lm(Logprice ~ Days+Distance+Flood+Elevation+Sewer, data = propertytrainData[, -1])
summary(reg_model2)

library(car)
car::vif(reg_model)   #Lower the value, relevant is the variable
car::vif(reg_model1)
car::vif(reg_model2)

#property.train1 <- subset(property.train, select=-c(Sea, Distance))
#head(property.train1)

par(mfrow=c(2, 2))  
plot(reg_model2)   #Homoscedasticity, Residuals normally distributed
par(mfrow=c(1, 1))
# Check residual vs fitted plot to check Heteroscedasticity
# If there is absolutely no heteroscedasticity, you should 
# see a completely random, equal distribution of points 
# throughout the range of X axis and a flat red line.
# In our case, 
# the red line is slightly curved and the residuals seem to 
# increase as the fitted Y values increase. 
# So, the inference here is, heteroscedasticity exists.
# Check the Residuals Vs Fitted Curve

# Alternate Check for Breusch-Pagan Test for Heteroscedasticity; 
# Ho: Homoscedasticity (Variance of residuals is constant)
# Ha: Heteroscedasticity
#install.packages("lmtest")
library(lmtest)
lmtest::bptest(reg_model)
lmtest::bptest(reg_model2)

library(e1071)
library(caret)
# How to rectify?
# Re-build the model with new predictors.
# Variable transformation such as Box-Cox transformation can also be tried instead of log price
# (Normal Distribution).
boxcoxprice <- caret::BoxCoxTrans(propertytrainData$Price)   #Normalizing Price using BoxCox Transformation
print(boxcoxprice)
propertytrainData <- cbind(propertytrainData, Newprice=predict(boxcoxprice, propertytrainData$Price))   #add predicted normalized price column
head(propertytrainData)
#Rebuild the model
reg_model22 <- lm(Newprice ~ Days+Distance+Flood+Elevation+Sewer, data = propertytrainData)
summary(reg_model22)
lmtest::bptest(reg_model22)
plot(reg_model22)

#Autocorrelation: Durbin watson Test
#H0: No Autocorrelation, Ha: Autocorrelation present
lmtest::dwtest(reg_model)     #p-vale: 0.74
lmtest::dwtest(reg_model1)    #p-vale: 0.73
lmtest::dwtest(reg_model2)    #p-vale: 0.67

#Fitting the model
predicted_salesPrice <- predict(reg_model2, newdata = propertytrainData)
predicted_salesPrice
propertytestData$PredictedPrice <- exp(predicted_salesPrice)
write.csv(propertytestData, "predictedresult.csv")

cor(propertytestData$Price, propertytestData$PredictedPrice)
plot(propertytestData$Price, propertytestData$PredictedPrice)

#install.packages("Metrics")
library(Metrics)
Metrics::rmse(propertytestData$Price, propertytestData$PredictedPrice)