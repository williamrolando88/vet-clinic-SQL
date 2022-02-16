-- *****************************************************************************
/* Create animals table */

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

-- *****************************************************************************
/* Vet clinic database: query multiple tables */

-- Create a table named owners with the following columns:
-- 	id: integer (set it as autoincremented PRIMARY KEY)
-- 	full_name: string
-- 	age: integer
CREATE TABLE owners (
	id BIGSERIAL NOT NULL PRIMARY KEY,
	name VARCHAR(50) NOT NULL,
	age INT NOT NULL
);

-- Create a table named species with the following columns:
--   id: integer (set it as autoincremented PRIMARY KEY)
--   name: string
CREATE TABLE species (
	id BIGSERIAL NOT NULL PRIMARY KEY,
	name VARCHAR(50) NOT NULL
);

-- Modify animals table:
--   Make sure that id is set as autoincremented PRIMARY KEY
--   Remove column species
--   Add column species_id which is a foreign key referencing species table
--   Add column owner_id which is a foreign key referencing the owners table
ALTER TABLE animals DROP COLUMN species;
ALTER TABLE animals ADD COLUMN species_id INT;
ALTER TABLE animals ADD COLUMN owner_id INT;
ALTER TABLE animals
	ADD CONSTRAINT animal_species_id_fk
	FOREIGN KEY (species_id)
	REFERENCES species(id);
ALTER TABLE animals
	ADD CONSTRAINT animal_owner_id_fk
	FOREIGN KEY (owner_id)
	REFERENCES owners(id);