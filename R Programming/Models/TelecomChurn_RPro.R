setwd("C:/zubeda/PGA02_Zubu/R Programming/Models")
library(caret)
library(broom)
library(dplyr)
library(dummy)
library(ggplot2)
library(ROCit)
library(purrr)
#install.packages("CatEncoders")
library(CatEncoders)
library(Metrics)
library(tidyverse)
library(ggrepel)
library(GGally)
library(gridExtra)
library(ipred)

#Read the data
raw_data <- read.csv("churn.csv")
head(raw_data)

#Understand & Prepare the data
dim(raw_data)
str(raw_data)
length(raw_data)
ncol(raw_data)
nrow(raw_data)
summary(raw_data)
#Label Encoding
data <- raw_data
#Saving names of categorical variables
factors <- names(which(sapply(data, is.factor)))
for(i in factors) {
  encode <- LabelEncoder.fit(data[, i])
  data[, i] <- transform(encode, data[, i])
}
head(data)
data_1 <- data[-c(1)]   #Remove CustomerID feature as it is not relevant
head(data_1)
glimpse(data_1)   #Similar to str
#Missing data
sum(is.na(data_1))
colSums(is.na(data_1))  #To know missing values in all features
#Filling Missing NA values
data_2 <- data_1 %>% mutate(TotalCharges = if_else(is.na(TotalCharges) == TRUE, median(TotalCharges, na.rm=TRUE), TotalCharges))
#na.rm = TRUE ignore missing values and calculate the mean, median...
head(data_2)
sum(is.na(data_2))
#Remove outliers
remove_outliers <- function(x, na.rm=TRUE, ...) {
  qnt <- quantile(x, probs=c(.10, .90), na.rm=na.rm, ...)
  H <- 1.5 * IQR(x, na.rm=na.rm)
  y <- x
  y[x < (qnt[1] - H)] <- NA
  y[x > (qnt[3] + H)] <- NA
  y
}
data_3 <- data_2
data_3 <- cbind(data_3[1], apply(data_3[2], 2, remove_outliers), data_3[3:4], apply(data_3[5], 2, remove_outliers), data_3[6:18], apply(data_3[19], 2, remove_outliers), data_3[20])
head(data_3)
sum(is.na(data_3))
#There are no outliers
#Visualizing features
#Explore target variable
df <- data_3
df %>% group_by(Churn) %>%
  count() %>%
  ggplot(aes(reorder(Churn, -n), n), fill=Churn) +
  geom_col(fill = c("seagreen", "steelblue")) +
  geom_text_repel(aes(label = n), size = 9) +
  coord_flip() +
  theme_minimal() +
  labs(x= NULL, y = "Frequency", title = "Dependent Variable - Churn")
#Customer partner status
ggplot(raw_data, aes(Partner, fill=Churn)) + 
  geom_bar() +
  labs(title="Customer Partner Status", x="Does the Customer have a Partner?", y="Count")
#Customer Dependents
ggplot(raw_data, aes(Dependents, fill=Churn)) + 
  geom_bar() +
  labs(title="Customer Dependents Status", x="Does the Customer have Dependents?", y="Count")
#Customer Tenure
ggplot(raw_data, aes(tenure, fill = Churn)) + 
  geom_histogram() +
  labs(title = "Customer Tenure Histogram",
       x = "Length of Customer Tenure", 
       y = "Count")
#Customer Internet Service status
ggplot(raw_data, aes(InternetService, fill = Churn)) + 
  geom_bar() +
  labs(title = "Customer Internet Service Status", 
       x = "Type of Internet Service Customer Has", 
       y = "Count")
#Customer Contract Term
ggplot(raw_data, aes(Contract, fill = Churn)) + 
  geom_bar() +
  labs(title = "Popularity of Contract Types", 
       x = "Type of Contract Customer Has", 
       y = "Count")
#Paperless Billing Status
ggplot(raw_data, aes(PaperlessBilling, fill = Churn)) + 
  geom_bar() +
  labs(title = "Paperless Billing Status", 
       x = "Does the Customer Use Paperless Billing?", 
       y = "Count")
#Customer payment method
ggplot(raw_data, aes(PaymentMethod, fill = Churn)) + 
  geom_bar() +
  labs(title = "Payment Method", 
       x = "What Payment Method does the Customer Use?", 
       y = "Count")
#Customer Monthly Charges
ggplot(raw_data, aes(MonthlyCharges, fill = Churn)) + 
  geom_histogram() +
  labs(title = "Monthly Charges Histogram",
       x = "Monthly Charge to Customer", 
       y = "Count")
Churn_df <- raw_data
Internet_Addons_df <- data.frame('Online Security'= Churn_df$OnlineSecurity, 'Online Backup'= Churn_df$OnlineBackup,
                                 'Device Protection'= Churn_df$DeviceProtection, 'Tech Support'= Churn_df$TechSupport,
                                 'Streaming TV'= Churn_df$StreamingTV, 'Streaming Movies'= Churn_df$StreamingMovies)
perc <- function(x) {
  l = length(x)
  v = length(grep("Yes", x))
  v / l * 100
}
#Percentage of yes
#grep() returns the indices of vector elements that contains the character
#Monthly charges based on Internet service
ggplot(Churn_df, aes(MonthlyCharges, fill = InternetService)) + 
  geom_histogram() +
  labs(title = "Monthly Charges Histogram By Internet Service Option",
       x = "Monthly Charge to Customer", 
       y = "Count")
#Payment Method based on Senior citizenship
ggplot(Churn_df, aes(SeniorCitizen, fill = PaymentMethod)) + 
  geom_bar(position = 'fill') +
  labs(title = "Payment Method of Seniors vs. Everyone Else", 
       x = "Is the Customer a Senior Citizen?", 
       y = "Fraction")
#Payment Method based on Internet Service
ggplot(Churn_df, aes(InternetService, fill = PaymentMethod)) + 
  geom_bar(position = 'fill') +
  labs(title = "Payment Method by Internet Service", 
       x = "Which Internet Service does the Customer Have?", 
       y = "Fraction")
#Partner based on Dependents
ggplot(Churn_df, aes(Partner, fill = Dependents)) + 
  geom_bar(position = 'fill') +
  labs(title = "Customer Dependents Status", 
       x = "Does the Customer have a Partner?", 
       y = "Fraction")
#Bivariate analysis
telco <- raw_data
ggplot(telco, aes(y= tenure, x = "", fill = Churn)) + 
  geom_boxplot()+ 
  theme_bw()+
  xlab(" ")
ggplot(telco, aes(y= MonthlyCharges, x = "", fill = Churn)) + 
  geom_boxplot()+ 
  theme_bw()+
  xlab(" ")
ggplot(telco, aes(y= TotalCharges, x = "", fill = Churn)) + 
  geom_boxplot()+ 
  theme_bw()+
  xlab(" ")
df <- raw_data
grid.arrange(
  
  ggplot(df,aes(x = MonthlyCharges, color = Churn))+ 
    geom_freqpoly(size=2)+
    theme_minimal(),
  
  ggplot(df,aes(x = TotalCharges, color = Churn))+ 
    geom_freqpoly(size=2)+
    theme_minimal(),
  
  ggplot(df,aes(x = tenure, color = Churn))+ 
    geom_freqpoly(size=2)+
    theme_minimal()
  
)
#Correlation
data_numeric <- Filter(is.numeric, data_3)
data_numeric
library(reshape2)
cormat <- round(cor(data_numeric), 2)
melted_cormat <- melt(cormat)    #dataframe is converted into long format & stretches the data frame
head(melted_cormat)    
#Heatmap
ggplot(data = melted_cormat, aes(x=Var1, y=Var2, fill=value),method = "number" , iscorr = False) + 
  geom_tile() + theme(
    axis.title.x = element_blank(),
    axis.title.y = element_blank(),
    panel.grid.major = element_blank(),
    panel.border = element_blank(),
    panel.background = element_blank(),
    axis.ticks = element_blank(),
    legend.direction = "horizontal")+
  guides(fill = guide_colorbar(barwidth = 7, barheight = 1,
                               title.position = "top", title.hjust = 0.5))
library(corrplot)
cex.before <- par("cex")
par(cex = 0.7)
corrplot(cor(data_numeric), method = "color" , is.corr = FALSE ,addCoef.col="grey", order = "AOE",number.cex= 7/ncol(data_3))
par(cex = cex.before)
table(data_3$Churn)
data_3$Churn <- ifelse(data_3$Churn == 'Yes', 1, 0)
head(data_3)
#Feature Selection
library(randomForest)
fit_rf <- randomForest(Churn ~ ., data=data_3)
importance(fit_rf)    #Generate feature importance
varImp(fit_rf)
#Plot of importance scores by random forest
varImpPlot(fit_rf)
data_selected <- subset(data_3, select=-c(PhoneService, Churn, StreamingTV))   #Selected Feature variables
head(data_selected)
table(data_3$Contract)
data_3$gender <- ifelse(data_3$gender == "Male", 1, 0)
data$Partner <- ifelse(data_3$Partner =="Yes", 1, 0)
data_3$Dependents <- ifelse(data_3$Dependents == "Yes", 1, 0)
data_3$PhoneService <- ifelse(data_3$PhoneService == "Yes", 1, 0)
data_13 <- select(data_3, select=-c('Churn'))   #Create dummy variables
dmy <- dummyVars("~.", data=data_13, fullRank=T)
dat_transformed <- data.frame(predict(dmy, newdata=data_13))
glimpse(dat_transformed)
data23 <- data_3
data_31 <- dat_transformed
data_31$Churn <- data_3$Churn
data_3 <- data_31
data3 <- subset(data_3, select=-c(Churn))
base_data <- data.frame(scale(data3))
base_data$Churn <- data_3$Churn
head(base_data)
#Standardizing Data
dmy <- dummyVars("~.", data=data_selected, fullRank=T)   #Fullrank means no deletion of cols when creating dummy
data_selected <- data.frame(predict(dmy, newdata=data_selected))
glimpse(data_selected)
data_standardized <- data.frame(scale(data_selected))
data_standardized$Churn <- data_3$Churn
head(data_standardized)
#Dimensionality Reduction
data_pca_base <- subset(data_standardized, select=-c(Churn))
data_pca <- prcomp(data_pca_base, center=TRUE, scale=TRUE)
data_with_pca <- data.frame(as.matrix(data_pca_base)%*%as.matrix(data_pca$rotation[, 0:5]))
data_with_pca$Churn <- data_standardized$Churn
head(data_with_pca)

#Base Models
dt <- sort(sample(nrow(base_data), nrow(base_data) * .8))
train <- base_data[dt, ]
test <- base_data[-dt, ]
dim(train)
dim(test)
actual <- test$Churn
#actual <- if_else(actual == 1, 0, 1)
head(actual)
table(train$Churn)
#Logistic Regression
lg_1 <- glm(factor(Churn) ~ ., data=train, family="binomial")
summary(lg_1)
#Make Predictions
prediction_lg_1 <- predict(lg_1, data.frame(test))
prediction_lg_1 <- if_else(prediction_lg_1 >= 0.5, 1, 0)
prediction_lg_1
#Performance Measure
table(prediction_lg_1)
factor(test$Churn)
factor(prediction_lg_1)
confusionMatrix(data=factor(prediction_lg_1), reference=factor(test$Churn), positive="1")
accuracy_score_lg_1 <- accuracy(actual, prediction_lg_1)
precision_score_lg_1 <- precision(actual, prediction_lg_1)
accuracy_score_lg_1
precision_score_lg_1 
#ROC Curve
library(plyr)
ROCit_base <- rocit(score=prediction_lg_1, class=actual)
plot(ROCit_base)
recall_score_lg_1 <- recall(actual, prediction_lg_1)
auc_score_lg_1 <- auc(actual, prediction_lg_1)
Model <- c("Accuracy", "Precision", "Recall", "AUC Score")
Logistic_Regression <- c(accuracy_score_lg_1 , precision_score_lg_1 ,recall_score_lg_1  , auc_score_lg_1)
Base_Models = data.frame(Model,Logistic_Regression)
Base_Models
#Decision Tree
library(rpart)
library(rpart.plot)
mtree_1 <- rpart(factor(Churn) ~ ., data=train, method="class", control=rpart.control(minsplit=20, minbucket=7, maxdepth=8, usesurrogate=2, xval=10))
summary(mtree_1)
#Make Predictions
prediction_mtree_1 <- predict(mtree_1, data.frame(test), type="class")
prediction_mtree_1
#Performance Measure
table(prediction_mtree_1)
factor(test$Churn)
factor(prediction_mtree_1)
confusionMatrix(data=factor(prediction_mtree_1), reference=factor(test$Churn), positive="1")
accuracy_score_mtree_1 <- accuracy(actual, prediction_mtree_1)
precision_score_mtree_1 <- precision(actual, prediction_mtree_1)
accuracy_score_mtree_1
precision_score_mtree_1 
#ROC Curve
ROCit_base <- rocit(score=as.numeric(prediction_mtree_1), class=actual)
plot(ROCit_base)
recall_score_mtree_1 <- recall(actual, as.numeric(prediction_mtree_1))
auc_score_mtree_1 <- auc(actual, prediction_mtree_1)
Decision_Tree <- c(accuracy_score_mtree_1 , precision_score_mtree_1 ,recall_score_mtree_1  , auc_score_mtree_1)
Base_Models$DecisionTree = data.frame(Decision_Tree)
Base_Models
#SVM
library(e1071)
#Linear
svc_1 <- svm(formula=factor(Churn) ~ ., data=train, type="C-classification", kernel="linear")
summary(svc_1)
#Make Predictions
prediction_svc_1 <- predict(svc_1, data.frame(test), type="class")
prediction_svc_1
#Performance Measure
table(prediction_svc_1)
factor(test$Churn)
factor(prediction_svc_1)
confusionMatrix(data=factor(prediction_svc_1), reference=factor(test$Churn), positive="1")
accuracy_score_svc_1 <- accuracy(actual, prediction_svc_1)
precision_score_svc_1 <- precision(actual, prediction_svc_1)
accuracy_score_svc_1
precision_score_svc_1 
#ROC Curve
ROCit_base <- rocit(score=as.numeric(prediction_svc_1), class=actual)
plot(ROCit_base)
recall_score_svc_1 <- recall(as.numeric(actual), as.numeric(prediction_svc_1))
auc_score_svc_1 <- auc(actual, prediction_svc_1)
SVM <- c(accuracy_score_svc_1 , precision_score_svc_1 ,recall_score_svc_1  , auc_score_svc_1)
Base_Models$SVM = data.frame(SVM)
Base_Models
#KNN
library(class)
prediction_knn_1 <- knn(train, test, cl=train$Churn, k=13)
prediction_knn_1
#Performance Measure
table(prediction_knn_1)
factor(test$Churn)
confusionMatrix(data=factor(prediction_knn_1), reference=factor(test$Churn), positive="1")
accuracy_score_knn_1 <- accuracy(actual, prediction_knn_1)
precision_score_knn_1 <- precision(actual, prediction_knn_1)
accuracy_score_knn_1
precision_score_knn_1 
#ROC Curve
ROCit_base <- rocit(score=as.numeric(prediction_knn_1), class=actual)
plot(ROCit_base)
recall_score_knn_1 <- recall(as.numeric(actual), as.numeric(prediction_knn_1))
auc_score_knn_1 <- auc(actual, prediction_knn_1)
KNN <- c(accuracy_score_knn_1 , precision_score_knn_1 ,recall_score_knn_1  , auc_score_knn_1)
Base_Models$KNN = data.frame(KNN)
Base_Models
#Random Forest
rf_1 = randomForest(x=train[-31], y=factor(train$Churn), ntree=500) 
summary(rf_1)
#Make Predictions
prediction_rf_1 <- predict(rf_1, data.frame(test), type="class")
prediction_rf_1
#Performance Measure
table(prediction_rf_1)
factor(test$Churn)
confusionMatrix(data=factor(prediction_rf_1), reference=factor(test$Churn), positive="1")
accuracy_score_rf_1 <- accuracy(actual, prediction_rf_1)
precision_score_rf_1 <- precision(actual, prediction_rf_1)
accuracy_score_rf_1
precision_score_rf_1 
#ROC Curve
ROCit_base <- rocit(score=as.numeric(prediction_rf_1), class=actual)
plot(ROCit_base)
recall_score_rf_1 <- recall(as.numeric(actual), as.numeric(prediction_rf_1))
auc_score_rf_1 <- auc(actual, prediction_rf_1)
Random_Forest <- c(accuracy_score_rf_1 , precision_score_rf_1 ,recall_score_rf_1  , auc_score_rf_1)
Base_Models$RandomForest = data.frame(Random_Forest)
Base_Models