DROP DATABASE IF EXISTS gescom;
CREATE DATABASE gescom; 
CREATE TABLE suppliers(
   sup_id INT,
   sup_name VARCHAR(50)  NOT NULL,
   sup_city VARCHAR(50)  NOT NULL,
   sup_adress VARCHAR(150)  NOT NULL,
   sup_mail VARCHAR(75) ,
   sup_phone INT(10),
   PRIMARY KEY(sup_id)
);

CREATE TABLE customers(
   cus_id INT,
   cus_lastname VARCHAR(50)  NOT NULL,
   cus_firstname VARCHAR(50)  NOT NULL,
   cus_adress VARCHAR(150)  NOT NULL,
   cus_zipcode VARCHAR(50)  NOT NULL,
   cus_city VARCHAR(50)  NOT NULL,
   cus_mail VARCHAR(75) ,
   cus_phone INT,
   PRIMARY KEY(cus_id)
);

CREATE TABLE orders(
   ord_id INT AUTO_INCREMENT,
   ord_order_date timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP(),
   ord_ship_date DATE,
   ord_bill_date DATE,
   ord_reception_date DATE,
   ord_status VARCHAR(25)  NOT NULL,
   cus_id INT(10) NOT NULL,
   PRIMARY KEY(ord_id),
   FOREIGN KEY(cus_id) REFERENCES customers(cus_id)
);

CREATE TABLE categories(
   cat_id INT AUTO_INCREMENT,
   cat_name VARCHAR(200)  NOT NULL,
   cat_parent_id INT,
   PRIMARY KEY(cat_id),
   FOREIGN KEY(cat_parent_id) REFERENCES categories(cat_id)
);

CREATE TABLE products(
   pro_id INT AUTO_INCREMENT,
   pro_ref VARCHAR(10)  NOT NULL,
   pro_name VARCHAR(200)  NOT NULL,
   pro_desc TEXT(100) NOT NULL,
   pro_price DECIMAL(6,2)   NOT NULL,
   pro_stock VARCHAR(50) ,
   pro_color VARCHAR(30) ,
   pro_picture VARCHAR(40) ,
   pro_add_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
   pro_update_date datetime NOT NULL ON UPDATE CURRENT_TIMESTAMP,
   pro_publish TINYINT(1) NOT NULL,
   sup_id INT NOT NULL,
   cat_id INT,
   PRIMARY KEY(pro_id),
   FOREIGN KEY(sup_id) REFERENCES suppliers(sup_id),
   FOREIGN KEY(cat_id) REFERENCES categories(cat_id)
);

CREATE TABLE details(
   ord_id INT,
   pro_id INT,
   det_price DECIMAL(6,2) NOT NULL,
   det_quantity INT NOT NULL CHECK (det_quantity >=1 AND det_quantity <=100),
   PRIMARY KEY(ord_id, pro_id),
   FOREIGN KEY(ord_id) REFERENCES orders(ord_id),
   FOREIGN KEY(pro_id) REFERENCES products(pro_id)
);

CREATE INDEX pro_ref_index
ON products (pro_ref);
