--v_GlobalCde correspondant à la requête : A partir de la table Ligcom, afficher par code produit, la somme des quantités commandées et le prix total correspondant : on nommera la colonne correspondant à la somme des quantités commandées, QteTot et le prix total, PrixTot. 
CREATE view v_GlobalCde
as
select  codart as "article ref",SUM(qtecde) as "qteTot",SUM(qtecde * priuni)as "PrixTot"  
from ligcom
group by codart;

-- pour afficher la vue
SELECT * FROM v_GlobalCde;

--afficher la definition d'une vue
--SHOW CREATE VIEW v_nomvue 

--v_VentesI100 correspondant à la requête : Afficher les ventes dont le code produit est le I100 (affichage de toutes les colonnes de la table Vente).
CREATE view v_VentesI100
as
select * FROM vente
WHERE codart = "I100";


select * from v_VentesI100;

--A partir de la vue précédente, créez v_VentesI100Grobrigan remontant toutes les ventes concernant le produit I100 et le fournisseur 00120. 
CREATE view v_VentesI100Grobrigan
as
select * FROM vente
WHERE codart ="I100" AND numfou = "00120";

SELECT * FROM v_VentesI100Grobrigan;

