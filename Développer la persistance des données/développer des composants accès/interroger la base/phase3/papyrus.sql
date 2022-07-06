-- 1. Quelles sont les commandes du fournisseur 9120 ?
SELECT numcom AS Commande, numfou AS Fournisseur FROM entcom WHERE numfou=9120;


--2. Afficher le code des fournisseurs pour lesquels des commandes ont été passées.
SELECT DISTINCT numfou AS Fournisseurs FROM entcom;


--3. Afficher le nombre de commandes fournisseurs passées, et le nombre de fournisseur concernés.
SELECT COUNT(numcom) AS "Nombre de commande", COUNT(DISTINCT numfou) AS "Nombre de fournisseurs"
FROM entcom;



--4. Editer les produits ayant un stock inférieur ou égal au stock d'alerte et
dont la quantité annuelle est inférieur est inférieure à 1000
(informations à fournir : n° produit, libellé produit, stock, stock actuel
dalerte, quantité annuelle)
SELECT codart, libart, stkale, stkphy, qteann
FROM produit
WHERE stkphy<=stkale AND qteann <1000


-- 5. Quels sont les fournisseurs situés dans les départements 75 78 92 77 ?
L’affichage (département, nom fournisseur) sera effectué par
département décroissant, puis par ordre alphabétique
SELECT nomfou AS Fournisseurs, SUBSTR(posfou, 1, 2) AS Département
FROM fournis
WHERE SUBSTR(posfou, 1, 2) IN(75, 78, 92, 77)
ORDER BY SUBSTRING(posfou, 1,2) 
DESC, nomfou ASC;


--6. Quelles sont les commandes passées au mois de mars et avril ?
SELECT numcom, datcom 
FROM entcom
WHERE SUBSTR(datcom ,7,1)IN (3,4)


--7. Quelles sont les commandes du jour qui ont des observations
particulières ?
(Affichage numéro de commande, date de commande)



--8. Lister le total de chaque commande par total décroissant
(Affichage numéro de commande et total)
SELECT numcom AS "numéro de commande",SUM(qtecde*priuni) AS "Total" 
FROM ligcom
GROUP BY numcom ORDER BY Total DESC;


--9. Lister les commandes dont le total est supérieur à 10 000€ ; on exclura
dans le calcul du total les articles commandés en quantité supérieure
ou égale à 1000.
(Affichage numéro de commande et total)
SELECT numcom AS Numéro_commande, SUM(qtecde*priuni) AS Total FROM ligcom WHERE qtecde<1000 GROUP BY numcom HAVING SUM(qtecde*priuni)>10000;


--10. Lister les commandes par nom fournisseur
(Afficher le nom du fournisseur, le numéro de commande et la date)
SELECT nomfou AS Fournisseur, numcom AS Commande, datcom AS Date_commande 
FROM fournis, entcom
WHERE fournis.numfou=entcom.numfou
GROUP BY nomfou;

--11. Sortir les produits des commandes ayant le mot "urgent' en observation?
SELECT entcom.numcom AS Commande, fournis.nomfou AS Fournisseur, produit.libart AS Produit, entcom.obscom AS Observation, SUM(qtecde*priuni) AS Total 
FROM fournis 
JOIN entcom 
ON fournis.numfou=entcom.numfou 
JOIN ligcom 
ON entcom.numcom=ligcom.numcom 
JOIN produit 
ON produit.codart=ligcom.codart 
WHERE entcom.obscom LIKE '%urgent%' 
GROUP BY entcom.numcom, fournis.nomfou, produit.libart;


--12. Coder de 2 manières différentes la requête suivante :
Lister le nom des fournisseurs susceptibles de livrer au moins un article
SELECT fournis.nomfou AS Fournisseur
FROM fournis 
JOIN vente
ON fournis.numfou=vente.numfou
JOIN produit
ON produit.codart=vente.codart
WHERE (stkphy-stkale)>0
GROUP BY fournis.nomfou;



--13. Coder de 2 manières différentes la requête suivante
Lister les commandes (Numéro et date) dont le fournisseur est celui de
la commande 70210 :
SELECT numcom AS Numéro_commande, datcom AS date_commande
FROM entcom
WHERE numfou=(SELECT numfou FROM entcom WHERE numcom=70210);


--14. Dans les articles susceptibles d’être vendus, lister les articles moins
chers (basés sur Prix1) que le moins cher des rubans (article dont le
premier caractère commence par R). On affichera le libellé de l’article
et prix1
On affichera le libellé de l’article et prix1
SELECT produit.libart AS Produit, vente.prix1 AS Prix1 
FROM produit 
JOIN vente 
ON produit.codart=vente.codart 
WHERE vente.prix1 < (SELECT MIN(vente.prix1) AS Ruban_moinCher FROM vente WHERE vente.codart LIKE 'R%');


--15. Editer la liste des fournisseurs susceptibles de livrer les produits
dont le stock est inférieur ou égal à 150 % du stock dalerte. La liste est
triée par produit puis fournisseur
SELECT fournis.nomfou AS Fournisseur, produit.stkphy AS Stock_physique, produit.stkale AS Stock_alerte 
FROM fournis 
JOIN vente 
ON fournis.numfou=vente.numfou 
JOIN produit 
ON produit.codart=vente.codart 
WHERE (stkphy-stkale)>0 
GROUP BY produit.libart, fournis.nomfou 
HAVING stkphy<=(stkale)*1.5;


--16. Éditer la liste des fournisseurs susceptibles de livrer les produit dont
le stock est inférieur ou égal à 150 % du stock dalerte et un délai de
livraison dau plus 30 jours. La liste est triée par fournisseur puis
produit
SELECT fournis.nomfou AS Fournisseur, produit.stkphy AS Stock_physique, produit.stkale AS Stock_alerte 
FROM fournis 
JOIN vente 
ON fournis.numfou=vente.numfou 
JOIN produit 
ON produit.codart=vente.codart 
WHERE (produit.stkphy-produit.stkale)>0 AND vente.delliv>30 
GROUP BY fournis.nomfou, produit.libart 
HAVING produit.stkphy<=(produit.stkale*1.5);


--17. Avec le même type de sélection que ci-dessus, sortir un total des
stocks par fournisseur trié par total décroissant
SELECT fournis.nomfou AS Fournisseur, produit.stkphy AS Stock_physique, produit.stkale AS Stock_alerte, SUM(produit.stkphy) AS Total_stock 
FROM fournis 
JOIN vente 
ON fournis.numfou=vente.numfou 
JOIN produit 
ON produit.codart=vente.codart 
WHERE (produit.stkphy-produit.stkale)>0 AND vente.delliv>30 
GROUP BY fournis.nomfou, produit.libart 
HAVING produit.stkphy<=(produit.stkale*1.5)
ORDER BY SUM(produit.stkphy) DESC;



--18. En fin d'année, sortir la liste des produits dont la quantité réellement
commandée dépasse 90% de la quantité annuelle prévue.
SELECT produit.libart AS Produit, produit.qteann*0.9 AS "Quantite annuelle 90%", ligcom.qtecde AS "Quantite commande"
FROM produit
JOIN ligcom
ON produit.codart=ligcom.codart
WHERE produit.qteann*0.9 < ligcom.qtecde


--19. Calculer le chiffre d'affaire par fournisseur pour l'année 93 sachant
que les prix indiqués sont hors taxes et que le taux de TVA est 20%.
SELECT SUM(qtecde*priuni*1.2) AS "Chiffre d'Affaire", nomfou AS Fournisseur  
FROM ligcom 
JOIN entcom
ON ligcom.numcom=entcom.numcom
JOIN fournis
ON fournis.numfou=entcom.numfou
WHERE YEAR(derliv)=2007
GROUP BY nomfou;