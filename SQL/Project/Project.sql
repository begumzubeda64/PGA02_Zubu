/*Begum Zubeda Project*/
Create database Logistics;
Use Logistics;

Create table Employee_Details (
	Emp_ID INT(5) PRIMARY KEY,
    Emp_NAME VARCHAR(30),
    Emp_DESIGNATION VARCHAR(40),
    Emp_ADDR VARCHAR(100),
    Emp_BRANCH VARCHAR(30),
    EMP_CONT_NO VARCHAR(10)
);

Create table Membership_details (
	M_ID INT PRIMARY KEY,
    START_DATE TEXT NOT NULL,
    END_DATE TEXT NOT NULL
);

Create table Customer_details (
	Cust_ID INT(4) PRIMARY KEY,
    Membership_M_ID INT,
    Cust_NAME VARCHAR(30),
    Cust_EMAIL_ID VARCHAR(50),
    Cust_TYPE ENUM('Wholesale', 'Retail', 'Internal Goods') NOT NULL,
    Cust_ADDR VARCHAR(100),
    Cust_CONT_NO VARCHAR(10),
    FOREIGN KEY(Membership_M_ID) REFERENCES Membership_details(M_ID) 
);

Create table Shipment_details (
	SD_ID VARCHAR(6) PRIMARY KEY,
    CUSTOMER_CUST_ID INT(4),
    SD_CONTENT VARCHAR(40),
    SD_DOMAIN ENUM('International', 'Domestic') NOT NULL,
    SD_TYPE ENUM('Express', 'Regular') NOT NULL,
    SD_WEIGHT VARCHAR(10),
    SD_CHARGES INT(10),
    SD_ADDR VARCHAR(100) NOT NULL,
    DS_ADDR VARCHAR(100) NOT NULL,
    FOREIGN KEY(CUSTOMER_CUST_ID) REFERENCES Customer_details(Cust_ID)
);

Create table Payment_details (
	PAYMENT_ID VARCHAR(40) PRIMARY KEY,
    SHIPMENT_CLIENT_C_ID INT(4),
    SHIPMENT_SH_ID VARCHAR(6),
    AMOUNT INT NOT NULL,
    PAYMENT_STATUS ENUM('Paid', 'Not Paid') NOT NULL,
    PAYMENT_MODE ENUM('COD', 'Card Payment') NOT NULL,
    PAYMENT_DATE TEXT,
    FOREIGN KEY(SHIPMENT_CLIENT_C_ID) REFERENCES Customer_details(Cust_ID),
    FOREIGN KEY(SHIPMENT_SH_ID) REFERENCES Shipment_details(SD_ID)
);

Create table Delivery_status_details (
	SH_ID VARCHAR(6) PRIMARY KEY,
	CURRENT_ST VARCHAR(15) NOT NULL,
    SENT_DATE TEXT,
    DELIVERY_DATE TEXT
);

Create table Employee_management_details (
	EMPLOYEE_E_ID INT(5),
    SHIPMENT_SH_ID VARCHAR(6),
    STATUS_SH_ID VARCHAR(6),
    FOREIGN KEY(EMPLOYEE_E_ID) REFERENCES Employee_Details(Emp_ID),
    FOREIGN KEY(SHIPMENT_SH_ID) REFERENCES Shipment_details(SD_ID),
    FOREIGN KEY(STATUS_SH_ID) REFERENCES Delivery_status_details(SH_ID)
);

Select * from employee_management_details;

