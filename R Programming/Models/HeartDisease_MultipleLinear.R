library(ggplot2)
library(dplyr)
library(broom)
library(ggpubr)
setwd("C:/zubeda/PGA02_Zubu/R Programming/Models")
dev.off()

#Importing Data
heart.data <- read.csv("heart.data.csv")
heart.data
dim(heart.data)
summary(heart.data)

#Assumptions
cor(heart.data$biking, heart.data$smoking)   #autocorrelation
hist(heart.data$heart.disease)    #normally distributed
plot(heart.disease ~ biking, data=heart.data)     #linearity x ~ y
plot(heart.disease ~ smoking, data=heart.data)    #linearity x ~ y
#Homoscedasticity or homogeneity of variance will be checked after model building

#Linear Regression Analysis
heart.disease.lm <- lm(heart.disease ~ biking+smoking, data=heart.data)
summary(heart.disease.lm)
par(mfrow=c(2, 2))  
plot(heart.disease.lm)   #Homoscedasticity, Residuals normally distributed
par(mfrow=c(1, 1))

#Visualize results
plotting.data <- expand.grid(biking=seq(min(heart.data$biking), max(heart.data$biking)), smoking=seq(min(heart.data$smoking), max(heart.data$smoking)))