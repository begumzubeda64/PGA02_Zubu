setwd("C:/zubeda/PGA02_Zubu/R Programming/Models")
#Importing Dataset
dataset <- read.csv("Social_Network_Ads.csv")
head(dataset)
str(dataset)
dim(dataset)
dataset <- dataset[3:5]     #User.ID and Gender are not considered
head(dataset)
#Encoding target feature by factorizing
dataset$Purchased <- factor(dataset$Purchased, labels=c(0, 1))
class(dataset$Purchased)

#Splitting the dataset
library(caTools)
set.seed(123)
split <- sample.split(dataset$Purchased, SplitRatio=0.75)
split
training_set <- subset(dataset, split == TRUE)
test_set <- subset(dataset, split == FALSE)
dim(training_set)
dim(test_set)
#Feature scaling
training_set[-3] <- scale(training_set[-3])  #Except target feature, scale all the features
test_set[-3] <- scale(test_set[-3])
head(training_set)
head(test_set)
#Fitting SVM to training set
library(e1071)
classifier <- svm(formula=Purchased ~ ., data=training_set, type="C-classification", kernel="linear")
#Predicting the test set result
y_pred <- predict(classifier, newdata=test_set[-3])
y_pred
#Making confusion matrix
cm <- table(test_set[, 3], y_pred)
cm
#Visualizing results
# Download package tarball from CRAN archive
#url <- "https://cran.r-project.org/src/contrib/Archive/ElemStatLearn/ElemStatLearn_2015.6.26.2.tar.gz"
#pkgFile <- "ElemStatLearn_2015.6.26.2.tar.gz"
#download.file(url = url, destfile = pkgFile)
# Install package
#install.packages(pkgs=pkgFile, type="source", repos=NULL)
# Delete package tarball
#unlink(pkgFile)
library(ElemStatLearn)
# Plotting the training data set results
set = training_set
X1 = seq(min(set[, 1]) - 1, max(set[, 1]) + 1, by = 0.01)
X2 = seq(min(set[, 2]) - 1, max(set[, 2]) + 1, by = 0.01)

grid_set = expand.grid(X1, X2)
#expand.grid() - Create a data frame from all combinations of the supplied vectors or factors.
colnames(grid_set) = c('Age', 'EstimatedSalary')
y_grid = predict(classifier, newdata = grid_set)

plot(set[, -3],
     main = 'SVM (Training set)',
     xlab = 'Age', ylab = 'Estimated Salary',
     xlim = range(X1), ylim = range(X2))

contour(X1, X2, matrix(as.numeric(y_grid), length(X1), length(X2)), add = TRUE)
#Create a contour plot, or add contour lines to an existing plot

points(grid_set, pch = '.', col = ifelse(y_grid == 1, 'coral1', 'aquamarine'))
#points is a generic function to draw a sequence of points at the specified coordinates. The specified character(s) are plotted, centered at the coordinates.

points(set, pch = 21, bg = ifelse(set[, 3] == 1, 'green4', 'red3'))
#Plotting the test set results
set = test_set
X1 = seq(min(set[, 1]) - 1, max(set[, 1]) + 1, by = 0.01)
X2 = seq(min(set[, 2]) - 1, max(set[, 2]) + 1, by = 0.01)

grid_set = expand.grid(X1, X2)
colnames(grid_set) = c('Age', 'EstimatedSalary')
y_grid = predict(classifier, newdata = grid_set)

plot(set[, -3], main = 'SVM (Test set)',
     xlab = 'Age', ylab = 'Estimated Salary',
     xlim = range(X1), ylim = range(X2))

contour(X1, X2, matrix(as.numeric(y_grid), length(X1), length(X2)), add = TRUE)

points(grid_set, pch = '.', col = ifelse(y_grid == 1, 'coral1', 'aquamarine'))

points(set, pch = 21, bg = ifelse(set[, 3] == 1, 'green4', 'red3'))