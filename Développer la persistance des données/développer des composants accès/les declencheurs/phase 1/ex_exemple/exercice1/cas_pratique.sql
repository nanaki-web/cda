--exercice

--A partir de l'exemple suivant, créez les déclencheurs suivants :
--Sur la base hotel, prenons un exemple d'une règle de gestion.

CREATE TRIGGER insert_station AFTER INSERT ON station
    FOR EACH ROW
    BEGIN
        DECLARE altitude INT;
        SET altitude = NEW.sta_altitude;
        IF altitude<1000 THEN
            SIGNAL SQLSTATE '40000' SET MESSAGE_TEXT = 'Un problème est survenu. Règle de gestion altitude !';
        END IF;
END;


    --modif_reservation : interdire la modification des réservations (on autorise l'ajout et la suppression).
    CREATE TRIGGER modif_reservation AFTER INSERT ON reservation
        FOR EACH ROW
        BEGIN
            SIGNAL SQLSTATE '40000' SET MESSAGE_TEXT = 'Un problème est survenu. Modification de reservation interdite !';
    END;

    --insert_reservation : interdire l'ajout de réservation pour les hôtels possédant déjà 10 réservations.
    DELIMITER |
    CREATE TRIGGER insert_reservation AFTER INSERT ON reservation
        FOR EACH ROW
        BEGIN 
            DECLARE id_r INT;
            DECLARE hot_r VARCHAR(50);
            DECLARE nbRes INT;
            SET id_r = NEW.res_id; -- nous captons le numéro de réservations
            SET hot_r=(SELECT hot_nom FROM v_5 WHERE res_id=id_r); -- nous captons le nom d'hôtel
            SET nbRes = (SELECT count(*) FROM v_5 WHERE hot_nom=hot_r); --on calcule le nombre de réservations
            IF nbRes>10 THEN
                SIGNAL SQLSTATE '40000' SET MESSAGE_TEXT = 'Un problème est survenu. Règle de gestion réservations !';
            END IF;
        END |
DELIMITER ;
            

    --insert_reservation2 : interdire les réservations si le client possède déjà 3 réservations.

    DELIMITER |
    CREATE TRIGGER insert_reservation2 AFTER INSERT on reservation
        FOR EACH ROW
        BEGIN
            DECLARE id_r_cli INT;
            DECLARE nbres_r_cli INT;
            SET id_r_cli =  NEW.cli_id;
            SET nbres_r_cli = (SELECT COUNT(*) from reservation WHERE res_cli_id = id_r_cli);
                IF nbres_r_cli>3 THEN
                    SIGNAL SQLSTATE '40000' SET MESSAGE_TEXT = 'Un problème est survenu. Règle de gestion réservations !';
                END IF;
        END|
    DELIMITER ;



    --insert_chambre : lors d'une insertion, on calcule le total des capacités des chambres pour l'hôtel, si ce total est supérieur à 50, on interdit l'insertion de la chambre.
    DELIMITER |
    CREATE TRIGGER insert_chambre AFTER INSERT ON chambre
        FOR EACH ROW
        BEGIN
            DECLARE capacite_c INT;
            DECLARE id_h INT;
            SET id_h = NEW.hot_id;
            SET capacite_c =(SELECT SUM(cha_capacite)FROM chambre WHERE cha_hot_id = id_h);
                IF capacite_c > 50 THEN
                    SIGNAL SQLSTATE '40000' SET MESSAGE_TEXT = 'Un problème est survenu. Règle de gestion réservations !';
                END IF;
        END |
    DELIMITER ;

    

    --cas pratique

    --Mettez en place ce trigger, puis ajoutez un produit dans une commande, vérifiez que le champ total est bien mis à jour.
    
    
DELIMITER |    
        CREATE TRIGGER maj_total AFTER INSERT ON lignedecommande
        FOR EACH ROW
        BEGIN
            DECLARE id_c INT;
            DECLARE tot DOUBLE;
            SET id_c = NEW.id_commande; -- nous captons le numéro de commande concerné
            SET tot = (SELECT sum(prix*quantite) FROM lignedecommande WHERE id_commande=id_c); -- on recalcul le total
            UPDATE commande SET total=tot WHERE id=id_c; -- on stocke le total dans la table commande
        END;
DELIMITER ;

--test 
DELETE FROM lignedecommande WHERE id_commande=4;
INSERT INTO lignedecommande(id_commande,id_produit,quantite,prix) VALUES (4,3,5,700);



    


--Ce trigger ne fonctionne que lorsque l'on ajoute des produits dans la commande, les modifications ou suppressions ne permettent pas de recalculer le total. Modifiez le code ci-dessus pour faire en sorte que la modification ou la suppression de produit recalcul le total de la commande.
--Un champ remise était prévu dans la table commande. Prenez en compte ce champ dans le code de votre trigger.
-- Recalculer le total de la commande après  la modification de produit. 
DELIMITER |
CREATE OR REPLACE TRIGGER after_update_total AFTER UPDATE ON lignedecommande
    FOR EACH ROW
    BEGIN
        DECLARE id_c INT;
        DECLARE tot DOUBLE;
        DECLARE remis DOUBLE;
        SET id_c = OLD.id_commande; -- nous captons le numéro de commande concerné
        SET tot = (SELECT sum(prix*quantite) FROM lignedecommande WHERE id_commande=id_c); -- on recalcul le total
        SET remis=(SELECT remise FROM commande WHERE id=id_c); -- nous captons la remise
        UPDATE commande SET total=(tot-remis) WHERE id=id_c; -- on stocke le total dans la table commande
END |
DELIMITER ;

--test
UPDATE lignedecommande SET quantite=5 WHERE id_commande=4;

-- Recalculer le total de la commande après  la suppression de produit .
DELIMITER |
CREATE OR REPLACE TRIGGER after_delete_total AFTER DELETE ON lignedecommande
    FOR EACH ROW
    BEGIN
        DECLARE id_c INT;
        DECLARE tot DOUBLE;
        DECLARE remis DOUBLE;
        SET id_c = OLD.id_commande; -- nous captons le numéro de commande concerné
        SET tot = (SELECT sum(prix*quantite) FROM lignedecommande WHERE id_commande=id_c); -- on recalcul le total
        SET remis=(SELECT remise FROM commande WHERE id=id_c); -- nous captons la remise
        UPDATE commande SET total=(tot-remis) WHERE id=id_c; -- on stocke le total dans la table commande
END |
DELIMITER ;
--test
DELETE FROM lignedecommande WHERE id_commande=4;