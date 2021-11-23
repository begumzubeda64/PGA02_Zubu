/*Create database*/

create database PGA02;

use PGA02;

create table Student(
	RollNo INT,
	FullName CHAR(15), /*more than 15 truncates rest of the characters*/
	Course CHAR(12),
	Location CHAR(20)
);

select * from Student;

insert into Student values(1, 'John Doe', 'DSP', 'Banglore');
insert into Student values(2, 'Viren Shah', 'ML', 'Ahemdabad');
insert into Student values(3, 'Sachin Patil', 'PGA', 'Mumbai');

select * from hsales; /*Imported hsales dataset csv*/
select Employee_ID, First_name, Gender, Salary, Country from hsales;

create table MySales( /*Table for Imported wsales dataset csv*/
	Emp_Id INT,
    Fname CHAR(15),
    Lname CHAR(15),
    Gender CHAR(2),
    Salary INT,
    Job_Title CHAR(20),
    Country CHAR(4),
    BDate CHAR(12),
    HDate CHAR(12)
);

select * from MySales;
