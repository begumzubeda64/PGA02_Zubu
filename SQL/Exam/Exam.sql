/*Begum Zubeda A*/
Create database ExamPGA02;
use ExamPGA02;

Select * from bank_account_details;
Select * from bank_account_transaction;
Select * from bank_customer;
Select * from customer;
Select * from salesman;
Select * from orders;

/*1. Write a SQL query which will sort out the customer and their grade who made an order. Every customer must have a grade and be served by at least one seller, who belongs to a region.*/
Select c.*, o.ord_no, s.city as Sales_City from customer c 
Inner Join orders o On c.custemor_id = o.customer_id
Inner Join salesman s On c.salesman = s.salesman_id
where c.grade IS NOT NULL and c.city = s.city
order by c.cust_name, c.grade; 

/*2. Write a query for extracting the data from the order table for the salesman who earned the maximum commission.*/
Select o.*, s.name as salesman_name, max(s.commision) as max_commision from orders o
Inner Join salesman s ON o.salesman_id = s.salesman_id;

/*3. From orders retrieve only ord_no, purch_amt, ord_date, ord_date, salesman_id where salesman’s city is Nagpur(Note salesman_id of orderstable must be other than the list within the IN operator.)*/
Select o.ord_no, o.purch_amt, o.ord_date, o.salesman_id from orders o
Inner Join salesman s ON o.salesman_id = s.salesman_id
where s.city = 'Nagpur';

/*4. Write a query to create a report with the order date in such a way that the latest order date will come last along with the total purchase amount and 
the total commission for that date is (15 % for all sellers).*/
Select o.ord_no, str_to_date(o.ord_date, '%d-%m-%Y') as order_date, s.commision, sum(purch_amt) as total_purchase from orders o
Inner Join salesman s ON s.salesman_id = o.salesman_id
where s.commision = 0.15
group by order_date
order by order_date;

/*5. Retrieve ord_no, purch_amt, ord_date, ord_date, salesman_id from Orders table and display only those sellers whose purch_amt is greater than average purch_amt.*/
Select ord_no, purch_amt, ord_date, salesman_id from orders
where purch_amt > (
	Select AVG(purch_amt) from orders
);

/*6. Write a query to determine the Nth (Say N=5) highest purch_amt from Orders table. */
Select * from(
	Select * from orders
	order by purch_amt desc limit 5
)as temp_orders order by purch_amt limit 1;

/*7. What are Entities and Relationships? */
/*Entities are objects that exist that can be anything a person, place and there can be a relationship between them like a person can be from a place say Mumbai*/

/*8. Print customer_id, account_number and balance_amount, condition that if balance_amount is nil then assign transaction_amount for account_type = "Credit Card" */
Select a.Customer_id, a.Account_Number, IF(a.Balance_amount = 0 , t.Transaction_amount, a.Balance_amount) as BalanceAmount from bank_account_details a, bank_account_transaction t
where a.Account_type = "Credit Card" and a.Account_Number = t.Account_Number;

/*9. Print customer_id, account_number, balance_amount, conPrint account_number, balance_amount, transaction_amount from Bank_Account_Details and 
bank_account_transaction for all the transactions occurred during march, 2020 and april, 2020. */
Alter table bank_account_transaction modify Transaction_date date;

Select a.Customer_id, a.Account_Number, a.Balance_amount, t.Transaction_amount, t.Transaction_Date from bank_account_details a 
Inner Join bank_account_transaction t ON a.Account_Number = t.Account_Number
where t.Transaction_Date between '2020-03-01' and '2020-04-01';

/*10. Print all of the customer id, account number, balance_amount, transaction_amount from bank_cutomer, bank_account_details and bank_account_transactions tables where excluding all of their transactions in march, 2020 month . */
Select a.Customer_id, a.Account_Number, a.Balance_amount, t.Transaction_amount, t.Transaction_Date from bank_account_details a, bank_account_transaction t
where a.Account_Number = t.Account_Number and t.Transaction_Date Between '2020-03-01' and '2020-03-31';