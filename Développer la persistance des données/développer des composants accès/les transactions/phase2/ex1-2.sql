-- exercice1

--Sous PhpMyAdmin, après avoir sélectionné votre base Papyrus codez
--le script suivant et exécutez-le :

START TRANSACTION 
SELECT nomfou FROM fournis WHERE numfou =120;
UPDATE fournis SET numfou='GROSBRIGAND'WHERE numfou=120
SELECT nomfou FROM fournis WHERE numfou=120


--L'instruction START TRANSACTION est suivie d'une instruction UPDATE, mais aucune instruction COMMIT ou ROLLBACK correspondante n'est présente.

    --Que concluez-vous ? 

--La transaction gère les requêtes les unes après les autres

--Les données sont-elles modifiables par d'autres utilisateurs (ouvrez une nouvelle fenêtre de requête pour interroger le fournisseur 120 par une instruction SELECT) ? 
--oui

--La transaction est-elle terminée ? 
--Sans commit la transaction n'est pas terminer car elle ne sait pas quand s'arrêter

--Comment rendre la modification permanente ? 
--Avec commit


--Comment annuler la transaction ? 
--Avec rollback


--Exercice 2 

--Dans l'exercice précédent, nous avons vu que d'autres utilisateurs ne pouvaient pas accéder
-- à l'interrogation de la ligne tant que la transaction n'était pas terminée.

--Pourquoi ? 
--Isolée : Les données sont verrouillées : il n’est pas possible depuis une autre transaction de visualiser les données en cours de modification dans une transaction.

--Recommencez l'exécution du script de l'exercice précédent, puis ouvrez une nouvelle fenêtre (Ctrl N dans Heidi SQL), et essayez de vérouiller la fournis en ecriture.

-- il s'execute a l'infini 

--Interrogez le fournisseur 120. Que constatez-vous ? Expliquez. 
-- je peux lire l'information . 

