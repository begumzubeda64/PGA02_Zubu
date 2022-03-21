#Q1. Write an R program to create a sequence of numbers from 20 to 50 and find the mean of numbers from 20 to 60 and the sum of numbers from 51 to 91.
seq(20, 50)
mean(20:60)
mean(seq(20, 60))
sum(51:91)
sum(seq(51, 91))

#Q2.A student scored 70 marks in English, 95 marks in Science, 80 marks in Maths and 74 marks in History. Write an R program to plot a simple bar chart displaying the scores of the given subjects.
subjects <- c("English"=70, "Science"=95, "Maths"=80, "History"=74)
barplot(subjects, col=c("aquamarine", "green", "red", "orange"))

#Q3. Write a R program to create a data frame to store the following details of 5 employees.
name <- c("Anastasia S", "Dima R", "Katherine S", "JAMES A", "LAURA MARTIN")
gender <- c("M", "M", "F", "F", "M")
age <- c(23, 22, 25, 26, 32)
desig <- c("Clerk", "Manager", "Executive", "CEO", "ASSISTANT")
ssn <- c("123-34-2346", "23-44-779", "556-24-433", "123-98-987", "679-77-576")
employees <- data.frame(name, gender, age, desig, ssn)
colnames(employees) <- c("Name", "Gender", "Age", "Designation", "SSN")
employees

#Q4. Write an R program to create a list of heterogeneous data, which includes character, numeric and logical vectors. Print the list.
l <- list(c("Male", "Female"), c(24, 25), TRUE)
l

#Q.5 Write an R program to convert a given matrix to a 1-dimensional array.
mat <- matrix(1:12, ncol=4)
mat
array(as.vector(mat))

#Q.6 Write a R program to create a list containing a given vector, a matrix, and a list and add an element at the end of the list
li <- list(c("Red", "Green", "Black"), matrix(seq(1, 11, 2), ncol=3), list("Python", "PHP", "Java"))
li
li <- append(li, 4)
li

#Q.7 Write an R program to merge two given lists into one list. 
List1= list(1, 2, 3) 
List2 = list("Red", "Green", "Black")
c(List1, List2)

#Q.8 Write an R program to convert a given data frame to a list by rows.
name <- c("Anastasia", "Dima", "Katherine", "James", "Emily", "Michael", "Matthew", "Laura", "Kevin")
score <- c(12.5, 9.0, 16.5, 12.0, 9.0, 20.0, 14.5, 13.5, 8.0)
attempts <- c(1, 3, 2, 3, 2, 3, 1, 1, 2)
qualify <- c("yes", "no", "yes", "no", "no", "yes", "yes", "no", "no")
df <- data.frame(name, score, attempts, qualify)
colnames(df) <- c("Name", "Score", "attempts", "qualify")
df
li2 <- list()
li2 <- apply(df, 1, function(x) append(li2, x))
li2

#Q.9 Write an R program to create a correlation matrix from a data frame of the same data type.
d <- data.frame(x1=rnorm(5), x2=rnorm(5), x3=rnorm(5))
d
cor(d)

#Q.10 Write an R program to rotate a given matrix 90 degrees clockwise.
mt <- matrix(1:9, ncol=3)
mt
clockwise <- function(x){ t(apply(x, 2, rev)) }
clockwise(clockwise(mt))

#Q.11 Check for missing values in the 'mtcars' data set.
sum(is.na(mtcars))

#Q.12 Check which attributes are important to determine the mpg of a car in the 'mtcars' data set.
str(mtcars)
library(caret)
reg_model1 <- lm(mpg ~ ., data=mtcars)
summary(reg_model1)
reg_model2 <- lm(mpg ~ cyl+hp+drat+wt+qsec+vs+am+gear+carb, data=mtcars)
summary(reg_model2)
reg_model3 <- lm(mpg ~ cyl+wt+qsec+wt+am+gear+carb, data=mtcars)
summary(reg_model3)
reg_model4 <- lm(mpg ~ cyl+qsec+am+wt+carb, data=mtcars)
summary(reg_model4)
reg_model5 <- lm(mpg ~ qsec+gear+wt+carb, data=mtcars)
summary(reg_model5)
reg_model6 <- lm(mpg ~ qsec+gear+wt, data=mtcars)
summary(reg_model6)
#After comparing the Adjusted R squared, Error and R squared value selecting model 5

#Q.13 Build a simple linear model to predict the mpg of a car in the 'mtcars' data set.
final_reg_model <- lm(mpg ~ qsec+gear+wt+carb, data=mtcars)
prediction <- predict(final_reg_model, newdata=data.frame(qsec=16.5, wt=2.62, gear=4, carb=4))
prediction

#Q.14 Build a logistic regression model using the glm function to know the effect of admission into graduate school. The target variable, 
#admit/don't admit, is a binary variable Use the given "binary.csv" dataset.
setwd("C:/zubeda/PGA02_Zubu/R Programming/R Exam/Dataset")
admission <- read.csv("binary.csv")
head(admission)
str(admission)
admission$rank <- as.factor(admission$rank)
logit <- glm(admit ~ gre+gpa+rank, data=admission, family="binomial")
summary(logit)

#Q.15 Use the given variables from the titanic dataset and build the decision tree on train data. Variables from dataset: survived, embarked, sex, sibsp, parch, fare
titanic <- read.csv("Titanic_data.csv")
head(titanic)
titanic_df <- titanic[, c("Survived", "Embarked", "Sex", "SibSp", "Parch", "Fare")]
head(titanic_df)
library(rpart)
library(caTools)
set.seed(123)
#Splitting dataset
split <- sample.split(titanic_df, SplitRatio=0.8)
training <- subset(titanic_df, split == TRUE)
test <- subset(titanic_df, split == FALSE)
dim(training)
dim(test)
training$Survived <- as.factor(training$Survived)
test$Survived <- as.factor(test$Survived)
#Building Decision Tree model
mtree <- rpart(Survived ~ ., data=training, method="class")
mtree

#Q.16 Create a plot to display the result of decision tree.
library(rpart.plot)
prp(mtree, faclen=0, extra=1, cex=0.8)

#Q.17 Create the confusion matrix for the above model.
prediction <- predict(mtree, newdata=test[, -1], type="class")
prediction
confusionMatrix(data=prediction, reference=test$Survived, positive="1")

#Q.18 Perform k-means clustering on USArrest dataset. Scale the data before performing clustering. 
arrests <- USArrests
head(arrests)
dim(arrests)
str(arrests)
data_standardized <- data.frame(scale(arrests))
head(data_standardized)
#Build kmeans model
km <- kmeans(data_standardized, centers=2, nstart=20)
cluster_df <- data_standardized
cluster_df$Cluster <- km$cluster
cluster_df

#Q.19 Print the cluster number for each observation and cluster size for the above k-means model.
table(cluster_df$Cluster)

#Q.20 Plot the result of the k-means cluster.
library(factoextra)
fviz_cluster(km, data=cluster_df[, -5], palette=c("aquamarine", "orange"), geom="point", ellipse.type="convex", ggtheme=theme_bw())