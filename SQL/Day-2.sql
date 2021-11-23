use PGA02;

Select * from hsales;

Select Employee_ID, First_Name, Salary, Gender, Country from hsales;

Select Employee_ID, First_Name, Salary, Gender, Country from hsales where Gender = 'F';
Select Employee_ID, First_Name, Salary, Gender, Country from hsales where Salary > 100000;

Select Employee_ID, First_Name, Salary, Gender, Country from hsales where Gender = 'M' and Country = 'AU';
Select Employee_ID, First_Name, Salary, Gender, Country from hsales where Gender = 'M' or Country = 'AU'; /* OR - Row returned if atleast one or more conditions are satisfied*/

Select DISTINCT Designation from hsales; /*DISTINCT - Unique rows for columns fetched*/

/*Alias*/
Select AVG(Salary) as Avg_Sal from hsales;
Select *, Salary*.1 as Bonus from hsales; /* all columns + 10% salary */

/* Order By*/
Select * from hsales order by First_Name;
Select * from hsales order by First_Name DESC;

Select * from hsales order by Salary;
Select * from hsales order by Salary DESC;

/*Group By*/
Select Gender, AVG(Salary) as Avg_Sal from hsales group by Gender;
Select Designation, COUNT(Designation) as Number_Employees from hsales group by Designation; /*Get number of employees for each designation */

/* Special Operators */
Select * from hsales where Designation IN ('Sales Rep. I', 'Sales Rep. IV', 'Sales Manager'); /* IN - Works on discrete values */
Select * from hsales where Designation NOT IN ('Sales Rep. I', 'Sales Rep. IV', 'Sales Manager');

Select * from hsales where Salary BETWEEN 50000 and 100000;
Select * from hsales where Salary NOT BETWEEN 50000 and 100000;

Select * from hsales where First_Name LIKE 's%';    /* First name starting with 's' followed by 0 or more characters */
Select * from hsales where First_Name LIKE '%n';    /* First name ending with 'n'*/
Select * from hsales where First_Name LIKE 's%n';   /* First name starting with s and ending with 'n'*/
Select * from hsales where First_Name LIKE 't_m';   /* First name having 3 chars start with t and end with m*/
Select * from hsales where First_Name LIKE 't_m%';  /* First name start with 't' follwed by one char, 'm' and n number of characters*/
Select * from hsales where First_Name LIKE 't__m%'; /* First name start with 't' follwed by two chars, 'm' and n number of characters*/

use world; /* Sample databses*/
Select * from Country;
Select * from CountryLanguage;

show databases; /* displays list of databses both hidden and unhidden db*/
describe Country; /* describe schema of the table country */

describe Student;
Select * from Student;

Insert into Student values(4, 'Rahul Sharma', 'Robotics', 'Delhi');
Insert into Student (RollNo, FullName, Location) values(5, 'Eijaz Khan', 'Noida'); /* Inserting partial row */

Select * from Student where Course IS NULL; /* Check for course having null values*/
Select * from Student where Course IS NOT NULL; /* Check for course not having null values*/
/* Note: = cannot be used to be used for comparing with null values */

Delete from Student where RollNo = 4;

Update Student set Location = 'Chennai' where RollNo = 1;

Drop table Student;

Alter table Student ADD Marks INT;
Update Student set Marks = 80;
Update Student set Marks = 90 where RollNo = 2;
Update Student set Marks = 70 where RollNo = 3;
Update Student set Marks = 100 where RollNo = 5;

Alter table Student DROP Marks;
Alter table Student MODIFY FullName VARCHAR(25);
Alter table Student CHANGE FullName Fname varchar(25);

Create table Marks(
	RollNo INT,
    Score INT
);

Insert into Marks values(1, 80), (2, 90), (3, 70), (4, 50);
Select * from Marks;
