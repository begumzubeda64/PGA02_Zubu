#install.packages('caret')
num = 10
num
library('caret')
x = 10.2
y <- 10
z = "Hello"
x
y
z
as.integer(x)
a = 1 + 10i
a
sqrt(144)
a = 5; b = 15
out = a > b
out
age <- c(21, 25, 28, 30, 20, 26)
age
id = c(1:10)  #range values from 1-10
id
seq(1, 20)
seq(2, 20, 2)   #range values from 2 to 20 with offset 2
loan_default <- c(TRUE, FALSE, FALSE, TRUE, TRUE)
loan_default
place_names <- c("China", "India", "Denmark", "UK", "Finland")
place_names
class(loan_default)
class(age)
class(z)
num_as_str <- c("10", "30", "40", "50")
class(num_as_str)
numbers <- as.integer(num_as_str)
class(numbers)
mean(numbers)
max(age)
min(numbers)
median(age)
range(numbers)
var(age)
sort(age)
sort(age, decreasing = TRUE)
random_ele <- c(15, 2.5, TRUE, "Hello")
random_ele
class(random_ele)
mat <- c(1:16)
mat <- matrix(mat, ncol=4)
mat
mat1 <- c(1:16)
mat1 <- matrix(mat1, ncol = 4, byrow = T)
mat1
matrix(c(56, 72, 25, 14, 87, 99), ncol = 3, byrow = T)
mat1[2,]
mat1[2,2]
mat1[,4]
matr = matrix(c(5:16), nrow = 3, byrow = TRUE)
column.names <- c("COL1", "COL2", "COL3")
row.names <- c("ROW1", "ROW2", "ROW3")
column.names <- c("COL1", "COL2", "COL3", "COL4")
result <- matrix(c(5:16), nrow = 3, byrow = TRUE, dimnames = list(row.names, column.names))
result
employee = list(1, c("John", "Rose"), c(12000, 15000))
employee
employee[[1]]
employee[[2]]
employee[[3]]
employee = list(EmpID=1, EmpName=c("John", "Rose"), basic_pay=c(12000, 15000))
employee
employee$EmpName
list_of_expenses <- list(100, 150, 350, 50)
class((list_of_expenses))
expenses <- unlist(list_of_expenses)
class(expenses)
length(expenses)
days_from_purchase <- c(10, 15, 20, 25)
days_from_purchase
ctf <- as.factor(days_from_purchase)
typeof(ctf)
class(ctf)
age <- c(21, 42, 28, 31, 19)
names <- c("John", "Sachin", "Rahul", "Ravi", "Sameer")
salary <- c(12000, 20000, 25000, 16000, 28000)
ownhouse <- c(TRUE, FALSE, TRUE, TRUE, FALSE)
mydf <- data.frame(names, age, salary, ownhouse)
mydf
stock_price <- c(110.55, 102.50, 145.90, 130.70, 160.45, 112.80)
stock_mat <- matrix(stock_price, ncol = 2, byrow = T)
stock_df = data.frame(stock_mat)
stock_df
colnames(stock_df) <- c("Open Price", "Close Price")
letters[1:10]
letters[1:26]
rownames(stock_df) <- letters[1:3]
stock_df
stock_df$`Close Price`