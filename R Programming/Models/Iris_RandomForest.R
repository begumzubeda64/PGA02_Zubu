#Load dataset
data("iris")
#Structure
str(iris)
head(iris)
#Installing packages
#install.packages("caTools")       #For sampling dataset
#install.packages("randomForest")  #For implementing Random Forest Algorithm
#Loading packages
library(caTools)
library(randomForest)

#Splitting data in train and test data
dim(iris)
split <- sample.split(iris, SplitRatio = 0.7)
split
train <- subset(iris, split == "TRUE")
dim(train)
test <- subset(iris, split == "FALSE")
dim(test)
#Fitting Random Forest to train dataset
set.seed(120)
classifier_RF = randomForest(x=train[-5], y=train$Species, ntree=500)  #First 4 columns as features, Species as dependent variable
classifier_RF

#Predicting the Test set results
y_pred = predict(classifier_RF, newdata=test[-5])
#Confusion Matrix
confusion_mtx <- table(test[, 5], y_pred)
confusion_mtx
#Plotting the model
plot(classifier_RF)
#Important features
importance(classifier_RF)
#Variable importance plot
varImpPlot(classifier_RF)