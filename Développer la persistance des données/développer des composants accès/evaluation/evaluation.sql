--exercice1 Requêtes d'intérrogation sur la base NorthWind

--1  Liste des contacts français :
SELECT CompanyName as Société,contactName as contact,contactTitle as Fonction,phone as Téléphone
from customers 
WHERE country = 'France' ;

--2  Produits vendus par le fournisseur « Exotic Liquids » 
SELECT ProductName AS Produit, UnitPrice AS Prix 
FROM products 
JOIN suppliers 
ON suppliers.SupplierID=products.SupplierID 
WHERE suppliers.CompanyName="Exotic Liquids";

--3  Nombre de produits vendus par les fournisseurs Français dans l’ordre décroissant
SELECT suppliers.CompanyName as Fournisseur,COUNT(*) as Nbre_produits
from suppliers 
join products 
on  products.SupplierID = suppliers.SupplierID 
WHERE suppliers.country = 'France'
GROUP BY Fournisseur
ORDER BY Nbre_produits DESC ;

--4  Liste des clients Français ayant plus de 10 commandes
SELECT c.CompanyName as "Client" , COUNT(*) as "Nbre_commande"
from customers c 
join orders o 
on c.CustomerID  = o.CustomerID 
WHERE c.Country = 'France' 
GROUP BY Client
HAVING Nbre_commande > 10;

--5 Liste des clients ayant un chiffre d’affaires > 30.000 
SELECT c.CompanyName as "Client",SUM(od.UnitPrice * od.Quantity) as "CA" ,c.Country as "Pays"
from customers c 
join orders o on c.CustomerID  = o.CustomerID 
JOIN  `order details` od  on o.OrderID = od.OrderID 
GROUP BY Client ,Pays
HAVING CA > 30000
ORDER BY CA DESC ;

--6 Liste des pays dont les clients ont passé commande de produits fournis par « Exotic Liquids » :
SELECT DISTINCT  c.Country as "Pays"
from customers c 
join orders o  on c.CustomerID = o.CustomerID 
JOIN `order details` od on o.OrderID =od.OrderID 
JOIN products p on od.ProductID = p.ProductID 
JOIN suppliers s on p.SupplierID =s.SupplierID 
WHERE s.CompanyName = 'Exotic Liquids'
ORDER BY Pays ASC ;

--7 Montant des ventes de 1997 
SELECT SUM(od.UnitPrice * od.Quantity)as "Montant Vente 97"
from `order details` od 
join orders o on od.OrderID = o.OrderID 
WHERE YEAR(o.OrderDate) = "1997";

--8 Montant des ventes de 1997 mois par mois 
SELECT MONTH(o.OrderDate)as "Mois 97",SUM(od.UnitPrice * od.Quantity)as "Montant Vente "
from orders o 
join `order details` od on o.OrderID = od.OrderID 
WHERE YEAR (o.OrderDate)= "1997"
GROUP BY `Mois 97`;

--9 Depuis quelle date le client « Du monde entier » n’a plus commandé ?
SELECT Max(o.OrderDate) as "Date de dernière commande"
from orders o 
join customers c on o.CustomerID = c.CustomerID 
WHERE c.CompanyName = "du monde entier";

--10 Quel est le délai moyen de livraison en jours ?
SELECT ROUND(AVG(DATEDIFF(o.ShippedDate , o.OrderDate)))  as "Délai moyen de livraison en jours"
from orders o 


--2) Procédures stockées
--requête 9
DELIMITER |
CREATE PROCEDURE der_cli_commande (p_CompanyName varchar(40))
BEGIN
	
	SELECT Max(o.OrderDate) as "Date de dernière commande"
	from orders o 
	join customers c on o.CustomerID = c.CustomerID 
	WHERE c.CompanyName = p_CompanyName ;
	
END |
DELIMITER ;

--pour l'appeler
CALL der_cli_commande ('Du monde entier');

--requête 10 
DELIMITER |
CREATE PROCEDURE delai_moy_livraison ()
    BEGIN
    	SELECT ROUND(AVG(DATEDIFF(o.ShippedDate , o.OrderDate)))  as "Délai moyen de livraison en jours"
        from orders o ;	
    END |
DELIMITER ;

--pour l'appeler
CALL delai_moy_livraison();


--3) Mise en place d'une règle de gestion
/*
L'entreprise souhaite mettre en place cette règle de gestion:

Pour tenir compte des coûts liés au transport, on vérifiera que pour chaque produit d’une commande, le client réside dans le même pays que le fournisseur du même produit

Il s'agit d'interdire l'insertion de produits dans les commandes ne satisfaisants pas à ce critère.

Décrivez par quel moyen et avec quels outils (procédures stockées, trigger...) vous pourriez implémenter la règle de gestion suivante. */


-- avec un trigger/déclencheur pour empêcher l'insertion du produit dans la commande si le client n'ai pas du même pays que le fournisseur

--requete pour trouver le produit client et que le client soit du même pays que le fournisseur.
                SELECT p.ProductID 
				from customers c 
				join orders o on c.CustomerID  = o.CustomerID 
				JOIN `order details` od on o.OrderID = od.OrderID 
				JOIN products p on od.ProductID = p.ProductID 
				JOIN suppliers s on p.SupplierID = s.SupplierID 
				WHERE s.Country = c.Country 


DROP TRIGGER IF EXISTS `paysCli_paysFou`;
DELIMITER |
CREATE trigger paysCli_paysFou
AFTER INSERT 
on `order details` 
FOR EACH ROW 
BEGIN 
	DECLARE pro_existe varchar(50);
	SET pro_existe = (SELECT `order details`.ProductID
                     FROM `order details`
                     JOIN orders
                     ON `order details`.OrderID=orders.OrderID
                     JOIN customers
                     ON customers.CustomerID=orders.CustomerID
                     JOIN products
                     ON `order details`.ProductID=products.ProductID
                     JOIN suppliers 
                     ON products.SupplierID=suppliers.SupplierID
                     WHERE `order details`.OrderID=NEW.OrderID
                     AND `order details`.ProductID=NEW.ProductID
                     AND customers.Country=suppliers.Country); 
	IF pro_existe IS NULL
	THEN
		SIGNAL SQLSTATE '40000' SET MESSAGE_TEXT = 'Les pays de client et fournisseur ne correspondent pas';
	end if;
END |
DELIMITER ;

--version oceane

DELIMITER |
CREATE TRIGGER paysClientpaysFournisseur
AFTER INSERT 
ON `order details`
FOR EACH ROW
  BEGIN
     DECLARE p_existe varchar(50); 
     SET p_existe = (SELECT `order details`.ProductID
                     FROM `order details`
                     JOIN orders
                     ON `order details`.OrderID=orders.OrderID
                     JOIN customers
                     ON customers.CustomerID=orders.CustomerID
                     JOIN products
                     ON `order details`.ProductID=products.ProductID
                     JOIN suppliers 
                     ON products.SupplierID=suppliers.SupplierID
                     WHERE `order details`.OrderID=NEW.OrderID
                     AND `order details`.ProductID=NEW.ProductID
                     AND customers.Country=suppliers.Country); 
     IF IS NULL(p_existe) 
       THEN  
         SIGNAL SQLSTATE '40000' SET MESSAGE_TEXT = 'Les pays de client et fournisseur ne correspondent pas';
     END IF;
  END |
DELIMITER ;

