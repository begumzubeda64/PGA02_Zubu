setwd("C:/zubeda/PGA02_Zubu/R Programming")
#Q1)
#II. Create a vector of length 4 using seq() function and showcase how to access the elements using numeric indexes, logical indexes and character indexes.
v <- seq(11, 15, length.out=4)   #returns 4 numbers, including 1st, last and middle numbers averaged if numbers are more then limit
v
v[1]
v[3]
v[c(2, 4)]
v[c(TRUE, FALSE, TRUE, FALSE)]
names(v) <- c("el1", "el2", "el3", "el4")
v
v["el1"]
y <- c("Mumbai"=400, "Delhi"=100, "Chennai"=300, "Kolkata"=200)
y
y["Chennai"]
y["Mumbai"]

#I.	Load the in-built dataset called trees, that consists of measurements of the girth, height, and volume of 31 black cherry trees and display rows where height is greater than 82
?trees
trees
dim(trees)
nrow(trees)
ncol(trees)
summary(trees)
names(trees)
str(trees)
trees[trees$Height > 82,]

#Q2) For the 'StudentsPerformance' dataset, perform the following tasks:
#I.	Analyze the student's performance in exams and write your own observations about the students and plot the results
#II.	Create a function to remove outliers using the IQR method

#Function definition such that outliers of passed columns are removed
students <- read.csv("StudentsPerformance.csv")
#Get Dimensions
nrow(students)
ncol(students)
#Get data types
str(students)
#rename column names with new column names
namesOfColumns <- c("Gender", "Race", "Parent_Education", "Lunch", "Test_Prep", "Math_Score", "Reading_Score", "Writing_Score")
colnames(students) <- namesOfColumns
colnames(students)
summary(students)  #Summary statistics of numeric variable

#Obervations
#1. There are more females than males
#2. Group C has the largest number of members
#3. some college and associates degree are the most frequently occuring #parental levels of education
#4. most students have a standard lunch
#5. most students have not completed the test prep course
#6. the scores for math, reading and writing are on the same scale 0-100

remove_outliers <- function(x, na.rm=TRUE, ...) {
  qnt <- quantile(x, probs=c(.25, .75), na.rm=na.rm, ...)
  H <- 1.5 * IQR(x, na.rm = na.rm)
  y <- x
  y[x < (qnt[1] - H)] <- NA
  y[x > (qnt[2] + H)] <- NA
  y
}
#Combine columns categorical cols as it is, and last 3 cols with outliers removed
performance_data <- cbind(students[1:5], apply(students[6], 2, remove_outliers), apply(students[7], 2, remove_outliers), apply(students[8], 2, remove_outliers))
performance_data
dim(performance_data)
sum(is.na(performance_data))   # Sum of null values
performance_1 <- na.omit(performance_data)
performance_1
nrow(performance_1)
library(ggplot2)
Data <- performance_1

plot1 <- 
  ggplot() +
  geom_bar(data = Data, aes(x = Gender), width = 0.2, fill = "green") +
  geom_text(stat='count', data = Data, aes(x = Gender, label=..count..), vjust=-0.2) +
  theme_bw() +
  xlab("Gender") +
  ylab("Number of Students") +
  theme_classic() +
  ggtitle("Number of Students by Gender") +
  scale_fill_brewer(type = "qual", palette = 1, direction = 1,
                    aesthetics = "fill") +
  ylim(0, 600)

plot1

#There are more 510 female students and 478 male students.

#Students By race:
plot2 <- ggplot() +
  geom_bar(data = Data, aes(x = Race), width = 0.6, fill = "green") +
  geom_text(data = Data, aes(x = Race, label = ..count..), stat = "count", vjust = -0.2) +
  theme_bw() +
  xlab("Race/Ethnicity") +
  ylab("Number of Students") +
  theme(
    text = element_text(family = "Tahoma")
  ) +
  theme_classic()+
  scale_fill_brewer(type = "qual", palette = 1, direction = 1,
                    aesthetics = "fill") +
  ggtitle("Number of Students by Race/Ethnicity")
plot2
#There are 316 students in group C, 261 students in group D while there are only 88 students in group A.

#Plot scores by Gender to determine if there is a different score tendency for each gender
# Math scores by Gender plot
p <- ggplot(students, aes(Math_Score)) + geom_histogram(binwidth=5, color="gray", aes(fill=Gender))
p <- p + xlab("Math Scores") + ylab("Gender") + ggtitle("Math Scores by Gender")
p

# Boxplot of scores and Test Prep by Gender
b <- ggplot(students, aes(Gender, Writing_Score, color = Test_Prep))
b <- b + geom_boxplot()
b <- b + ggtitle("Writing scores by Gender Boxplot")
b <- b + xlab("Gender") + ylab("Writing Scores")
b

# Reading scores by Gender plot
p1 <- ggplot(students, aes(Reading_Score)) + geom_histogram(binwidth=5, color="gray", aes(fill=Gender))
p1 <- p1 + xlab("Reading Scores") + ylab("Gender") + ggtitle("Reading Scores by Gender")
p1

b1 <- ggplot(students, aes(Gender, Math_Score, color = Test_Prep))
b1 <- b1 + geom_boxplot()
b1 <- b1 + ggtitle("Math scores by Gender Boxplot")
b1 <- b1 + xlab("Gender") + ylab("Math Scores")
b1

# Writing scores by Gender plot
p2 <- ggplot(students, aes(Writing_Score)) +  geom_histogram(binwidth=5, color="gray", aes(fill=Gender))
p2 <- p2 + xlab("Writing Scores") + ylab("Gender") + ggtitle("Writing Scores by Gender")
p2

b2 <- ggplot(students, aes(Gender, Reading_Score, color = Test_Prep))
b2 <- b2 + geom_boxplot()
b2 <- b2 + ggtitle("Reading scores by Gender Boxplot")
b2 <- b2 + xlab("Gender") + ylab("Reading Scores")
b2

#Conclusion :

#1. students who completed the prep class had better scores in all three tests.
#2. male students have received better scores in Math while female students in reading and writing.

#Which gender does better in tests
# To find out the result, we need to create a columns that stores average of score
performance_2 <- performance_1
performance_2$Total_score = performance_2$Math_Score + performance_2$Reading_Score +performance_2$Writing_Score
performance_2$Avg_score = round((performance_2$Total_score)/3,0)
performance_2

#comparison of avg scores - male vs female
ggplot(performance_2, aes( x= Avg_score, color = Gender))+ 
  geom_density() + 
  geom_vline( color = "red",linetype = "dashed", lwd =0.5  ,xintercept = mean(performance_2[performance_2$Gender == "female",]$Avg_score))+
  geom_vline( color = "cyan",linetype = "dashed", lwd=0.5 ,  xintercept = mean(performance_2[performance_2$Gender == "male",]$Avg_score)) +
  labs(title ="Distribution of scores by Gender", x ="Score", y = " Density")

#From the above density plot, we see that scores of female students have a higher mean than male students.

#Q3) For the given 'chinook' database, perform the following tasks:
#install.packages("DBI")
library(DBI)
#install.packages("readr")
library(readr)
#install.packages("RSQLite")
library(RSQLite)

#I.	Connect to the above database and convert all the tables into data frame
con <- dbConnect(RSQLite::SQLite(),"chinook.db")
db <- dbConnect(dbDriver("SQLite"), dbname="chinook.db")
dbListTables(db)

albums <- dbReadTable(db, "albums")
head(albums)
artists <- dbReadTable(db, "artists")
head(artists)
customers <- dbReadTable(db, "customers")
head(customers)
employees <- dbReadTable(db, "employees")
head(employees)
genres <- dbReadTable(db, "genres")
head(genres)
invoice_items <- dbReadTable(db, "invoice_items")
head(invoice_items)
invoices <- dbReadTable(db, "invoices")
head(invoices)
media_types <- dbReadTable(db, "media_types")
head(media_types)
playlist_track <- dbReadTable(db, "playlist_track")
head(playlist_track)
playlists <- dbReadTable(db, "playlists")
head(playlists)
tracks <- dbReadTable(db, "tracks")
head(tracks)

#II.	Print the different types of music available
genres$Name

#III.	List out all the artists from the entire database
artists$Name

#IV.	List out all the countries where the customer resides and plot a bar graph showing the number of customers from the respective country
unique(customers$Country)
plot2 <- 
  ggplot() +
  geom_bar(data = customers, aes(x = Country), width = 0.3, fill = "turquoise") +
  geom_text(stat='count', data = customers, aes(x = Country, label=..count..), vjust=-0.2) +
  theme_bw() +
  xlab("Country") +
  ylab("Number of Customers") +
  theme_classic() +
  theme(axis.text.x=element_text(angle=90, hjust=1)) +
  ggtitle("Number of Customers by Country") +
  scale_fill_brewer(type = "qual", palette = 1, direction = 1,
                    aesthetics = "fill")
plot2