use PGA02;

Drop table Products;

Create table Products(
	Prod_ID INT Primary Key, /* Not null, unique */
    Pname CHAR(20) Unique, /* Null and unique */
    Quantity INT Not Null,
    Price INT Default 100
);

Select * from Products;

Delete from Products;

Insert into Products values(101, 'Laptop', 2, 400000);
Insert into Products values(102, 'Desktop', 2, 400000);
Insert into Products(Prod_ID, Pname, Quantity) values(103, 'Iphone', 5);

Update Products set Prod_ID = 1001 where Prod_ID = 101;
Delete from Products where Prod_ID = 1001;

create table Supplier(
	Supp_ID INT, Name CHAR(20), 
    Prod_ID INT, 
    Foreign Key(Prod_ID) References Products(Prod_ID) on update cascade on delete cascade /*To update/delete child table on update in base table*/
);

Insert into Supplier values(501, 'Vinayak', 1001);

Select * from Supplier;

Drop table Supplier;

Create table Students(
	RollNo INT,
    SemNo INT,
    Sname CHAR(15),
    Course CHAR(10),
    Primary Key(RollNO, SemNo) /* Composite Key */
);

Select * from hsales;

Select Avg(Salary) from hsales;

/* Subquery */
Select * from hsales where Salary > ( 
	Select Avg(Salary) from hsales
);

Select Count(*) from hsales where Salary > (  /*number of employees having salary greater than avg salary */
	Select Avg(Salary) from hsales
);

/* Indexing */
Create index pidx on Products(Prod_ID);

Create unique index upidx on Products(Prod_ID); /*Create index which doesnt allow duplication*/

Show index from Products;

/*Date Functions*/
Select CURDATE(); /*yyy-mm-dd* Current date*/
Select NOW(); /*yyy-mm-dd hh:mm:ss Current date and time*/
Select DATE_FORMAT(CURDATE(), '%d/%m/%y');  /*formats curdate in dd/mm/yy*/

/*Union, Union All*/
Create table EmpMum(EmpId INT, EmpName CHAR(20), Designation CHAR(20));
Insert into EmpMum values(1, 'John', 'Manager'), (2, 'Sachin', 'Analyst'), (3, 'Siddesh', 'Developer');

Create table EmpBang(EmpId INT, EmpName CHAR(20), Designation CHAR(20));
Insert into EmpBang values(51, 'Sameer', 'HR'), (52, 'Rahul', 'Sales'), (53, 'Viren', 'Accounts');
Insert into EmpBang values(1, 'John', 'Manager');

Select * from EmpMum /*Union merges rows of tables and ignore duplicates*/
UNION
Select * from EmpBang;

Select * from EmpMum /*Union All merges rows of tables and include duplicates*/
UNION ALL
Select * from EmpBang;
