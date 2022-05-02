begin transaction;

create table tempo
	(	
	typecom varchar(50),
	com varchar(50),
	reg varchar(50),
	dep varchar(50),
	arr varchar(50),
	tncc varchar(50),
	ncc varchar(500),
	nccenr varchar(500),
	libelle varchar(500),
	can varchar(50),
	comparent varchar(50)
	);

copy tempo from 'C:/wamp64/www/SLAM/2eme_annee/suivi_dc/migration_base/fic/communes2020.csv' with csv delimiter ',' NULL '' encoding 'utf8';

insert into commune(id_com, nom, nom_accent, dept) 
select com, ncc, libelle, dep::char(2) 
	from tempo
		where typecom <> 'COMD';
	
drop table tempo;	
commit;
vacuum full;
