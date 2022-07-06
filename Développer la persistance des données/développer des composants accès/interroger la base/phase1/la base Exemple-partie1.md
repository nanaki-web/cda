**exercice base exemple**


1- Select * 
from employe;

2- Select *
from dept;

3- select nom,dateemb,nosup,nodep,salaire 
from employe;

4- select titre
from employe;

5- select DISTINCT titre
from employe;

6- select nom,noemp,nodep 
from employe
where titre = "secretaire";

7- select nom , nodep
from employe
where nodep > 40;

8- select nom ,prenom
from employe
order by nom > prenom;

9- select nom,salaire,nodept
from employe
where titre = "representant" and nodept = 35 and salaire > 20000;

10- select nom,titre,salaire
from employe
where titre = "representant" or titre = "secretaire";

11- select nom,titre,nodep,salaire
from employe
where nodep = "34" and titre = "representant" or titre= "secretaire";

12- select nom,nodep,salaire
from employe
where titre = "representant" or titre ="secretaire" and nodep = "34";

13- select nom,salaire
from employe
where salaire > 20000 and salaire < 30000;

15- select nom 
from employe
where nom like "H%";

16- select nom
from employe
where nom like "%n";

17- select nom
from employe
where nom like "__U%";

18- select salaire,nom
from employe 
where nodep = "41" 
order by salaire ;

19- select nom,salaire
from employe
where nodep= '41'
order by salaire desc;

20- select titre,salaire,nom
from employe
order by titre , salaire desc;

21- select tauxcom,salaire,nom
from employe
order by tauxcom;

22- select nom,salaire,tauxcom,titre
from employe
where tauxcom is null ;

23- select nom,salaire,tauxcom,titre
from employe
where tauxcom is not null;

24- select nom,salaire,tauxcom,titre
from employe
where tauxcom < 15;

25- select nom,salaire,tauxcom,titre
from employe
where tauxcom > 15;

26- select nom ,salaire,tauxcom,(salaire * tauxcom) as 'commission'
from employe
where tauxcom is not null;

27- select nom,salaire,tauxcom,(salaire * tauxcom) as 'commission'
from employe
where tauxcom is not null
order by tauxcom;

28- select concat(nom,prenom) as 'nom et prenom'
from employe;

29- select substring(nom,1,5)
from employe;

30- select nom,locate('r',nom)
from employe;

31- select nom , upper (nom),lower(nom)
from employe
where nom ='Vrante';

32- select nom ,length(nom)
from employe;