#The in-built data set "mtcars" describes different models of a car with their various engine specifications. In "mtcars" data set, the transmission mode (automatic or manual) is described by the column am which is a binary value (0 or 1). We can create a logistic regression model between the columns "am" and 3 other columns - hp, wt and cyl.
mtcars
str(mtcars)
dim(mtcars)
sum(is.na(mtcars))
summary(mtcars)
xtabs(~ am + cyl, data=mtcars)
table(mtcars$am, mtcars$cyl)

cars1 <- mtcars[, c("cyl", "hp", "wt", "am")]
head(cars1)

logit <- glm(formula=am ~ cyl+hp+wt, data=cars1, family="binomial")
summary(logit)
x <- data.frame(cyl=6, hp=110, wt=3.200)
p <- predict(logit, x)
p


