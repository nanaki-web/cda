USE papyrus;
-- utilisateur1
CREATE USER 'user1'@'%' IDENTIFIED BY '1ksable';

--utilisateur2
CREATE USER 'user2'@'%' IDENTIFIED BY '2ksable';

-- utilisateur3
CREATE USER 'user3'@'%' IDENTIFIED BY '3ksable';

-- tout les privilèges pour utilisateur1
GRANT ALL PRIVILEGES 
ON papyrus.* TO 'user1'@'%';

-- pour utlisateur2 ,afficher uniquement pour tout la base papyrus
GRANT select
ON papyrus.*
to 'user2'@'%';

-- pour l'utilisateur3 , afficher juste la table fournis pour la base papyrus
GRANT select
ON papyrus.fournis 
to 'user3'@'%';

