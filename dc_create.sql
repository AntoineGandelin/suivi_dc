BEGIN TRANSACTION;

CREATE TABLE pays 
	(
  	id_pays     SERIAL PRIMARY KEY, 
  	nom         varchar(30), 
  	nom_complet varchar(70), 
  	iso2        char(2), 
  	iso3        char(3)
  	);
  	
CREATE TABLE commune 
	(
  	id_com     char(5) PRIMARY KEY, 
  	nom_accent varchar(50), 
  	nom        varchar(50), 
  	dept       char(2) 
   );
   
CREATE TABLE dc 
	(
  	id_dc       SERIAL PRIMARY KEY, 
  	nom         varchar(30), 
  	prenom      varchar(30), 
  	date_nais   date, 
  	date_dc     date, 
  	sexe        char(1), 
  	id_pays     integer REFERENCES pays (id_pays), 
  	id_com_nais char(5) REFERENCES commune (id_com), 
  	id_com_dc   char(5) REFERENCES commune (id_com) 
 	);
 	
COMMIT; 	
