
DROP TABLE PRODUCT_OP CASCADE CONSTRAINTS;
DROP TABLE VENDOR_OP CASCADE CONSTRAINTS;
DROP TABLE CREDIT_CARD_TYPE_OP CASCADE CONSTRAINTS; DROP TABLE SHIPMENT_DETAILS_OP CASCADE CONSTRAINTS; DROP TABLE COUNTRY_OP CASCADE CONSTRAINTS;
DROP TABLE COURIER_OP CASCADE CONSTRAINTS;
DROP TABLE CUSTOMER_CC_OP CASCADE CONSTRAINTS;
 DROP TABLE department_OP CASCADE CONSTRAINTS;
DROP TABLE order_details_OP CASCADE CONSTRAINTS; DROP TABLE customer_address_OP CASCADE CONSTRAINTS; DROP TABLE address_type_OP CASCADE CONSTRAINTS; DROP TABLE orders_OP CASCADE CONSTRAINTS;
DROP TABLE customer_OP CASCADE CONSTRAINTS;
CREATE TABLE address_type_op ( address_type_id NUMBER(20) NOT NULL, address_type_name VARCHAR2(50) NOT NULL, PRIMARY KEY (address_type_id)
);
CREATE TABLE country_op (
country_id NUMBER(20) NOT NULL, country_name VARCHAR2(50) NOT NULL, PRIMARY KEY (country_id)
);
CREATE TABLE department_op ( dept_id NUMBER(20) NOT NULL, dept_name VARCHAR2(50) NOT NULL, PRIMARY KEY (dept_id)
);
CREATE TABLE courier_op (
courier_id NUMBER(20) NOT NULL, courier_name VARCHAR2(50) NOT NULL,
 
 PRIMARY KEY (courier_id) );
CREATE TABLE credit_card_type_op ( card_type_id NUMBER(20) NOT NULL, card_type_name VARCHAR2(50) NOT NULL, PRIMARY KEY (card_type_id)
);
CREATE TABLE customer_op (
cust_id NUMBER(20) NOT NULL,
first_name VARCHAR2(50) NOT NULL,
last_name VARCHAR2(50) NOT NULL,
birthdate DATE NOT NULL,
email VARCHAR2(50) UNIQUE NOT NULL, prime_status VARCHAR2(1) DEFAULT 'N' NOT NULL, systemdate DATE DEFAULT SYSDATE NOT NULL, phone_number VARCHAR2(50),
member_start_date DATE,
PRIMARY KEY (cust_id)
);
CREATE TABLE customer_address_op ( cust_address_id NUMBER (20) NOT NULL, cust_id NUMBER (20) NOT NULL, address_type_id NUMBER(20) NOT NULL, cust_address VARCHAR2(50) NOT NULL, cust_city VARCHAR2(50) NOT NULL, cust_region VARCHAR2(50), cust_postal_code NUMBER (20) NOT NULL,
 
 cust_country_id NUMBER(10) NOT NULL,
PRIMARY KEY (cust_address_id),
CONSTRAINT FK_CUSTADD_CUSTOMER FOREIGN KEY (cust_id) REFERENCES CUSTOMER_op(cust_id),
CONSTRAINT FK_CUSTADD_ADDRTYPE FOREIGN KEY (address_type_id) REFERENCES ADDRESS_TYPE_op(address_type_id),
CONSTRAINT FK_CUSTADD_COUNTRY FOREIGN KEY (cust_country_id) REFERENCES COUNTRY_op(country_id)
);
CREATE TABLE customer_cc_op (
card_id NUMBER (20) NOT NULL,
cust_id NUMBER (20) NOT NULL, card_number NUMBER (20) NOT NULL, card_exp_date DATE NOT NULL, card_security_code NUMBER (20) NOT NULL, card_type_id NUMBER(20) NOT NULL, PRIMARY KEY (card_id),
CONSTRAINT FK_CC_CUSTOMER FOREIGN KEY (cust_id) REFERENCES CUSTOMER_op(cust_id),
CONSTRAINT FK_CC_CARDTYPE FOREIGN KEY (card_type_id) REFERENCES credit_card_type_op(card_type_id)
);
CREATE TABLE vendor_op (
vendor_id NUMBER(20) NOT NULL,
vendor_name VARCHAR2(50) NOT NULL, vendor_phone_number VARCHAR2(50) NOT NULL, vendor_contact VARCHAR2(50) NOT NULL, vendor_email VARCHAR2(50),
vendor_address VARCHAR2(50) NOT NULL, vendor_city VARCHAR2(50) NOT NULL, vendor_region VARCHAR2(50),
 
 vendor_zip NUMBER(20) NOT NULL,
vendor_country_id NUMBER(20) NOT NULL,
PRIMARY KEY (vendor_id),
CONSTRAINT FK_VENDOR_COUNTRY FOREIGN KEY (vendor_country_id) REFERENCES COUNTRY_op(country_id)
);
CREATE TABLE product_op (
product_id NUMBER(20) NOT NULL,
product_name VARCHAR2(50) NOT NULL,
dept_id NUMBER(20) NOT NULL,
vendor_id NUMBER(20),
UNIT_PRICE NUMBER (7,2) NOT NULL,
prime_discount NUMBER(7,2),
PRIMARY KEY (product_id),
CONSTRAINT FK_PRODUCT_DEPT FOREIGN KEY (dept_id) REFERENCES DEPARTMENT_op(dept_id),
CONSTRAINT FK_PRODUCT_VENDOR FOREIGN KEY (vendor_id) REFERENCES vendor_op(vendor_id)
);
CREATE TABLE orders_op (
order_id NUMBER(20) NOT NULL,
cust_id NUMBER(20) NOT NULL,
order_date DATE DEFAULT SYSDATE NOT NULL,
PRIMARY KEY (order_id),
CONSTRAINT FK_ORDERS_CUST FOREIGN KEY (cust_id) REFERENCES CUSTOMER_op(cust_id)
);
 
 CREATE TABLE shipment_details_op (
shipment_details_id NUMBER(20) NOT NULL,
shipping_date DATE NOT NULL,
courier_id NUMBER(20) NOT NULL,
shipping_address VARCHAR2(50) NOT NULL,
shipping_city VARCHAR2(50) NOT NULL,
shipping_region VARCHAR2(50),
shipping_postal_code NUMBER(20) NOT NULL,
shipping_country_id NUMBER(20) NOT NULL,
PRIMARY KEY (shipment_details_id),
CONSTRAINT SHIPDETAILS_courier FOREIGN KEY (courier_id) REFERENCES courier_op(courier_id),
CONSTRAINT SHIPDETAILS_COUNTRY FOREIGN KEY (shipping_country_id) REFERENCES COUNTRY_op(country_id)
);
CREATE TABLE order_details_op (
order_details_id NUMBER (20) NOT NULL,
order_id NUMBER(20) NOT NULL,
product_id NUMBER(20) NOT NULL,
shipping_details_id NUMBER(20),
quantity NUMBER NOT NULL,
unitprice NUMBER(7,2) NOT NULL,
PRIMARY KEY (order_details_id),
CONSTRAINT FK_ORDERDET_ORDERS FOREIGN KEY (order_id) REFERENCES orders_op(order_id),
CONSTRAINT FK_ORDERDET_PRODUCT FOREIGN KEY (product_id) REFERENCES PRODUCT_op(product_id),
CONSTRAINT FK_ORDERDET_SHIPDET FOREIGN KEY (shipping_details_id) REFERENCES shipment_details_op(shipment_details_id)
);
-- ADDRESS_TYPE TABLE
 
 INSERT INTO "ADDRESS_TYPE_OP" (ADDRESS_TYPE_ID, ADDRESS_TYPE_NAME) VALUES ('1', 'Billing');
INSERT INTO "ADDRESS_TYPE_OP" (ADDRESS_TYPE_ID, ADDRESS_TYPE_NAME) VALUES ('2', 'Shipping');
commit;
-- DEPARTMENT TABLE
INSERT INTO "DEPARTMENT_OP" (DEPT_ID, DEPT_NAME) VALUES ('1', 'groccery'); INSERT INTO "DEPARTMENT_OP" (DEPT_ID, DEPT_NAME) VALUES ('2', 'books'); INSERT INTO "DEPARTMENT_OP" (DEPT_ID, DEPT_NAME) VALUES ('3', 'electronics'); INSERT INTO "DEPARTMENT_OP" (DEPT_ID, DEPT_NAME) VALUES ('4', 'wellness'); INSERT INTO "DEPARTMENT_OP" (DEPT_ID, DEPT_NAME) VALUES ('5', 'clothing'); commit;
-- COUNTRY TABLE
INSERT INTO "COUNTRY_OP" (COUNTRY_ID, COUNTRY_NAME) VALUES ('1', 'United States');
INSERT INTO "COUNTRY_OP" (COUNTRY_ID, COUNTRY_NAME) VALUES ('2', 'China');
INSERT INTO "COUNTRY_OP" (COUNTRY_ID, COUNTRY_NAME) VALUES ('3', 'United Kingdom');
INSERT INTO "COUNTRY_OP" (COUNTRY_ID, COUNTRY_NAME) VALUES ('4', 'Australia'); INSERT INTO "COUNTRY_OP" (COUNTRY_ID, COUNTRY_NAME) VALUES ('5', 'Mexico'); commit;
-- VENDOR TABLE
INSERT INTO "VENDOR_OP" (VENDOR_ID, VENDOR_NAME, VENDOR_PHONE_NUMBER, VENDOR_CONTACT, VENDOR_EMAIL, VENDOR_ADDRESS, VENDOR_CITY, VENDOR_REGION, VENDOR_ZIP, VENDOR_COUNTRY_ID) VALUES ('1', 'GAP', '214-934-0220', 'Caroline Jordan', 'cjordan@gmail.com', '123 Hut St.', 'Brookshire', 'Northwest', '76889', '4');
INSERT INTO "VENDOR_OP" (VENDOR_ID, VENDOR_NAME, VENDOR_PHONE_NUMBER, VENDOR_CONTACT, VENDOR_EMAIL, VENDOR_ADDRESS, VENDOR_CITY, VENDOR_REGION, VENDOR_ZIP, VENDOR_COUNTRY_ID) VALUES ('2', 'Apple',
 
 '972-972-4692', 'Sarah Holiday', 'sholiday@gmail.com', '227 Logistics Street', 'Shanghai', 'South', '43040', '2');
INSERT INTO "VENDOR_OP" (VENDOR_ID, VENDOR_NAME, VENDOR_PHONE_NUMBER, VENDOR_CONTACT, VENDOR_EMAIL, VENDOR_ADDRESS, VENDOR_CITY, VENDOR_REGION, VENDOR_ZIP, VENDOR_COUNTRY_ID) VALUES ('3', 'Microsoft', '469-342-8400', 'John Smith', 'johns@yahoo.com', '1 Microsoft Way', 'Redmond', 'East', '98052', '3');
INSERT INTO "VENDOR_OP" (VENDOR_ID, VENDOR_NAME, VENDOR_PHONE_NUMBER, VENDOR_CONTACT, VENDOR_EMAIL, VENDOR_ADDRESS, VENDOR_CITY, VENDOR_REGION, VENDOR_ZIP, VENDOR_COUNTRY_ID) VALUES ('4', 'Whole Foods Market', '512-442-9200', 'Jordan Howard', 'Jordanh@gmail.com', '550 Bowie St.', 'Austin', 'South', '78703', '1');
INSERT INTO "VENDOR_OP" (VENDOR_ID, VENDOR_NAME, VENDOR_PHONE_NUMBER, VENDOR_CONTACT, VENDOR_EMAIL, VENDOR_ADDRESS, VENDOR_CITY, VENDOR_REGION, VENDOR_ZIP, VENDOR_COUNTRY_ID) VALUES ('5', 'Samsung', '512-420-7666', 'Mike Smith', 'Smike@gmail.com', '433 Maple St.', 'Chicago', 'North', '87990', '1');
commit;
-- CREDIT_CARD_TYPE_TABLE
INSERT INTO "CREDIT_CARD_TYPE_OP" (CARD_TYPE_ID, CARD_TYPE_NAME) VALUES ('1', 'Visa');
INSERT INTO "CREDIT_CARD_TYPE_OP" (CARD_TYPE_ID, CARD_TYPE_NAME) VALUES ('2', 'Mastercard');
INSERT INTO "CREDIT_CARD_TYPE_OP" (CARD_TYPE_ID, CARD_TYPE_NAME) VALUES ('3', 'American Express');
INSERT INTO "CREDIT_CARD_TYPE_OP" (CARD_TYPE_ID, CARD_TYPE_NAME) VALUES ('4', 'Discover');
commit;
-- COURIER TABLE
INSERT INTO "COURIER_OP" (COURIER_ID, COURIER_NAME) VALUES ('1', 'Amazon'); INSERT INTO "COURIER_OP" (COURIER_ID, COURIER_NAME) VALUES ('2', 'FedEx'); INSERT INTO "COURIER_OP" (COURIER_ID, COURIER_NAME) VALUES ('3', 'UPS'); commit;
 
 -- CUSTOMER TABLE
INSERT INTO "CUSTOMER_OP" (CUST_ID, FIRST_NAME, LAST_NAME, BIRTHDATE, EMAIL, PRIME_STATUS, SYSTEMDATE, PHONE_NUMBER, MEMBER_START_DATE) VALUES ('1', 'YOU', 'AMAZING', TO_DATE('2020-11-25 11:43:51', 'YYYY-MM-DD HH24:MI:SS'), 'YOUAMAZING@AMAZING.COM
', 'Y', TO_DATE('2020-11-25 11:49:43', 'YYYY-MM-DD HH24:MI:SS'), '214-442-8766', TO_DATE('2008-11-15 00:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO "CUSTOMER_OP" (CUST_ID, FIRST_NAME, LAST_NAME, BIRTHDATE, EMAIL, PRIME_STATUS, SYSTEMDATE, PHONE_NUMBER, MEMBER_START_DATE) VALUES ('2', 'Mike', 'Thomas', TO_DATE('1992-12-24 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'mike.thomas@gmai.com', 'N', TO_DATE('2020-11-25 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), '214-945-0220', TO_DATE('2012-07-04 00:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO "CUSTOMER_OP" (CUST_ID, FIRST_NAME, LAST_NAME, BIRTHDATE, EMAIL, PRIME_STATUS, SYSTEMDATE, PHONE_NUMBER, MEMBER_START_DATE) VALUES ('3', 'Grayson', 'Taylor', TO_DATE('1996-09-23 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'grayson.taylor@yahoo.com', 'Y', TO_DATE('2020-11-25 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), '932-468-2300', TO_DATE('2014-11-07 00:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO "CUSTOMER_OP" (CUST_ID, FIRST_NAME, LAST_NAME, BIRTHDATE, EMAIL, PRIME_STATUS, SYSTEMDATE, PHONE_NUMBER, MEMBER_START_DATE) VALUES ('4', 'Julie', 'Karnes', TO_DATE('1986-01-24 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'juliek@gmail.com', 'N', TO_DATE('2020-11-25 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), '865-421-5600', TO_DATE('2017-11-04 00:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO "CUSTOMER_OP" (CUST_ID, FIRST_NAME, LAST_NAME, BIRTHDATE, EMAIL, PRIME_STATUS, SYSTEMDATE, PHONE_NUMBER, MEMBER_START_DATE) VALUES ('5', 'Donald', 'Glover', TO_DATE('1985-10-09 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'dglover@gmail.com', 'N', TO_DATE('2020-11-25 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), '432-655-9100', TO_DATE('2019-12-07 00:00:00', 'YYYY-MM-DD HH24:MI:SS'));
commit;
-- ORDER TABLE
INSERT INTO "ORDERS_OP" (ORDER_ID, CUST_ID, ORDER_DATE) VALUES ('10001', '1', TO_DATE('2020-11-16 00:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO "ORDERS_OP" (ORDER_ID, CUST_ID, ORDER_DATE) VALUES ('10002', '1', TO_DATE('2020-11-08 00:00:00', 'YYYY-MM-DD HH24:MI:SS'));
 
 INSERT INTO "ORDERS_OP" (ORDER_ID, CUST_ID, ORDER_DATE) VALUES ('10003', '2', TO_DATE('2020-11-19 00:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO "ORDERS_OP" (ORDER_ID, CUST_ID, ORDER_DATE) VALUES ('10004', '3', TO_DATE('2020-11-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO "ORDERS_OP" (ORDER_ID, CUST_ID, ORDER_DATE) VALUES ('10005', '5', TO_DATE('2020-11-05 00:00:00', 'YYYY-MM-DD HH24:MI:SS'));
commit;
-- SHIPMENT DETAILS TABLE
INSERT INTO "SHIPMENT_DETAILS_OP" (SHIPMENT_DETAILS_ID, SHIPPING_DATE, COURIER_ID, SHIPPING_ADDRESS, SHIPPING_CITY, SHIPPING_REGION, SHIPPING_POSTAL_CODE, SHIPPING_COUNTRY_ID) VALUES ('5001', TO_DATE('2020-11-11 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), '1', '5740 Cadence Lane', 'Plano', 'North', '75024', '1');
INSERT INTO "SHIPMENT_DETAILS_OP" (SHIPMENT_DETAILS_ID, SHIPPING_DATE, COURIER_ID, SHIPPING_ADDRESS, SHIPPING_CITY, SHIPPING_REGION, SHIPPING_POSTAL_CODE, SHIPPING_COUNTRY_ID) VALUES ('5002', TO_DATE('2020-11-07 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), '1', '5400 Live Oak', 'London', 'South', '533425', '3');
INSERT INTO "SHIPMENT_DETAILS_OP" (SHIPMENT_DETAILS_ID, SHIPPING_DATE, COURIER_ID, SHIPPING_ADDRESS, SHIPPING_CITY, SHIPPING_REGION, SHIPPING_POSTAL_CODE, SHIPPING_COUNTRY_ID) VALUES ('5003', TO_DATE('2020-11-20 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), '2', '5748 Twin Oaks', 'Los Angeles', 'West', '90210', '1');
INSERT INTO "SHIPMENT_DETAILS_OP" (SHIPMENT_DETAILS_ID, SHIPPING_DATE, COURIER_ID, SHIPPING_ADDRESS, SHIPPING_CITY, SHIPPING_REGION, SHIPPING_POSTAL_CODE, SHIPPING_COUNTRY_ID) VALUES ('5004', TO_DATE('2020-11-21 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), '3', '4500 Briargrove Lane', 'Dallas', 'Texas', '75093', '1');
INSERT INTO "SHIPMENT_DETAILS_OP" (SHIPMENT_DETAILS_ID, SHIPPING_DATE, COURIER_ID, SHIPPING_ADDRESS, SHIPPING_CITY, SHIPPING_REGION, SHIPPING_POSTAL_CODE, SHIPPING_COUNTRY_ID) VALUES ('5005', TO_DATE('2020-11-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), '1', '6500 Melshire', 'Melbourne', 'East', '39991', '4');
commit;
 
 -- PRODUCT TABLE
INSERT INTO "PRODUCT_OP" (PRODUCT_ID, PRODUCT_NAME, DEPT_ID, VENDOR_ID, UNIT_PRICE, PRIME_DISCOUNT) VALUES ('123', 'Borden Whole Milk', '1', '4', '6.99', '3.00');
INSERT INTO "PRODUCT_OP" (PRODUCT_ID, PRODUCT_NAME, DEPT_ID, VENDOR_ID, UNIT_PRICE, PRIME_DISCOUNT) VALUES ('234', 'Lunchable 6 Pack', '1', '4', '15.99', '3.00');
INSERT INTO "PRODUCT_OP" (PRODUCT_ID, PRODUCT_NAME, DEPT_ID, VENDOR_ID, UNIT_PRICE, PRIME_DISCOUNT) VALUES ('345', 'Mouse Pad', '3', '3', '10.49', '3.00');
INSERT INTO "PRODUCT_OP" (PRODUCT_ID, PRODUCT_NAME, DEPT_ID, VENDOR_ID, UNIT_PRICE, PRIME_DISCOUNT) VALUES ('456', 'Microsoft Mouse 3600', '3', '3', '34.99', '3.00');
INSERT INTO "PRODUCT_OP" (PRODUCT_ID, PRODUCT_NAME, DEPT_ID, VENDOR_ID, UNIT_PRICE, PRIME_DISCOUNT) VALUES ('567', 'Hair Ties', '5', '1', '3.99', '0');
commit;
-- CUSTOMER_CC TABLE
INSERT INTO "CUSTOMER_CC_OP" (CARD_ID, CUST_ID, CARD_NUMBER, CARD_EXP_DATE, CARD_SECURITY_CODE, CARD_TYPE_ID) VALUES ('70001', '2', '5480883108534840', TO_DATE('2025-12-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), '947', '2');
INSERT INTO "CUSTOMER_CC_OP" (CARD_ID, CUST_ID, CARD_NUMBER, CARD_EXP_DATE, CARD_SECURITY_CODE, CARD_TYPE_ID) VALUES ('70002', '1', '2221007701739686', TO_DATE('2022-01-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), '752', '2');
INSERT INTO "CUSTOMER_CC_OP" (CARD_ID, CUST_ID, CARD_NUMBER, CARD_EXP_DATE, CARD_SECURITY_CODE, CARD_TYPE_ID) VALUES ('70003', '3', '4539148550460413', TO_DATE('2021-01-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), '478', '1');
INSERT INTO "CUSTOMER_CC_OP" (CARD_ID, CUST_ID, CARD_NUMBER, CARD_EXP_DATE, CARD_SECURITY_CODE, CARD_TYPE_ID) VALUES ('70004', '2', '4485960822519303', TO_DATE('2023-09-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), '342', '1');
 
 INSERT INTO "CUSTOMER_CC_OP"(CARD_ID, CUST_ID, CARD_NUMBER, CARD_EXP_DATE, CARD_SECURITY_CODE, CARD_TYPE_ID) VALUES ('70005', '1', '378217231970827', TO_DATE('2024-07-02 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), '890', '3');
commit;
-- customer_address_table
INSERT INTO "CUSTOMER_ADDRESS_OP" (CUST_ADDRESS_ID, CUST_ID, ADDRESS_TYPE_ID, CUST_ADDRESS, CUST_CITY, CUST_REGION, CUST_POSTAL_CODE, CUST_COUNTRY_ID) VALUES ('87001', '1', '1', '4700 Carolyns Circle', 'Norwalk', 'South', '90652', '1');
INSERT INTO "CUSTOMER_ADDRESS_OP" (CUST_ADDRESS_ID, CUST_ID, ADDRESS_TYPE_ID, CUST_ADDRESS, CUST_CITY, CUST_REGION, CUST_POSTAL_CODE, CUST_COUNTRY_ID) VALUES ('87002', '2', '1', '85 Thirsk Road', 'London', 'South', '109823', '3');
INSERT INTO "CUSTOMER_ADDRESS_OP" (CUST_ADDRESS_ID, CUST_ID, ADDRESS_TYPE_ID, CUST_ADDRESS, CUST_CITY, CUST_REGION, CUST_POSTAL_CODE, CUST_COUNTRY_ID) VALUES ('87003', '3', '1', '42 Umbridge Road', 'Manchester', 'North', '100480', '3');
INSERT INTO "CUSTOMER_ADDRESS_OP" (CUST_ADDRESS_ID, CUST_ID, ADDRESS_TYPE_ID, CUST_ADDRESS, CUST_CITY, CUST_REGION, CUST_POSTAL_CODE, CUST_COUNTRY_ID) VALUES ('87004', '4', '2', '3663 Fort Street', 'Washington', 'Northeast', '27889', '1');
INSERT INTO "CUSTOMER_ADDRESS_OP" (CUST_ADDRESS_ID, CUST_ID, ADDRESS_TYPE_ID, CUST_ADDRESS, CUST_CITY, CUST_REGION, CUST_POSTAL_CODE, CUST_COUNTRY_ID) VALUES ('87005', '5', '2', '4500 South Oak', 'Los Angeles', 'Southwest', '90212', '1');
--INSERT INTO "CUSTOMER_ADDRESS_OP" (CUST_ADDRESS_ID, CUST_ID, ADDRESS_TYPE_ID, CUST_ADDRESS, CUST_CITY, CUST_REGION, CUST_POSTAL_CODE, CUST_COUNTRY_ID) VALUES ('87006', '1', '2', 'La Concepcion Coatipac 5240', 'Mexico City', 'Northeast', '52333', '5');
commit;
 
-- ORDER_DETAILS_TABLE
INSERT INTO "ORDER_DETAILS_OP" (ORDER_DETAILS_ID, ORDER_ID, PRODUCT_ID, SHIPPING_DETAILS_ID, QUANTITY, UNITPRICE) VALUES ('20001', '10001', '123', '5001', '2', '6.99');
INSERT INTO "ORDER_DETAILS_OP" (ORDER_DETAILS_ID, ORDER_ID, PRODUCT_ID, SHIPPING_DETAILS_ID, QUANTITY, UNITPRICE) VALUES ('20002', '10002', '123', '5002', '4', '6.99');
INSERT INTO "ORDER_DETAILS_OP" (ORDER_DETAILS_ID, ORDER_ID, PRODUCT_ID, SHIPPING_DETAILS_ID, QUANTITY, UNITPRICE) VALUES ('20003', '10003', '456', '5003', '1', '34.99');
INSERT INTO "ORDER_DETAILS_OP" (ORDER_DETAILS_ID, ORDER_ID, PRODUCT_ID, SHIPPING_DETAILS_ID, QUANTITY, UNITPRICE) VALUES ('20004', '10004', '567', '5004', '1', '3.99');
INSERT INTO "ORDER_DETAILS_OP" (ORDER_DETAILS_ID, ORDER_ID, PRODUCT_ID, SHIPPING_DETAILS_ID, QUANTITY, UNITPRICE) VALUES ('20005', '10005', '567', '5005', '3', '3.99');
commit;