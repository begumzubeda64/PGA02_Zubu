df <- read.csv("https://stats.idre.ucla.edu/stat/data/binary.csv")
head(df)
str(df)
dim(df)
edit(df)
sum(is.na(df))
summary(df)    
#Mean < 0.5 means more rejection of students for admission then acceptance
xtabs(~ admit + rank, data = df)   #Frequency table
table(df$admit, df$rank)   #Frequency table
df$rank <- as.factor(df$rank)
logit <- glm(admit ~ gre+gpa+rank, data=df, family="binomial")
summary(logit)

#Predicting raw data
x <- data.frame(gre=790, gpa=3.8, rank=as.factor(1))
p <- predict(logit, x)
p

x <- data.frame(gre=600, gpa=3.0, rank=as.factor(3))
p <- predict(logit, x)
p