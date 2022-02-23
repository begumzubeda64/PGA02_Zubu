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
cor(heart.data$biking, heart.data$smoking)   #independent predictors
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
#1.	Create a new dataframe with the information needed to plot the model
plotting.data <- expand.grid(biking=seq(min(heart.data$biking), max(heart.data$biking), length.out=30), 
                             smoking=c(min(heart.data$smoking), mean(heart.data$smoking), max(heart.data$smoking)))
#2.	Predict the values of heart disease based on your linear model
plotting.data$predicted.y <- predict.lm(heart.disease.lm, newdata = plotting.data)
#3.	Round the smoking numbers to two decimals
plotting.data$smoking <- round(plotting.data$smoking, digits = 2)
#4.	Change the 'smoking' variable into a factor
plotting.data$smoking <- as.factor(plotting.data$smoking)
#5.	Plot the original data
heart.plot <- ggplot(heart.data, aes(x=biking, y=heart.disease)) + geom_point()
heart.plot
#6.	Add the regression lines
heart.plot <- heart.plot +
  geom_line(data=plotting.data, aes(x=biking, y=predicted.y, color=smoking), size=1.25)
heart.plot
#7.	Make the graph ready for publication
heart.plot <-
  heart.plot +
  theme_bw() +
  labs(title = "Rates of heart disease (% of population) \n as a function of biking to work and smoking",
       x = "Biking to work (% of population)",
       y = "Heart disease (% of population)",
       color = "Smoking \n (% of population)")
heart.plot

heart.plot + annotate(geom="text", x=30, y=1.75, label=" = 15 + (-0.2*biking) + (0.178*smoking)")