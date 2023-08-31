CREATE USER postgres WITH PASSWORD 'postgres';
CREATE DATABASE postgres WITH OWNER postgres;
GRANT ALL ON DATABASE postgres TO postgres;
