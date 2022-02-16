-- *****************************************************************************
/* Create animals table */

-- Animal: His name is Agumon. He was born on Feb 3rd, 2020, and currently weighs 10.23kg. He was neutered and he has never tried to escape.
INSERT INTO animals (name, date_of_birth,escape_attemps,neutered,weight_kg) VALUES ('Agumon', '02/03/2020', 0, true, 10.23);

-- Animal: Her name is Gabumon. She was born on Nov 15th, 2018, and currently weighs 8kg. She is neutered and she has tried to escape 2 times.
INSERT INTO animals (name, date_of_birth,escape_attemps,neutered,weight_kg) VALUES ('Gabumon', '11/15/2018', 2, true, 8);

-- Animal: His name is Pikachu. He was born on Jan 7th, 2021, and currently weighs 15.04kg. He was not neutered and he has tried to escape once.
INSERT INTO animals (name, date_of_birth,escape_attemps,neutered,weight_kg) VALUES ('Pikachu', '01/07/2021', 1, false, 15.04);

-- Animal: Her name is Devimon. She was born on May 12th, 2017, and currently weighs 11kg. She is neutered and she has tried to escape 5 times.
INSERT INTO animals (name, date_of_birth,escape_attemps,neutered,weight_kg) VALUES ('Devimon', '05/12/2017', 5, true, 11);

-- *****************************************************************************
/* Exercise: Query and update animals table */

-- Animal: His name is Charmander. He was born on Feb 8th, 2020, and currently weighs -11kg. He is not neutered and he has never tried to escape.
INSERT INTO animals (name, date_of_birth,escape_attemps,neutered,weight_kg) VALUES ('Charmander', '2020/02/08', 0, false, -11);

-- Animal: Her name is Plantmon. She was born on Nov 15th, 2022, and currently weighs -5.7kg. She is neutered and she has tried to escape 2 times.
INSERT INTO animals (name, date_of_birth,escape_attemps,neutered,weight_kg) VALUES ('Plantmon', '2022/11/15', 2, true, -5.7);

-- Animal: His name is Squirtle. He was born on Apr 2nd, 1993, and currently weighs -12.13kg. He was not neutered and he has tried to 3 times.
INSERT INTO animals (name, date_of_birth,escape_attemps,neutered,weight_kg) VALUES ('Squirtle', '1993/04/02', 3, false, -12.13);

-- Animal: His name is Angemon. He was born on Jun 12th, 2005, and currently weighs -45kg. He is neutered and he has tried to escape once.
INSERT INTO animals (name, date_of_birth,escape_attemps,neutered,weight_kg) VALUES ('Angemon', '2005/06/12', 1, true, -45);

-- Animal: His name is Boarmon. He was born on Jun 7th, 2005, and currently weighs 20.4kg. He is neutered and he has tried to escape 7 times.
INSERT INTO animals (name, date_of_birth,escape_attemps,neutered,weight_kg) VALUES ('Boarmon', '2005/06/07', 7, true, 20.4);

-- Animal: Her name is Blossom. She was born on Oct 13th, 1998, and currently weighs 17kg. She is neutered and she has tried to escape 3 times.
INSERT INTO animals (name, date_of_birth,escape_attemps,neutered,weight_kg) VALUES ('Blossom', '1998/10/13', 3, true, 17);

-- *****************************************************************************
/* Vet clinic database: query multiple tables */

-- Insert the following data into the owners table:
--   Sam Smith 34 years old.
--   Jennifer Orwell 19 years old.
--   Bob 45 years old.
--   Melody Pond 77 years old.
--   Dean Winchester 14 years old.
--   Jodie Whittaker 38 years old.
BEGIN;
INSERT INTO owners (name,age) VALUES ('Sam Smith', 34);
INSERT INTO owners (name,age) VALUES ('Jennifer Orwell', 19);
INSERT INTO owners (name,age) VALUES ('Bob', 45);
INSERT INTO owners (name,age) VALUES ('Melody Pond', 77);
INSERT INTO owners (name,age) VALUES ('Dean Winchester', 14);
INSERT INTO owners (name,age) VALUES ('Jodie Whittaker', 38);
COMMIT;

-- Insert the following data into the species table:
--   Pokemon
--   Digimon
BEGIN;
INSERT INTO species (name) VALUES ('Pokemon');
INSERT INTO species (name) VALUES ('Digimon');
COMMIT;

-- Modify your inserted animals so it includes the species_id value:
--   If the name ends in "mon" it will be Digimon
--   All other animals are Pokemon
BEGIN;
UPDATE animals SET species_id = 4 WHERE name LIKE '%mon';
UPDATE animals SET species_id = 3 WHERE species_id <> 4;
COMMIT;

-- Modify your inserted animals to include owner information (owner_id):
--   Sam Smith owns Agumon.
--   Jennifer Orwell owns Gabumon and Pikachu.
--   Bob owns Devimon and Plantmon.
--   Melody Pond owns Charmander, Squirtle, and Blossom.
--   Dean Winchester owns Angemon and Boarmon.
BEGIN;
UPDATE animals SET owner_id = 7 WHERE name = 'Agumon';
UPDATE animals SET owner_id = 8 WHERE name = 'Gabumon' or name = 'Pikachu';
UPDATE animals SET owner_id = 9 WHERE name = 'Plantmon' or name = 'Devimon';
UPDATE animals SET owner_id = 10 
	WHERE name = 'Charmander' or name = 'Squirtle' or name = 'Blossom';
UPDATE animals SET owner_id = 11 WHERE name = 'Angemon' or name = 'Boarmon';
COMMIT;

