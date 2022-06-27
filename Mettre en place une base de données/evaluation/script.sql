DROP DATABASE IF EXISTS exercice;
CREATE DATABASE exercice;
use exercice;
CREATE TABLE client(
   cli_num INT AUTO_INCREMENT,
   cli_nom VARCHAR(50)  NOT NULL,
   cli_adresse VARCHAR(50)  NOT NULL,
   cli_tel VARCHAR(30)  NOT NULL,
   PRIMARY KEY(cli_num)
);

CREATE TABLE commande(
   com_num INT AUTO_INCREMENT,
   com_date_ DATETIME NOT NULL,
   com_obs VARCHAR(50) ,
   cli_num INT NOT NULL,
   PRIMARY KEY(com_num),
   UNIQUE(cli_num),
   FOREIGN KEY(cli_num) REFERENCES client(cli_num)
);

CREATE TABLE produit(
   pro_num INT AUTO_INCREMENT,
   pro_libelle VARCHAR(50)  NOT NULL,
   pro_description VARCHAR(50)  NOT NULL,
   PRIMARY KEY(pro_num)
);

CREATE TABLE est_compose(
   com_num INT,
   pro_num INT,
   est_qte INT NOT NULL,
   PRIMARY KEY(com_num, pro_num),
   FOREIGN KEY(com_num) REFERENCES commande(com_num),
   FOREIGN KEY(pro_num) REFERENCES produit(pro_num)
);

CREATE INDEX index_cli_nom ON client (cli_nom);
