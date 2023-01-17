DROP TABLE product_dw; 
DROP TABLE customer_dw; 
DROP TABLE inventory_dw; 
DROP TABLE vendor_dw; 
DROP TABLE measures_dw; 
 
CREATE TABLE product_dw ( 
    product_id       NUMBER(20),     dept_name        VARCHAR(50)         NOT NULL,     vendor_name      VARCHAR(50)         NOT NULL,     product_name     VARCHAR(50)         NOT NULL,     unit_price       NUMBER(7,2)         NOT NULL, 
    CONSTRAINT      pk_prod_dept_vend_id  
      PRIMARY KEY     (product_id) 
); 
 
CREATE TABLE inventory_dw (     inventory_id          NUMBER(20)      NOT NULL,     warehouse_address     VARCHAR2(50)    NOT NULL,     warehouse_city        VARCHAR2(50)    NOT NULL,     warehouse_region      VARCHAR2(50)    NOT NULL,     product_name          VARCHAR2(50)    NOT NULL,     quantity_on_hand      NUMBER(10)      NOT NULL,     quantity_available    NUMBER(20)      NOT NULL, 
    PRIMARY KEY (inventory_id) 
); 
 
CREATE TABLE customer_dw ( 
    cust_id           NUMBER(10)      NOT NULL,     call_time         DATE                                  NOT NULL,     call_duration     NUMBER                                NOT NULL,     first_name        VARCHAR2(50)    NOT NULL,     last_name         VARCHAR2(50)    NOT NULL,     birthdate         DATE            NOT NULL,     email             VARCHAR2(50)    UNIQUE      NOT NULL,     prime_status      VARCHAR2(1)     DEFAULT 'N' NOT NULL,     phone_number      VARCHAR2(50),     member_start_date DATE,     cust_address      VARCHAR2(50) NOT NULL,     cust_city         VARCHAR2(50) NOT NULL,     cust_region       VARCHAR2(50),     CONSTRAINT      pk_cust_id  
      PRIMARY KEY     (cust_id) 
); 
 
CREATE TABLE vendor_dw (   vendor_id NUMBER(20) NOT NULL,   vendor_name VARCHAR2(50) NOT NULL,   vendor_phone_number VARCHAR2(50) NOT NULL,   vendor_contact VARCHAR2(50) NOT NULL,   vendor_email VARCHAR2(50),   vendor_address VARCHAR2(50) NOT NULL,   vendor_city VARCHAR2(50) NOT NULL,   vendor_region VARCHAR2(50),   vendor_zip NUMBER(20) NOT NULL,   country_name VARCHAR2(50) NOT NULL, 
    PRIMARY KEY (vendor_id) 
); 
 
CREATE TABLE measures_dw ( 
  call_id             NUMBER(20)      NOT NULL,   inventory_id        NUMBER(20)      NOT NULL,   vendor_id           NUMBER(20)      NOT NULL,   cust_id             NUMBER(20)      NOT NULL,   product_id          NUMBER(20)      NOT NULL,   quantity            NUMBER(10)      NOT NULL,   unit_price          NUMBER(7,2)     NOT NULL,   quantity_on_hand    NUMBER(10)      NOT NULL,   quantity_available  NUMBER(10)      NOT NULL 
); 
