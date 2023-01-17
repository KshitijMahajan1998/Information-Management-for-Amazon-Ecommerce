DROP VIEW op_product_view; 
DROP VIEW op_department_view; 
DROP VIEW op_vendor_view; 
DROP VIEW op_cust_view; 
DROP VIEW cc_call_view; 
DROP VIEW op_cust_add; 
DROP VIEW inv_inv_view; DROP VIEW wh_inv_view; 
DROP VIEW prod_inv_view; DROP VIEW op_vend_view; 
DROP VIEW op_ctry_view; 
DROP VIEW op_prod_view; 
DROP VIEW order_details_view; 
 
-- product views -- 
CREATE OR REPLACE VIEW op_product_view AS 
SELECT * 
FROM product_op; 
 
CREATE OR REPLACE VIEW op_department_view AS 
SELECT* 
FROM department_op; 
 
CREATE OR REPLACE VIEW op_vendor_view AS 
SELECT* 
FROM vendor_op; 
 
-- inventory views -- 
CREATE OR REPLACE VIEW inv_inv_view AS 
SELECT * 
FROM inventory_inv; 
 
CREATE OR REPLACE VIEW wh_inv_view AS 
SELECT * 
FROM warehouse_inv; 
 
CREATE OR REPLACE VIEW prod_inv_view AS 
SELECT * 
FROM product_inv; 
 
-- customer views -- 
CREATE OR REPLACE VIEW op_cust_view AS 
SELECT * 
FROM customer_op; 
 
CREATE OR REPLACE VIEW cc_call_view AS 
SELECT * 
FROM call_log_cc; 
  
CREATE OR REPLACE VIEW op_cust_add AS 
SELECT * 
FROM customer_address_op; 
 
-- vendor views --  
 
CREATE OR REPLACE VIEW op_vend_view AS 
SELECT * 
FROM vendor_op; 
 
CREATE OR REPLACE VIEW op_ctry_view AS 
SELECT * 
FROM country_op; 
 
CREATE OR REPLACE VIEW op_prod_view AS 
SELECT * 
FROM product_op; 
CREATE OR REPLACE VIEW order_details_view AS 
SELECT * 
FROM order_details_op; 
 
commit; 
 
-- MEASURES TABLE ETL -- 
 
CREATE OR REPLACE PROCEDURE measures_etl_proc 
AS 
BEGIN 
    INSERT INTO measures_dw  
    SELECT ccv.call_id, iiv.inventory_id, piv.vendor_id, ccv.cust_id, iiv.product_id, odv.quantity, odv.unitprice, iiv.quantity_on_hand, iiv.quantity_available 
    FROM cc_call_view ccv 
    JOIN order_details_view odv ON ccv.order_id = odv.order_id 
    JOIN inv_inv_view iiv ON odv.product_id = iiv.product_id 
    JOIN prod_inv_view piv ON piv.product_id = odv.product_id 
    LEFT JOIN measures_dw mdw 
    ON ccv.call_id = mdw.call_id 
    WHERE mdw.call_id IS NULL; 
 
    -- UPDATE from opv_view -- 
    MERGE INTO measures_dw mdw 
        USING (SELECT ccv.call_id, iiv.inventory_id, piv.vendor_id, ccv.cust_id, iiv.product_id, odv.quantity, odv.unitprice, iiv.quantity_on_hand, iiv.quantity_available 
    FROM cc_call_view ccv 
    JOIN order_details_view odv ON ccv.order_id = odv.order_id 
    JOIN inv_inv_view iiv ON odv.product_id = iiv.product_id 
    JOIN prod_inv_view piv ON piv.product_id = odv.product_id) oip  
        ON (oip.call_id = mdw.call_id) 
    WHEN MATCHED THEN 
        UPDATE SET         mdw.inventory_id = oip.inventory_id,         mdw.vendor_id = oip.vendor_id,         mdw.cust_id = oip.cust_id,         mdw.product_id = oip.product_id,         mdw.quantity = oip.quantity,         mdw.unit_price = oip.unitprice,         mdw.quantity_on_hand = oip.quantity_on_hand,         mdw.quantity_available = oip.quantity_available 
    WHEN NOT MATCHED THEN 
        INSERT (call_id, inventory_id, vendor_id, cust_id, product_id, quantity, unit_price, quantity_on_hand, quantity_available) 
        VALUES (oip.call_id, oip.inventory_id, oip.vendor_id, oip.cust_id, oip.product_id, oip.quantity, oip.unitprice, oip.quantity_on_hand, oip.quantity_available); 
  
    COMMIT; 
END; 
/ 
 
-- PRODUCT TABLE ETL -- 
CREATE OR REPLACE PROCEDURE product_etl_proc 
AS 
BEGIN 
    INSERT INTO product_dw  
    SELECT opv.product_id, opv.product_name, odv.dept_name, ovv.vendor_name, opv.unit_price 
    FROM op_product_view opv  
    JOIN op_department_view odv ON opv.dept_id = odv.dept_id 
    JOIN op_vendor_view ovv ON ovv.vendor_id = opv.vendor_id 
    LEFT JOIN product_dw prod_dw 
    ON opv.product_id = prod_dw.product_id 
    WHERE prod_dw.product_id IS NULL; 
 
    -- UPDATE from opv_view -- 
    MERGE INTO product_dw prod_dw 
        USING (SELECT opv.product_id, opv.product_name, odv.dept_name, ovv.vendor_name, opv.unit_price 
    FROM op_product_view opv  
    JOIN op_department_view odv ON opv.dept_id = odv.dept_id 
    JOIN op_vendor_view ovv ON ovv.vendor_id = opv.vendor_id) pvd  
        ON (pvd.product_id = prod_dw.product_id) 
    WHEN MATCHED THEN 
        UPDATE SET         prod_dw.product_name = pvd.product_name,         prod_dw.dept_name = pvd.dept_name,         prod_dw.vendor_name = pvd.vendor_name,         prod_dw.unit_price = pvd.unit_price 	 
    WHEN NOT MATCHED THEN 
        INSERT (product_id, product_name, dept_name, vendor_name, unit_price)         VALUES (pvd.product_id, pvd.product_name, pvd.dept_name, pvd.vendor_name, pvd.unit_price); 
  
    COMMIT; 
END; 
/ 
-- INVENTORY TABLE ETL -- 
CREATE OR REPLACE PROCEDURE inventory_etl_proc 
AS 
BEGIN 
    INSERT INTO inventory_dw 
    SELECT iiv.inventory_id, whv.warehouse_address, whv.warehouse_city, 
whv.warehouse_region, piv.product_name, iiv.quantity_on_hand, iiv.quantity_available 
    FROM inv_inv_view iiv 
    JOIN wh_inv_view whv ON whv.warehouse_id = iiv.warehouse_id 
    JOIN prod_inv_view piv ON piv.product_id = iiv.product_id 
    LEFT JOIN inventory_dw inv_dw 
    ON iiv.inventory_id = inv_dw.inventory_id 
    WHERE inv_dw.inventory_id IS NULL; 
 
    -- UPDATE from iiv_view -- 
    MERGE INTO inventory_dw inv_dw 
        USING (SELECT iiv.inventory_id, whv.warehouse_address, whv.warehouse_city, whv.warehouse_region, piv.product_name, iiv.quantity_on_hand, iiv.quantity_available 
    FROM inv_inv_view iiv 
    JOIN wh_inv_view whv ON whv.warehouse_id = iiv.warehouse_id 
    JOIN prod_inv_view piv ON piv.product_id = iiv.product_id) iwp  
        ON (iwp.inventory_id = inv_dw.inventory_id) 
    WHEN MATCHED THEN 
        UPDATE SET         inv_dw.warehouse_address = iwp.warehouse_address,         inv_dw.warehouse_city = iwp.warehouse_city,         inv_dw.warehouse_region = iwp.warehouse_region,         inv_dw.product_name = iwp.product_name,         inv_dw.quantity_on_hand = iwp.quantity_on_hand,         inv_dw.quantity_available = iwp.quantity_available 
    WHEN NOT MATCHED THEN 
        INSERT (inventory_id, warehouse_address, warehouse_city, warehouse_region, product_name, quantity_on_hand, quantity_available) 
        VALUES (iwp.inventory_id, iwp.warehouse_address, iwp.warehouse_city, 
iwp.warehouse_region, iwp.product_name, iwp.quantity_on_hand, iwp.quantity_available); 
  
    COMMIT; 
END; 
/ 
 
-- CUSTOMER ETL -- 
CREATE OR REPLACE PROCEDURE customer_etl_proc 
AS 
BEGIN 
    INSERT INTO customer_dw  
    SELECT cust.cust_id, cv.time, cv.duration, cust.first_name, cust.last_name, cust.birthdate, cust.email, cust.prime_status, cust.phone_number, cust.member_start_date,            oca.cust_address, oca.cust_city, oca.cust_region  
    FROM op_cust_view cust 
    JOIN cc_call_view cv ON cust.cust_id = cv.cust_id 
    JOIN op_cust_add oca ON cust.cust_id = oca.cust_id 
    LEFT JOIN customer_dw cdw 
    ON cust.cust_id = cdw.cust_id; 
 
    -- UPDATE from opv_view -- 
    MERGE INTO customer_dw cust_dw 
        USING (SELECT cust.cust_id, cv.time, cv.duration, cust.first_name, cust.last_name, cust.birthdate, cust.email, cust.prime_status, cust.phone_number, cust.member_start_date,        oca.cust_address, oca.cust_city, oca.cust_region  
    FROM op_cust_view cust 
    JOIN cc_call_view cv ON cust.cust_id = cv.cust_id 
    JOIN op_cust_add oca ON cust.cust_id = oca.cust_id) cco  
        ON (cco.cust_id = cust_dw.cust_id) 
    WHEN MATCHED THEN 
        UPDATE SET         cust_dw.call_time = cco.time,         cust_dw.call_duration = cco.duration,         cust_dw.first_name = cco.first_name,         cust_dw.last_name = cco.last_name,         cust_dw.birthdate = cco.birthdate,         cust_dw.email = cco.email,         cust_dw.prime_status = cco.prime_status,         cust_dw.phone_number = cco.phone_number,         cust_dw.member_start_date = cco.member_start_date,         cust_dw.cust_address = cco.cust_address,         cust_dw.cust_city = cco.cust_city,         cust_dw.cust_region = cco.cust_region 
    WHEN NOT MATCHED THEN 
        INSERT (cust_id, call_time, call_duration, first_name, last_name, birthdate, email, prime_status, phone_number, member_start_date,         cust_address, cust_city, cust_region) 
        VALUES (cco.cust_id, cco.time, cco.duration, cco.first_name, cco.last_name, cco.birthdate, cco.email, cco.prime_status, cco.phone_number, cco.member_start_date,         cco.cust_address, cco.cust_city, cco.cust_region); 
 	 
    COMMIT; 
END; 
/
 

EXECUTE measures_etl_proc; 
EXECUTE product_etl_proc; 
EXECUTE inventory_etl_proc; 
EXECUTE customer_etl_proc; 

