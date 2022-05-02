begin transaction;

create table tempo
	(	
	cog varchar(50),
	actual varchar(50),
	capay varchar(50),
	crpay varchar(50),
	ani varchar(50),
	libcog varchar(50),
	libenr varchar(500),
	ancnom varchar(50),
	codeiso2 varchar(50),
	codeiso3 varchar(50),
	codenum3 varchar(50)
	);

copy tempo from 'C:/wamp64/www/SLAM/2eme_annee/suivi_dc/migration_base/fic/pays2020.csv' with csv delimiter ',' NULL '' encoding 'utf8';

insert into pays(nom, nom_complet, iso2, iso3) 
select libcog::varchar(30), libenr, codeiso2::char(2), codeiso3::char(3) 
	from tempo;
	
drop table tempo;	
commit;
vacuum full;
