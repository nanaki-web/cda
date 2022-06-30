**jointures**

1- select e.nom,d.noregion
from employe e
join dept d on e.nodep = d.nodept;

2-  select e.nodep,d.noregion,e.nom
from employe e
join dept d on e.nodep = d.nodept
order by e.nodep;

SELECT e.nom
FROM employe e 
JOIN dept d  ON e.nodep = d.nodept
WHERE d.nom = "distribution";
***********************************
**auto-jointures**


3- SELECT e.nom,e.titre
FROM employe e 
WHERE e.titre IN
(SELECT e.titre FROM employe e WHERE nom = "Amartakaldire");
******************************
**sous-requêtes**

4- SELECT e.nom,e.salaire,e.nodep
from employe e
WHERE e.salaire = ANY(
SELECT MAX(e.salaire) FROM employe e);

5- SELECT e.nom,e.salaire,e.nodep
from employe e
WHERE e.salaire > ANY(
SELECT MAX(e.salaire) FROM employe e WHERE e.nodep = "31")ORDER BY e.nodep AND e.salaire ;

SELECT e.nom,e.salaire,e.nodep
from employe e
WHERE e.salaire > ANY 
(SELECT e.salaire FROM employe e WHERE e.nodep = "31")
ORDER BY e.nodep AND e.salaire ;

6- SELECT e.nom,e.titre
FROM employe e 
WHERE e.nodep = "31" AND e.titre = ANY (SELECT e.titre 
from employe e WHERE e.nodep = "32");


SELECT e.nom,e.titre
FROM employe e 
WHERE e.nodep = "31" AND e.titre NOT IN (SELECT e.titre 
from employe e WHERE e.nodep = "32");


SELECT e.nom ,e.titre,e.salaire
from employe e 
WHERE e.salaire  = ANY (SELECT e.salaire 
from employe e 
WHERE e.titre = ANY (SELECT e.titre from employe e2 WHERE e.nom =ANY (SELECT e.nom from employe e3 
where e.nom = "fairent")) );

ou 

SELECT e.nom ,e.titre,e.salaire
from employe e 
WHERE e.salaire  = ANY (SELECT e.salaire 
from employe e 
WHERE  e.nom = "fairent");
************************************
**requêtes externes**

7- SELECT d.nodept,d.nom ,e.nom 
from dept d 
left join employe e ON d.nodept = e.noemp ;


**les groupes**

8- SELECT e.titre,COUNT(e.noemp) 
from employe e 
group by e.titre ;

SELECT  AVG(e.salaire) as moyenne , SUM(e.salaire) as somme 
from employe e 
group by e.nodep ;
*********************************
**la clause HAVING**
3-
 Afficher les numéros des départements ayant au moins 3 employés

 SELECT e.nodep
from employe e 
group by e.nodep 
HAVING  count(e.noemp)>=3;


4-
afficher les lettres qui sont l'initiale d'au moins trois employés :

SELECT SUBSTR(nom,1,1) AS 'extrait', COUNT(*) AS 'Nb lettres'
FROM employe
-- GROUP BY SUBSTR(nom,1,1) 
GROUP BY extrait 
HAVING COUNT(*) >= 3;

ou

SELECT SUBSTRING(nom, 1, 1) AS Initiale, COUNT(*) AS Nombre_initiale FROM employe 
GROUP BY Initiale
HAVING COUNT(Initiale)>=3;

5-

Rechercher le salaire maximum et le salaire minimum parmi tous les
salariés et l'écart entre les deux.

SELECT MAX(salaire) AS Salaire_max, MIN(salaire) AS Salaire_min, (MAX(salaire)-MIN(salaire)) AS Ecart 
FROM employe;

6-
Rechercher le nombre de titres différents:

SELECT COUNT(DISTINCT (e.titre))
from employe e 


7-
Pour chaque titre, compter le nombre d'employés possédant ce titre:

SELECT DISTINCT titre,COUNT(e.noemp) 
from employe e 
group by e.titre 


8-
Pour chaque nom de département, afficher le nom du département et
le nombre d'employés:

SELECT DISTINCT d.nom ,COUNT(e.noemp)
from dept d 
join employe e on d.nodept = e.nodep 
GROUP BY d.nom 

Rechercher les titres et la moyenne des salaires par titre dont la moyenne est supérieure à la moyenne des salaires des Représentants:
9-
SELECT nodep AS Numéro_département, COUNT(*) 
AS Nombre_employé FROM employe 
GROUP BY nodep 
HAVING COUNT(*)>=3;


10-
Rechercher le nombre de salaires renseignés et le nombre de taux de
commission renseignés:

SELECT COUNT(e.salaire),COUNT(e.tauxcom)
from employe e 


