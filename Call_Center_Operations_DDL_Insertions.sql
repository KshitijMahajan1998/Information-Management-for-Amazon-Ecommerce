DROP TABLE call_log_cc; 
DROP TABLE order_details_cc; 
DROP TABLE product_cc; 
DROP TABLE vendor_cc; 
DROP TABLE orders_cc; 
DROP TABLE customer_cc; 
DROP TABLE department_cc; 
DROP TABLE employee_cc; 
 
 
 
CREATE TABLE department_cc (   dept_id         NUMBER(20)      NOT NULL,   dept_name       VARCHAR(50)     NOT NULL, 
  PRIMARY KEY (dept_id) 
); 
 
CREATE TABLE customer_cc (   cust_id         NUMBER(20),   first_name      VARCHAR(50)                           NOT NULL,   last_name       VARCHAR(50)                           NOT NULL,   systemdate      DATE            DEFAULT SYSDATE,    birthdate       DATE                                  NOT NULL,   email           VARCHAR(50)     UNIQUE                NOT NULL,   prime_status    VARCHAR(1)      DEFAULT 'N'           NOT NULL, 
  PRIMARY KEY (cust_id) 
); 
 
CREATE TABLE employee_cc (   emp_id          NUMBER(20),   first_name      VARCHAR(50)    NOT NULL,   last_name       VARCHAR(50)    NOT NULL,   position        VARCHAR(50)    NOT NULL, 
  PRIMARY KEY (emp_id) 
); 
 
CREATE TABLE orders_cc (   order_id        NUMBER(20)     NOT NULL,   cust_id         NUMBER(20)     NOT NULL, 
  PRIMARY KEY (order_id), 
  CONSTRAINT FK_orderid_customerid FOREIGN KEY (cust_id) REFERENCES customer_cc(cust_id) 
); 
 
CREATE TABLE vendor_cc (   vendor_id       NUMBER(20)     NOT NULL,   vendor_name     VARCHAR(50)    NOT NULL,   address         VARCHAR(50)    NOT NULL,   city            VARCHAR(50)    NOT NULL,   region          VARCHAR(50)    NOT NULL,   zip             NUMBER(20)     NOT NULL,   country         VARCHAR(50)    NOT NULL, 
  PRIMARY KEY (vendor_id) 
); 
 
CREATE TABLE product_cc (   product_id      NUMBER(20)     NOT NULL,   dept_id         NUMBER(20)     NOT NULL,   vendor_id       NUMBER(20)     NOT NULL, 
  PRIMARY KEY (product_id) 
); 
 
CREATE TABLE order_details_cc (   order_id        NUMBER(20)     NOT NULL,   product_id      NUMBER(20)     NOT NULL,   quantity        NUMBER(20)     NOT NULL,   unitprice       NUMBER(20)     NOT NULL, 
  PRIMARY KEY (order_id, product_id), 
  CONSTRAINT FK_od_prodid FOREIGN KEY (product_id) REFERENCES product_cc(product_id), 
  CONSTRAINT FK_od_orderid FOREIGN KEY (order_id) REFERENCES orders_cc(order_id) 
); 
 
CREATE TABLE call_log_cc (   call_id         NUMBER(20),   cust_id         NUMBER(20),   employee_id     NUMBER(20),   order_id        NUMBER(20), 
  time            DATE                                  NOT NULL,   duration        NUMBER                                NOT NULL, 
  PRIMARY KEY (call_id), 
  CONSTRAINT FK_callid_custid FOREIGN KEY (cust_id) REFERENCES customer_cc(cust_id), 
  CONSTRAINT FK_callid_employeeid FOREIGN KEY (employee_id) REFERENCES employee_cc(emp_id), 
  CONSTRAINT FK_callid_orderid FOREIGN KEY (order_id) REFERENCES orders_cc(order_id) 
); 
 
 
-- INSERT STATEMENTS FOR DEPARTMENT TABLE 
INSERT INTO "DEPARTMENT_CC" (DEPT_ID, DEPT_NAME) VALUES ('1', 'Grocery'); 
INSERT INTO "DEPARTMENT_CC" (DEPT_ID, DEPT_NAME) VALUES ('2', 'Books'); 
INSERT INTO "DEPARTMENT_CC" (DEPT_ID, DEPT_NAME) VALUES ('3', 'Electronics'); 
INSERT INTO "DEPARTMENT_CC" (DEPT_ID, DEPT_NAME) VALUES ('4', 'Wellness'); 
INSERT INTO "DEPARTMENT_CC" (DEPT_ID, DEPT_NAME) VALUES ('5', 'Clothing'); 
COMMIT; 
 
-- INSERT STATEMENTS FOR VENDOR TABLE 
INSERT INTO "VENDOR_CC" (VENDOR_ID, VENDOR_NAME, ADDRESS, CITY, REGION, 
ZIP, COUNTRY) VALUES ('1', 'GAP', '123 Hut St.', 'Brookshire', 'Northwest', '76889', 'Australia'); 
INSERT INTO "VENDOR_CC" (VENDOR_ID, VENDOR_NAME, ADDRESS, CITY, REGION, 
ZIP, COUNTRY) VALUES ('2', 'Apple', '229 Logistics Dr.', 'Shanghai', 'East', '43040', 'China'); INSERT INTO "VENDOR_CC" (VENDOR_ID, VENDOR_NAME, ADDRESS, CITY, REGION, 
ZIP, COUNTRY) VALUES ('3', 'Microsoft', '1 Microsoft Way', 'Redmond', 'East', '98052', 'United Kingdom'); 
INSERT INTO "VENDOR_CC" (VENDOR_ID, VENDOR_NAME, ADDRESS, CITY, REGION, 
ZIP, COUNTRY) VALUES ('4', 'Whole Foods Market', '550 Bowie St.', 'Austin', 'South', '78703', 'United States'); 
INSERT INTO "VENDOR_CC" (VENDOR_ID, VENDOR_NAME, ADDRESS, CITY, REGION, 
ZIP, COUNTRY) VALUES ('5', 'Samsung', '433 Maple St.', 'Chicago', 'North', '87990', 'United States');COMMIT;  
 
-- INSERT STATEMENTS FOR CUSTOMER TABLE 
INSERT INTO "CUSTOMER_CC"(CUST_ID, FIRST_NAME, LAST_NAME, SYSTEMDATE, 
BIRTHDATE, EMAIL, PRIME_STATUS) VALUES ('1', 'You', 'Amazing', TO_DATE('2020-11-03 
00:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('1992-12-24 00:00:00', 'YYYY-MM-DD 
HH24:MI:SS'), 'youamazing@amazing.com', 'N'); 
INSERT INTO "CUSTOMER_CC"(CUST_ID, FIRST_NAME, LAST_NAME, SYSTEMDATE, 
BIRTHDATE, EMAIL, PRIME_STATUS) VALUES ('2', 'Mike', 'Thomas', TO_DATE('2020-11-25 
00:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('1992-12-24 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'mike.thomas@gmail.com', 'N'); 
INSERT INTO "CUSTOMER_CC" (CUST_ID, FIRST_NAME, LAST_NAME, SYSTEMDATE, 
BIRTHDATE, EMAIL, PRIME_STATUS) VALUES ('3', 'Grayson', 'Taylor', 
TO_DATE('2020-11-25 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('1996-09-23 
00:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'grayson.taylor@yahoo.com', 'Y'); 
INSERT INTO "CUSTOMER_CC" (CUST_ID, FIRST_NAME, LAST_NAME, SYSTEMDATE, 
BIRTHDATE, EMAIL, PRIME_STATUS) VALUES ('4', 'Julie', 'Karnes', TO_DATE('2020-11-25 
00:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('1986-01-24 00:00:00', 'YYYY-MM-DD 
HH24:MI:SS'), 'juliek@gmail.com', 'N'); 
INSERT INTO "CUSTOMER_CC"(CUST_ID, FIRST_NAME, LAST_NAME, SYSTEMDATE, 
BIRTHDATE, EMAIL, PRIME_STATUS) VALUES ('5', 'Donald', 'Glover', TO_DATE('2020-11-25 
00:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('1985-10-09 00:00:00', 'YYYY-MM-DD 
HH24:MI:SS'), 'dglover@gmail.com', 'Y'); 
COMMIT;  
 
-- INSERT STATEMENTS FOR EMPLOYEE TABLE 
INSERT INTO "EMPLOYEE_CC" (EMP_ID, FIRST_NAME, LAST_NAME, POSITION) VALUES 
('12', 'Abigail', 'Lopez', 'Customer Service Manager'); 
INSERT INTO "EMPLOYEE_CC" (EMP_ID, FIRST_NAME, LAST_NAME, POSITION) VALUES 
('13', 'Mario', 'Velasquez', 'Customer Service Specialist'); 
INSERT INTO "EMPLOYEE_CC" (EMP_ID, FIRST_NAME, LAST_NAME, POSITION) VALUES 
('14', 'Ryan', 'Robertson', 'Customer Service Specialist '); 
INSERT INTO "EMPLOYEE_CC" (EMP_ID, FIRST_NAME, LAST_NAME, POSITION) VALUES 
('15', 'Maya', 'Angelou', 'Customer Service Specialist'); 
INSERT INTO "EMPLOYEE_CC" (EMP_ID, FIRST_NAME, LAST_NAME, POSITION) VALUES 
('16', 'Kim', 'Kardy', 'Customer Service Specialist'); 
COMMIT;  
 
-- INSERT STATEMENTS FOR ORDERS 
INSERT INTO "ORDERS_CC" (ORDER_ID, CUST_ID) VALUES ('10001', '1'); 
INSERT INTO "ORDERS_CC" (ORDER_ID, CUST_ID) VALUES ('10002', '1'); 
INSERT INTO "ORDERS_CC" (ORDER_ID, CUST_ID) VALUES ('10003', '2'); 
INSERT INTO "ORDERS_CC" (ORDER_ID, CUST_ID) VALUES ('10004', '3'); 
INSERT INTO "ORDERS_CC" (ORDER_ID, CUST_ID) VALUES ('10005', '5'); 
COMMIT;  
 
-- Product 
INSERT INTO "PRODUCT_CC" (PRODUCT_ID, DEPT_ID, VENDOR_ID) VALUES ('123', '1', 
'4'); 
INSERT INTO "PRODUCT_CC" (PRODUCT_ID, DEPT_ID, VENDOR_ID) VALUES ('234', '1', 
'4'); 
INSERT INTO "PRODUCT_CC" (PRODUCT_ID, DEPT_ID, VENDOR_ID) VALUES ('345', '3', 
'3'); 
INSERT INTO "PRODUCT_CC" (PRODUCT_ID, DEPT_ID, VENDOR_ID) VALUES ('456', '3', 
'3'); 
INSERT INTO "PRODUCT_CC" (PRODUCT_ID, DEPT_ID, VENDOR_ID) VALUES ('567', '5', 
'1'); 
commit; 
 
-- INSERT STATEMENTS FOR ORDER_DETAILS 
INSERT INTO "ORDER_DETAILS_CC" (ORDER_ID, PRODUCT_ID, QUANTITY, UNITPRICE) 
VALUES ('10001', '123', '2', '6.99'); 
INSERT INTO "ORDER_DETAILS_CC" (ORDER_ID, PRODUCT_ID, QUANTITY, UNITPRICE) 
VALUES ('10002', '234', '1', '15.99'); 
INSERT INTO "ORDER_DETAILS_CC"  (ORDER_ID, PRODUCT_ID, QUANTITY, 
UNITPRICE) VALUES ('10003', '345', '3', '10.49'); 
INSERT INTO "ORDER_DETAILS_CC"  (ORDER_ID, PRODUCT_ID, QUANTITY, 
UNITPRICE) VALUES ('10004', '456', '1', '34.99'); 
INSERT INTO "ORDER_DETAILS_CC"  (ORDER_ID, PRODUCT_ID, QUANTITY, 
UNITPRICE) VALUES ('10005', '567', '1', '3.99'); 
COMMIT;  
 
-- INSERT STATEMENTS FOR CALL_LOG 
INSERT INTO "CALL_LOG_CC" (CALL_ID, CUST_ID, EMPLOYEE_ID, ORDER_ID, TIME, 
DURATION) VALUES ('111', '1', '12', '10001', TO_DATE('2020-11-03 13:18:41', 'YYYY-MM-DD HH24:MI:SS'), '12'); 
INSERT INTO "CALL_LOG_CC"  (CALL_ID, CUST_ID, EMPLOYEE_ID, ORDER_ID, TIME, 
DURATION) VALUES ('112', '2', '13', '10002', TO_DATE('2020-11-05 05:18:51', 'YYYY-MM-DD 
HH24:MI:SS'), '5'); 
INSERT INTO "CALL_LOG_CC" (CALL_ID, CUST_ID, EMPLOYEE_ID, ORDER_ID, TIME, 
DURATION) VALUES ('113', '3', '14', '10003', TO_DATE('2020-06-06 09:19:02', 'YYYY-MM-DD HH24:MI:SS'), '10'); 
INSERT INTO "CALL_LOG_CC"  (CALL_ID, CUST_ID, EMPLOYEE_ID, ORDER_ID, TIME, 
DURATION) VALUES ('114', '4', '15', '10004', TO_DATE('2020-09-29 04:19:13', 'YYYY-MM-DD HH24:MI:SS'), '30'); 
INSERT INTO "CALL_LOG_CC" (CALL_ID, CUST_ID, EMPLOYEE_ID, ORDER_ID, TIME, 
DURATION) VALUES ('115', '5', '16', '10005', TO_DATE('2020-08-11 07:19:23', 'YYYY-MM-DD HH24:MI:SS'), '25'); COMMIT;  
