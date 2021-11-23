use PGA02;

Select * from Student;
Select * from Marks;

/*
Create table Sales
as
Select * from Master where Dept = 'Sales';
Another way to create a table (Creating subset tables) */

/*Joins*/
Select Student.RollNo, Fname, Score from Student, Marks where Student.RollNo = Marks.RollNo; /* Return common data */
Select Student.RollNo, Fname, Score from Student INNER JOIN Marks ON Student.RollNo = Marks.RollNo; /* Return common data */

/*Left Join - gets all records from left table and common rows from right table*/
Select Student.RollNo, Fname, Score from Student LEFT JOIN Marks ON Student.RollNo = Marks.RollNo;

/*Right Join - gets all records from right table and common rows from leeft table*/
Select Marks.RollNo, Fname, Score from Student RIGHT JOIN Marks ON Student.RollNo = Marks.RollNo;
 
 /*Views*/
Create view myView
as
Select Student.RollNo, Fname, Score from Student INNER JOIN Marks ON Student.RollNo = Marks.RollNo;

Select * from myView;

/*Scalar function*/
Select sqrt(81);
Select pow(2,3);

/* Aggregate function*/
Select sum(Salary) from hsales;
Select avg(Salary) from hsales;
Select min(Salary) from hsales;
Select max(Salary) from hsales;
Select count(Salary) from hsales;

/*Comparison function*/
Select * from hsales where First_Name regexp '^Sh'; /* first name starting with sh*/
Select * from hsales where First_Name regexp 'an$'; /* first name ending with an*/

Create table Customers(CustomerID int, CustomerName char(20), City char(15), State char(15), Country char(15));

Insert into Customers(CustomerID,CustomerName,City,Country) values(1,'Alpha Cognac','Toulouse','France');
Insert into Customers values(2,'American Souvenirs','New Haven','CT','USA');
Insert into Customers(CustomerID,CustomerName,City,Country) values(3,'Amica Models & Co.','Torino','Italy');
Insert into Customers(CustomerID,CustomerName,City,Country) values(4,'ANG Resellers','Madrid','Spain');
Insert into Customers values(5,'Decorations Ltd.','North Sydney','NSW','Australia');
Insert into Customers(CustomerID,CustomerName,City,Country) values(6,'Anton Design Ltd.','Madrid','Spain');
Insert into Customers(CustomerID,CustomerName,City,Country) values(7,'Asian Shopping','Singapore','Singapore');

Select * from Customers;

Select CustomerName, City, Coalesce(State, 'N/A') as State, Country from Customers; /* Coalesce Fetches first not null value */

/* String function*/
Select strcmp('Hello', 'Hello');
Select strcmp('Hello', 'Hi');
Select strcmp('Hi', 'Hello');

Select Employee_ID, upper(First_Name) from hsales;
Select Employee_ID, lower(First_Name) from hsales;

Select ltrim('         Zubu'); /* leading trim remove space from start*/
Select rtrim('Zubu         '); /* railing trim remove space from end*/
Select trim('      Zub     '); /* railing trim remove space*/

Select substring('Imarticus', 2, 4); /* positions starts with 1, extract mart the start position is 2 and number of characters */
Select substring('2021-10-06', 1, 4); 

Select concat('Viren', ' ', 'Shah');
Select Employee_ID, concat(First_Name,' ', Last_Name) as Full_Name from hsales;

/*Keys or Contrainsts*/
create table Products(
	Prod_ID INT Primary Key, /* Not null, unique */
    Pname CHAR(20) Unique, /* Null and unique */
    Quantity INT Not Null,
    Price INT
);
Describe Products;
Insert into Products values(101, 'Laptop', 2, 400000);
Insert into Products values(102, 'Desktop', 2, 400000);

Insert into Products(Prod_ID, Pname, Quantity) values(103, 'Iphone', 4);

Drop table Products;

Select * from Products;

