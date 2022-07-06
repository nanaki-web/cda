IV LES BESOINS DE MISE A JOUR


--1. Application dune augmentation de tarif de 4% pour le prix 1 et de 2%
--pour le prix2 pour le fournisseur 9180
 UPDATE vente SET prix1= prix1*0.4, prix2= prix2 *0.2
 WHERE numfou =9180


--2. Dans la table vente, mettre à jour le prix2 des articles dont le prix2 est
--null, en affectant a prix2 la valeur de prix1.SET entcom.obscom = "*****"
 UPDATE vente SET prix2= prix1
 WHERE prix2 IS NULL



--3. Mettre à jour le champ obscom en positionnant '*****' pour toutes les
--commandes dont le fournisseur a un indice de satisfaction < 5 
UPDATE entcom 
JOIN fournis
ON entcom.numfou =fournis.numfou
SET entcom.obscom = "*****"
WHERE	fournis.satisf < 5



--4. Suppression du produit I110              
DELETE FROM vente
WHERE codart = 'I110';

DELETE FROM produit
WHERE codart = 'I110';


--5. Suppression des entête de commande qui n'ont aucune ligne

DELETE ent FROM entcom ent LEFT JOIN ligcom lig ON ent.numcom = lig.numcom
WHERE lig.numcom IS NULL