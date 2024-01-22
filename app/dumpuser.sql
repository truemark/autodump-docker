CREATE USER autodump WITH PASSWORD 'FROMSECRET';

grant all privileges on database dumptest to autodump;
