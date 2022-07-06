CREATE DATABASE IF NOT EXISTS gescom;
use gescom;
CREATE TABLE suppliers(
   sup_id INT AUTO_INCREMENT,
   sup_name VARCHAR(50)  NOT NULL,
   sup_city VARCHAR(50)  NOT NULL,
   sup_adress VARCHAR(150)  NOT NULL,
   sup_mail VARCHAR(75) ,
   sup_phone INT,
   PRIMARY KEY(sup_id)
);

CREATE TABLE customers(
   cus_id INT AUTO_INCREMENT,
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
   ord_order_date DATE NOT NULL,
   ord_ship_date DATE,
   ord_bill_date DATE,
   ord_reception_date DATE,
   ord_status VARCHAR(25)  NOT NULL,
   cus_id INT NOT NULL,
   PRIMARY KEY(ord_id),
   FOREIGN KEY(cus_id) REFERENCES customers(cus_id)
);

CREATE TABLE categories(
   cat_id INT AUTO_INCREMENT,
   cat_name VARCHAR(200)  NOT NULL,
   cat_parent_id VARCHAR(50)  NOT NULL,
   PRIMARY KEY(cat_id)
);

CREATE TABLE products(
   pro_id INT AUTO_INCREMENT,
   pro_ref VARCHAR(10)  NOT NULL,
   pro_name VARCHAR(200)  NOT NULL,
   pro_desc TEXT COLLATE 100 NOT NULL,
   pro_price DECIMAL(6,2)   NOT NULL,
   pro_stock VARCHAR(50) ,
   pro_color VARCHAR(30) ,
   pro_picture VARCHAR(40) ,
   pro_add_date DATE NOT NULL,
   pro_update_date DATETIME NOT NULL,
   pro_publish BIGINT NOT NULL,
   sup_id INT NOT NULL,
   cat_id INT,
   PRIMARY KEY(pro_id),
   FOREIGN KEY(sup_id) REFERENCES suppliers(sup_id),
   FOREIGN KEY(cat_id) REFERENCES categories(cat_id)
);

CREATE TABLE detailler(
   ord_id INT,
   pro_id INT,
   PRIMARY KEY(ord_id, pro_id),
   FOREIGN KEY(ord_id) REFERENCES orders(ord_id),
   FOREIGN KEY(pro_id) REFERENCES products(pro_id)
);
