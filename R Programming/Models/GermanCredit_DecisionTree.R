setwd("C:/zubeda/PGA02_Zubu/R Programming/Models")

#Read the data file
data <- read.csv("german_credit.csv")
#Check attributes of data
str(data)
#Columns of data
names(data)
#Check no. of rows & columns
dim(data)
head(data)  #First 6 rows

#Make dependent variable Credibility into factor (categorical)
class(data$Creditability)
data$Creditability <- as.factor(data$Creditability)
class(data$Creditability)
class(data)

set.seed(123)   #Maintains the state
#Splitting the data into training 70% and validation 30%
dt <- sort(sample(nrow(data), nrow(data) * .7))  #Select 70% random row indices
train <- data[dt, ]   #Selected 70% rows & all the columns
val <- data[-dt, ]    #Not selected rows 30% & all the columns
#Check no.of rows in training data set
nrow(train)
#Check no.of rows in validation data set
nrow(val)
#View datasets
edit(train)
edit(val)

#Decision Tree model
library(rpart)
mtree <- rpart(Creditability ~ ., data=train, method="class", 
               control=rpart.control(minsplit=20, minbucket=7, maxdepth=10, usesurrogate=2, xval=10))
#xval = no. of cross validation
#rpart.control to group multiple parameters
#method="class" for classification
#usesurrogate dealing with missing values
mtree
#Plot tree
plot(mtree)
text(mtree)  #Add text to the plot

#Beautify tree
#install.packages("rattle")
library(RColorBrewer)
library(rattle)
library(rpart.plot)
#view1
prp(mtree, faclen=0, cex=0.8, extra=1)
#faclen = Length of factor level  names in splits
#cex = text size
#extra = Number of obs. that fall in the node
#view2 - total count of each node
tot_count <- function(x, labs, digits, varlen) {
  paste(labs, "\n\nn=", x$frame$n)
}
prp(mtree, faclen=0, cex=0.8, node.fun=tot_count)
#node.fun - function generates the text at the node labels
#Pruning
printcp(mtree)  #Provides optimal pruning based on cp value. Select one with small cross validated error(xerror).
bestcp <- mtree$cptable[which.min(mtree$cptable[,"xerror"]), "CP"]
bestcp
#Prune the tree using best cp
pruned <- prune(mtree, cp=bestcp)
#Plot pruned tree
prp(pruned, faclen=0, cex=0.8, extra=1)

#Confusion matrix (training data)
conf.matrix <- table(train$Creditability, predict(pruned, type="class"))
rownames(conf.matrix) <- paste("Actual", rownames(conf.matrix), sep = ":")
colnames(conf.matrix) <- paste("Pred", colnames(conf.matrix), sep = ":")
print(conf.matrix)
accuracy_test <- sum(diag(conf.matrix)) /sum(conf.matrix)
accuracy_test