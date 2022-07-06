*** utilisateur1 ***
CREATE USER 'user1'@'127.0.0.1' IDENTIFIED BY '1ksable';

(mettre au lieu de 127.0.0.1 : % pour indiquer n'importe quelle poste.)
********************
***utilisateur2***
CREATE USER 'user2'@'127.0.0.1' IDENTIFIED BY '2ksable';
********************
***utilisateur3***
CREATE USER 'user3'@'127.0.0.1' IDENTIFIED BY '3ksable';
********************
GRANT ALL PRIVILEGES 
ON papyrus.* TO 'user1'@'127.0.0.1';
********************
GRANT select
ON papyrus.*
to 'user2'@'127.0.0.1';
********************
GRANT select
ON papyrus.fournis 
to 'user3'@'127.0.0.1';

