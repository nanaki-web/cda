create database if not exists hotel;
use hotel;
CREATE TABLE Station(
   station_num INT AUTO_INCREMENT,
   station_nom VARCHAR(50)  NOT NULL,
   PRIMARY KEY(station_num)
);


CREATE TABLE client(
   client_num INT AUTO_INCREMENT,
   client_adresse VARCHAR(50)  NOT NULL,
   client_nom VARCHAR(50)  NOT NULL,
   client_prenom VARCHAR(50)  NOT NULL,
   PRIMARY KEY(client_num)
);

CREATE TABLE Hotel(
   hotel_num INT AUTO_INCREMENT,
   hotel_capacite INT NOT NULL,
   hotel_categorie VARCHAR(50)  NOT NULL,
   hotel_nom VARCHAR(50)  NOT NULL,
   hotel_adresse VARCHAR(50)  NOT NULL,
   station_num INT NOT NULL,
   PRIMARY KEY(hotel_num),
   FOREIGN KEY(station_num) REFERENCES Station(station_num)
);

CREATE TABLE chambre(
   chambre_num INT AUTO_INCREMENT,
   chambre_capacite VARCHAR(10)  NOT NULL,
   chambre_degre_confort VARCHAR(30)  NOT NULL,
   chambre_exposition VARCHAR(50)  NOT NULL,
   chambre_type VARCHAR(20)  NOT NULL,
   hotel_num INT NOT NULL,
   PRIMARY KEY(chambre_num),
   FOREIGN KEY(hotel_num) REFERENCES Hotel(hotel_num) 
);

CREATE TABLE reservation(
   chambre_num INT,
   client_num INT,
   reservation_date_debut DATE NOT NULL,
   reservation_date_fin VARCHAR(50)  NOT NULL,
   reservation_date DATE,
   reservation_montant_arrhes DECIMAL(15,2)   NOT NULL,
   reservation_prix_total DECIMAL(15,2)   NOT NULL,
   PRIMARY KEY(chambre_num, client_num),
   FOREIGN KEY(chambre_num) REFERENCES chambre(chambre_num),
   FOREIGN KEY(client_num) REFERENCES client(client_num)
);
