/*Begum Zubeda*/

Select * from bank_customer;
Select * from bank_account_details;
Select * from bank_account_relationship_details;
Select * from bank_account_transaction;
Select * from bank_customer_export;
Select * from bank_customer_messages;
Select * from bank_interest_rate;
Select * from bank_inventory_pricing;
Select * from bank_branch_pl;
Select * from department_details;
Select * from employee_details;

use PGA02;

/*Q1. Print product, price, sum of quantity more than 5 sold during all three months.  */
Select Product, SUM(Quantity) as SumQuantity from bank_inventory_pricing 
group by Product 
having SumQuantity > 5;

/*Q2. Print product, quantity , month and count of records for which estimated_sale_price is less than purchase_cost*/
Select Product, Quantity, Month from bank_inventory_pricing 
where Estimated_sale_price < Purchase_cost;

/*Q3. Extarct the 3rd highest value of column Estimated_sale_price from bank_inventory_pricing dataset */
Select Estimated_sale_price from bank_inventory_pricing 
order by Estimated_sale_price desc limit 2,1;

Select Estimated_sale_price from (
	Select Estimated_sale_price from bank_inventory_pricing 
    order by Estimated_sale_price desc limit 3
) as temp order by Estimated_sale_price limit 1;

/*Q4. Count all duplicate values of column Product from table bank_inventory_pricing*/
Select Product, count(Product) NumberProducts from bank_inventory_pricing 
group by Product
having count(Product) > 1;

/*Q5. Create a view 'bank_details' for the product 'PayPoints' and Quantity is greater than 2 */
Create or Replace view bank_details 
AS
Select * from bank_inventory_pricing where Product = 'PayPoints' and Quantity > 2;

Select * from bank_details;

/*Q6. Update view bank_details1 and add new record in bank_details1.
-- --example(Producct=PayPoints, Quantity=3, Price=410.67) */
Insert into bank_details(Product, Quantity, Price) values('PayPoints', 3, 410.67);
Select * from bank_details;

/*Q7. Real Profit = revenue - cost  Find for which products, branch level real profit is more than the estimated_profit in Bank_branch_PL. */
Select Branch, Product, (Revenue-Cost) as RealProfit, Estimated_profit from bank_branch_pl 
where (Revenue-Cost) > Estimated_profit;

Create table Test as Select *, (Revenue-Cost) as Real_profit
from bank_branch_pl;

Select * from Test where Real_profit > Estimated_profit;

/*Q.8. Find the least calculated profit earned during all 3 periods */
Select Month, min(Revenue-Cost) as Min_Profit from bank_branch_pl 
group by Month;

/*Q.9 In Bank_Inventory_pricing, 
-- a) convert Quantity data type from numeric to character 
-- b) Add then, add zeros before the Quantity field.  */
Select Product, cast(Quantity as CHAR(10)) as Quantity from bank_inventory_pricing;
Select Product, concat('00', cast( Quantity as CHAR(10)) ) newQuantity from bank_inventory_pricing;

/*Q10. Write a MySQL Query to print first_name , last_name of the titanic_ds whose first_name Contains ‘U’ */
Select FIRST_NAME, LAST_NAME from hsales where FIRST_NAME LIKE '%u%';

/*Q11. Reduce 30% of the cost for all the products and print the products whose  calculated profit at branch is exceeding estimated_profit . */
Select Product, (Revenue - (Cost - Cost*.3)) as RealProfit, Estimated_profit from bank_branch_pl 
where (Revenue - (Cost - Cost*.3)) > Estimated_profit;

Select Product, (Revenue - (Cost*.7)) as RealProfit, Estimated_profit from bank_branch_pl 
where (Revenue - (Cost*.7)) > Estimated_profit;

/*Q12. Write a MySQL query to print the observations from the Bank_Inventory_pricing table excluding the values “BusiCard” And “SuperSave” from the column Product */
Select * from bank_inventory_pricing where Product NOT IN("BusiCard", "SuperSave");

/*Q13. Extract all the columns from Bank_Inventory_pricing where price between 220 and 300 */
Select * from bank_inventory_pricing where Price BETWEEN 220 and 300;

/*Q14. Display all the non duplicate fields in the Product from Bank_Inventory_pricing table and display first 5 records.*/
Select DISTINCT Product from bank_inventory_pricing limit 5;

/* Q15.Update price column of Bank_Inventory_pricing with an increase of 15%  when the quantity is more than 3. */
Update bank_inventory_pricing set Price = Price + (Price*.15) where Quantity > 3;

/*Q16. Show Round off values of the price without displaying decimal scale from Bank_Inventory_pricing */
Select *, round(Price, 0) Round_Price from bank_inventory_pricing; /* Price, how many decimal places*/

/*Q17.Increase the length of Product size by 30 characters from Bank_Inventory_pricing. */
Describe bank_inventory_pricing;
Alter table bank_inventory_pricing MODIFY Product CHAR(30);

/*Q18. Add '100' in column price where quantity is greater than 3 and dsiplay that column as 'new_price'  */
Select *, (Price + 100) new_price from bank_inventory_pricing where Quantity > 3;

/*Q19. Display all saving account holders have “Add-on Credit Cards" and “Credit cards" and Account_type */
Select Customer_id from bank_account_details where Account_type = "SAVINGS" and Customer_id IN (
	Select Customer_id from bank_account_details where Account_type = "Credit Card" and Customer_id IN
	(Select Customer_id from bank_account_details where Account_type = "Add-on Credit Card")
);

/*Q20.
# a) Display records of All Accounts , their Account_types, the transaction amount.
# b) Along with first step, Display other columns with corresponding linking account number, account types 
# c) After retrieving all records of accounts and their linked accounts, display the  transaction amount of accounts appeared  in another column.*/
Select t.Account_Number, r.Linking_Account_Number, r.Account_type, t.Transaction_Amount 
from bank_account_transaction as t 
Inner Join bank_account_relationship_details as r
ON t.Account_Number = r.Account_Number;

/*Q21. Display all type of “Credit cards”  accounts including linked “Add-on Credit Cards" 
# type accounts with their respective aggregate sum of transaction amount. 
# Ref: Check linking relationship in bank_transaction_relationship_details.
# Check transaction_amount in bank_account_transaction.*/
Select sum(t.Transaction_amount) as Sum_Transaction, t.Account_Number, r.Linking_Account_Number, r.Account_type
from bank_account_transaction t INNER JOIN bank_account_relationship_details as r
ON t.Account_Number = r.Account_Number
where r.Account_type IN("Add-on Credit Card", "Credit Card")
group by t.Account_Number;

Select sum(t.Transaction_amount) as Sum_Transaction, t.Account_Number, r.Linking_Account_Number, r.Account_type
from bank_account_transaction t, bank_account_relationship_details as r
where r.Account_type IN("Add-on Credit Card", "Credit Card") and t.Account_Number = r.Account_Number
group by t.Account_Number;

/*Insert into bank_account_relationship_details values(NULL,'9000-1700-7777-4321',"Credit Card",'5000-1700-9800'),
(NULL,'5900-1900-9877-5543',"Add-on Credit Card",'9000-1700-7777-4321'),
(NULL,'5800-1700-9800-7755',"Credit Card",'4000-1956-5698'),
(NULL,'5890-1970-7706-8912',"Add-on Credit Card",'5800-1700-9800-7755');*/

/*Q.22 Compare the aggregate transaction amount of current month versus aggregate transaction with previous months.
# Display account_number, transaction_amount , 
-- sum of current month transaction amount ,
-- current month transaction date , 
-- sum of previous month transaction amount , 
-- previous month transaction date.*/
Select avg(Transaction_amount) as AVG_Transaction, sum(Transaction_amount) as Sum_Transaction, month(Transaction_date) as Transaction_month from bank_account_transaction
group by month(Transaction_date)
order by Transaction_date desc;

/*Q23. Display individual accounts absolute transaction of every next  month is greater than the previous months .*/
Select t1.Account_Number, abs(t1.Transaction_amount) as Abs_Transaction_amount, t1.Transaction_date from bank_account_transaction t1
where t1.Account_Number IN (
	Select t2.Account_Number from bank_account_transaction t2
    where month(t1.Transaction_date) < month(t2.Transaction_date) and abs(t1.Transaction_amount) > abs(t2.Transaction_amount)
)
order by t1.Transaction_date desc;

/*Q24. Find the no. of transactions of credit cards including add-on Credit Cards */
Select count(*) as Num_Transaction from bank_account_transaction where Account_Number IN(
	Select Account_Number from bank_account_relationship_details where Account_type IN("Credit Card", "Add-on Credit Card")
);

/*Q25. From employee_details retrieve only employee_id , first_name ,last_name phone_number ,salary, job_id where department_name is Contracting (Note
#Department_id of employee_details table must be other than the list within IN operator. */
Select e.EMPLOYEE_ID, e.FIRST_NAME, e.LAST_NAME, e.PHONE_NUMBER, e.SALARY, e.JOB_ID, d.DEPARTMENT_NAME from employee_details e
Inner Join department_details d
ON e.DEPARTMENT_ID = d.DEPARTMENT_ID;

/*Q26. Display savings accounts and its corresponding Recurring deposits transactions are more than 4 times.*/
Select a.Account_Number, a.Account_type, t.Transaction_amount, t.Transaction_date from bank_account_details a
Inner Join bank_account_transaction t ON a.Account_Number = t.Account_Number
where t.Account_Number IN (
	Select Account_Number from bank_account_transaction
    where a.Account_type IN ('SAVINGS', "RECURRING DEPOSITS")
    group by Account_Number
    having count(Account_Number) > 3
);

/*Q27. From employee_details fetch only employee_id, ,first_name, last_name , phone_number ,email, job_id where job_id should not be IT_PROG.*/
Select EMPLOYEE_ID, FIRST_NAME, LAST_NAME, PHONE_NUMBER, JOB_ID from employee_details where JOB_ID <> 'IT_PROG';

/*Q29. From employee_details retrieve only employee_id , first_name ,last_name phone_number ,salary, job_id where manager_id is '60' (Note
#Department_id of employee_details table must be other than the list within IN operator.*/
Select EMPLOYEE_ID, FIRST_NAME, LAST_NAME, PHONE_NUMBER, SALARY, JOB_ID from employee_details 
where MANAGER_ID = 60;

Select e.EMPLOYEE_ID, e.FIRST_NAME, e.LAST_NAME, e.PHONE_NUMBER, e.SALARY, e.JOB_ID, d.MANAGER_ID 
from employee_details e
Inner Join department_details d
ON e.EMPLOYEE_ID = d.EMPLOYEE_ID
where d.MANAGER_ID = 60;

/*Q30. Create a new table as emp_dept and insert the result obtained after performing inner join on the two tables employee_details and department_details.*/
Create table emp_dept
AS
Select e.*, d.DEPARTMENT_NAME, d.LOCATION_ID from employee_details e
Inner Join department_details d
ON e.EMPLOYEE_ID = d.EMPLOYEE_ID;

Select * from emp_dept;


