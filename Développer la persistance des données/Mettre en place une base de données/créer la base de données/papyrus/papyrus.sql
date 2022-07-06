DROP DATABASE IF EXISTS papyrus;
CREATE DATABASE papyrus;
use papyrus;

CREATE TABLE produit(
   codart char(4) NOT NULL,
   libart VARCHAR(30) NOT NULL,
   stkphy INT NOT NULL,
   qteann INT NOT NULL,
   unimes CHAR(5) NOT NULL,
   stkale char(5) NOT NULL,
   PRIMARY KEY(codart)
);

CREATE TABLE fournis(
   numfou TINYINT(10) Not NULL,
   nomfou VARCHAR(25) NOT NULL,
   ruefou VARCHAR(50) NOT NULL,
   posfou CHAR(5) NOT NULL,
   vilfou VARCHAR(30) NOT NULL,
   confou VARCHAR(15) NOT NULL,
   satisf TINYINT(4) NOT NULL,
   PRIMARY KEY(numfou)
);

CREATE TABLE entcom(
   numcom INT not null AUTO_INCREMENT,
   obscom VARCHAR(50) default null ,
   datecom timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
   numfou TINYINT(10) default null, 
   PRIMARY KEY(numcom),
   FOREIGN KEY(numfou) REFERENCES fournis(numfou)
);

CREATE TABLE ligcom(
   numlig TINYINT(10) not null,
   qtecde INT NOT NULL,
   prixuni DECIMAL(9,2) NOT NULL,
   qteliv INT default NULL,
   codart char(4) NOT NULL,
   numcom INT NOT NULL,
   PRIMARY KEY(numlig),
   FOREIGN KEY(codart) REFERENCES produit(codart),
   FOREIGN KEY(numcom) REFERENCES entcom(numcom)
);

CREATE TABLE vente(
   codart char(4) not null,
   numfou TINYINT(10) not null,
   delliv smallint(2)  NOT NULL,
   qte1 INT,
   prix1 decimal(9,2)  NOT NULL,
   qte2 INT default NULL,
   prix2 decimal(9,2)  default NULL,
   qte3 INT NOT NULL,
   prix3 decimal(9,2)  default NULL,
   PRIMARY KEY(codart, numfou),
   FOREIGN KEY(codart) REFERENCES produit(codart),
   FOREIGN KEY(numfou) REFERENCES fournis(numfou)
);

create index numfou_index
on entcom (numfou);
