create database dc;
create role dc_admin password 'admin' login;
grant all on database dc to dc_admin;