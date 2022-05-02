begin transaction;

create table tempo
	(	
	nom varchar(100),
	prenom varchar(100), 
	sexe varchar(100),
	date_nais varchar(100), 
	code_com_nais varchar(100), 
	pays_nais varchar(100), 
	date_dc varchar(100), 
	code_com_dc varchar(100)
	);

copy tempo from 'C:/wamp64/www/SLAM/2eme_annee/suivi_dc/migration_base/fic/deces-2021-m01.csv' with csv delimiter ';' NULL '' encoding 'utf8';
copy tempo from 'C:/wamp64/www/SLAM/2eme_annee/suivi_dc/migration_base/fic/deces-2021-m02.csv' with csv delimiter ';' NULL '' encoding 'utf8';
copy tempo from 'C:/wamp64/www/SLAM/2eme_annee/suivi_dc/migration_base/fic/deces-2021-m03.csv' with csv delimiter ';' NULL '' encoding 'utf8';
copy tempo from 'C:/wamp64/www/SLAM/2eme_annee/suivi_dc/migration_base/fic/deces-2021-m04.csv' with csv delimiter ';' NULL '' encoding 'utf8';
copy tempo from 'C:/wamp64/www/SLAM/2eme_annee/suivi_dc/migration_base/fic/deces-2021-m05.csv' with csv delimiter ';' NULL '' encoding 'utf8';
copy tempo from 'C:/wamp64/www/SLAM/2eme_annee/suivi_dc/migration_base/fic/deces-2021-m06.csv' with csv delimiter ';' NULL '' encoding 'utf8';
copy tempo from 'C:/wamp64/www/SLAM/2eme_annee/suivi_dc/migration_base/fic/deces-2021-m07.csv' with csv delimiter ';' NULL '' encoding 'utf8';
copy tempo from 'C:/wamp64/www/SLAM/2eme_annee/suivi_dc/migration_base/fic/deces-2021-m08.csv' with csv delimiter ';' NULL '' encoding 'utf8';
copy tempo from 'C:/wamp64/www/SLAM/2eme_annee/suivi_dc/migration_base/fic/deces-2021-m09.csv' with csv delimiter ';' NULL '' encoding 'utf8';
copy tempo from 'C:/wamp64/www/SLAM/2eme_annee/suivi_dc/migration_base/fic/deces-2020.csv' with csv delimiter ';' NULL '' encoding 'utf8';



insert into dc(nom,prenom,date_nais,date_dc,sexe,id_pays,id_com_nais,id_com_dc)
	select tempo.nom::varchar(30),prenom::varchar(30),date_nais::date,date_dc::date,sexe,id_pays,c1.id_com,c2.id_com 
		from tempo 
		left join pays on pays.nom = tempo.pays_nais
		left join commune c1 on c1.id_com = code_com_nais
		left join commune c2 on c2.id_com = code_com_dc;

drop table tempo;

commit;
vacuum full;