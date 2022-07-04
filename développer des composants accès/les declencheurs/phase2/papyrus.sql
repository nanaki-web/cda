--Créer une table ARTICLES_A_COMMANDER avec les colonnes :

    --CODART : Code de l'article, voir la table produit
    --DATE : date du jour (par défaut)
    --QTE : à calculer

--mariadb
CREATE OR REPLACE TABLE article_a_commander(
    id INT  NOT NULL AUTO_INCREMENT,
    codart CHAR(4) NOT NULL,
    date_u DATE NOT NULL DEFAULT CURDATE(),
    qte INT NOT NULL,
    PRIMARY KEY(id),
	FOREIGN KEY(codart) REFERENCES produit(codart)
    );

    --ou sur mysql
    CREATE TABLE article_a_commander(
    id INT  NOT NULL AUTO_INCREMENT,
    codart CHAR(4) NOT NULL,
    date_u DATETIME NOT NULL DEFAULT current_timestamp,
    qte INT NOT NULL,
    PRIMARY KEY(id),
	FOREIGN KEY(codart) REFERENCES produit(codart)
    );

    --Créer un déclencheur UPDATE sur la table produit : lorsque le stock physique devient inférieur ou égal au stock d'alerte, une nouvelle ligne est insérée dans la table ARTICLES_A_COMMANDER.

--Attention, il faut prendre en compte les quantités déjà commandées dans la table ARTICLES_A_COMMANDER .

--Pour comprendre le problème :

--Soit l'article I120, le stock d'alerte = 5, le stock physique = 20

    --Nous retirons 15 produits du stock. stock d'alerte = 5, le stock physique = 5, le stock physique n'est pas inférieur au stock d'alerte, on ne fait rien.

    --Nous retirons 1 produit du stock. stock d'alerte = 5, le stock physique = 4, le stock physique est inférieur au stock d'alerte, nous devons recommander des produits. Nous insérons une ligne dans la table ARTICLES_A_COMMANDER avec QTE = (stock alerte - stock physique) = 1

    --Nous retirons 2 produit du stock. stock d'alerte = 5, le stock physique = 2. le stock physique est inférieur au stock d'alerte, nous devons recommander des produits. Nous insérons une ligne dans la table ARTICLES_A_COMMANDER avec QTE = (stock alerte - stock physique) – quantité déjà commandée dans ARTICLES_A_COMMANDER : QTE = (5 - 2) – 1 = 2

DELIMITER |
CREATE TRIGGER art_a_commander AFTER UPDATE ON produit
   FOR EACH ROW
   BEGIN
   DECLARE stk_ale INT;
   DECLARE stk_phy INT;
   DECLARE stk_a_com INT;
   DECLARE stk_deja_com INT;
   DECLARE cod_art CHAR(4);
   SET cod_art = NEW.codart;
   SET stk_ale = NEW.stkale;
   SET stk_phy = NEW.stkphy;
   IF (stk_ale>stk_phy) THEN
   	IF cod_art = ANY (SELECT codart FROM article_a_commander) THEN
   		SET stk_deja_com = (SELECT SUM(qte) FROM article_a_commander WHERE codart=cod_art);
   	   SET stk_a_com = (stk_ale-stk_phy)-(stk_deja_com);
      	INSERT INTO article_a_commander (codart, qte) VALUES (cod_art, stk_a_com);
      ELSE
      	SET stk_a_com = (stk_ale)-(stk_phy);
      	INSERT INTO article_a_commander (codart, qte) VALUES (cod_art, stk_a_com);
    	END IF;	  
    END IF;	
END |
DELIMITER ;



--test
UPDATE produit SET stkphy=9 WHERE codart='I110';



