#Load data
df <- iris
head(df)
str(df)
dim(df)

#Generate a random number that is 90% of the total no. of rows in dataset
ran <- sample(1:nrow(df), 0.9 * nrow(df))
ran
#Normalizing data
nor <- function(x) { (x - min(x)) / (max(x) - min(x)) }
iris_norm <- as.data.frame(lapply(df[, c(1, 2, 3, 4)], nor))   #Appling normalization function on predictors i.e. first 4 columns
summary(iris_norm)
head(iris_norm)

#Extract Training data
iris_train = iris_norm[ran,]
dim(iris_train)
head(iris_train)
#Extract Test data
iris_test = iris_norm[-ran,]
dim(iris_test)
head(iris_test)
#Extract dependent variable of train dataset
iris_target_category <- df[ran, 5]
head(iris_target_category)
#Extract dependent variable of test dataset
iris_test_category <- df[-ran, 5]
head(iris_test_category)
library(class)
#Run KNN function
pr <- knn(iris_train, iris_test, cl=iris_target_category, k=13)
pr
#Create confusion matrix
tab <- table(pr, iris_test_category)
tab
#Accuracy score
accuracy <- function(x) { sum(diag(x) / sum(rowSums(x))) * 100 }
accuracy(tab)