cars
?cars
summary(cars)
plot(cars, col="blue", pch=20, cex=2, main="Relationship between Speed and Stopping Distance for 10 Cars", xlab="Speed in mph", ylab="Stopping Distance in feet")
set.seed(1)   #generates random numbers, gives same set of numbers (Set seed every time if we need same number)
sample(3)

mt <- matrix(1:10, ncol = 5)
mt
scale(mt, center=TRUE, scale=FALSE)

set.seed(2)   #Works like random_state from python
speed.c <- scale(cars$speed, center=TRUE, scale=FALSE)
mod1 <- lm(formula=dist ~ speed.c, data=cars)
mod1
summary(mod1)