--Afficher la liste des hôtels avec leur station

CREATE view liste_hotel_station
as
select hot_nom,sta_nom
from hotel 
join station 
on hot_sta_id = sta_id;

select * from liste_hotel_station;

-- Afficher la liste des chambres et leur hôtel

CREATE view chambre_hotel
as
select hot_nom,cha_numero
from hotel
join chambre on hot_id = cha_hot_id ;

SELECT * FROM  chambre_hotel;

--Afficher la liste des réservations avec le nom des clients

CREATE view reservations_clients
as
select res_date_debut,cli_nom
from client
join reservation on cli_id = res_cli_id ;

SELECT * FROM reservations_clients ;

--Afficher la liste des chambres avec le nom de l’hôtel et le nom de la station

CREATE view chambre_hotel_station
as
select cha_numero,hot_nom,sta_nom
from chambre
join hotel on cha_hot_id = hot_id 
JOIN station on hot_sta_id  = sta_id ;

SELECT * FROM chambre_hotel_station;

--Afficher les réservations avec le nom du client et le nom de l’hôtel
CREATE view reservations_clients_hotel
as
select res_date,cli_nom,hot_nom
from hotel
join chambre on hot_id = cha_hot_id 
join reservation on cha_id = res_cha_id 
join client on res_cli_id = cli_id

select * from reservations_clients_hotel;