/* Database schema to keep the structure of entire database. */

-- Create a table named animals with the following columns:
-- 	 id: integer
--   name: string
--   date_of_birth: date
--   escape_attempts: integer
--   neutered: boolean
--   weight_kg: decimal


CREATE TABLE animals(
	id BIGSERIAL NOT NULL PRIMARY KEY,
	name VARCHAR(50) NOT NULL,
	date_of_birth DATE NOT NULL,
	escape_attemps SMALLINT NOT NULL,
	neutered BOOLEAN NOT NULL,
	weight_kg FLOAT NOT NULL
);