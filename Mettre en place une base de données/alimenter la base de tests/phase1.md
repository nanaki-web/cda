*** script pour les données de la base Hotel***

INSERT INTO Station (station_nom)
VALUES   ("station1"),
  ("station2"),
  ("station3");
  ********************************************
***script pour les données de l'hotel***
INSERT INTO Hotel (hotel_capacite,hotel_categorie,hotel_nom,hotel_adresse,station_num)
VALUES 
  (30,"3","Inceptos Hymenaeos LLP","501 Dui Avenue",6),
  (40,"4","438-627 Vulputate Rue","Ipsum Dolor Industries",7),
  (45,"1","167-4543 Ante. Ave","Mauris Eu Limited",8),
  (30,"4","hotel1","1501 Dui Avenue",6),
  (35,"2","hotel2","1601 Dui Avenue",7),
  (50,"3","hotel3","1501 Pui Avenue",8);
  ************************
***script pour la table chambre de la base Hotel***
INSERT INTO chambre (chambre_capacite,chambre_degre_confort,chambre_exposition,chambre_type,hotel_num)
VALUES 
("capacite1","confort1","ouest","type1",4),
("capacite2","confort2","nord","type2",4),
("capacite3","confort3","sud","type3",4),
("capacite1","confort1","ouest","type1",5),
("capacite2","confort2","ouest","type2",5),
("capacite1","confort1","nord","type1",5),
("capacite1","confort1","ouest","type1",6),
("capacite2","confort3","est","type2",6),
("capacite1","confort1","ouest","type1",6),
("capacite1","confort1","ouest","type1",7),
("capacite1","confort4","nord","type1",7),
("capacite1","confort1","ouest","3",7),
("capacite1","confort1","ouest","type1",8),
("capacite1","confort4","ouest","type3",8),
("capacite1","confort1","ouest","type1",8),
("capacite1","confort2","ouest","type1",9),
("capacite1","confort1","ouest","type2",9),
("capacite1","confort1","ouest","type1",9);