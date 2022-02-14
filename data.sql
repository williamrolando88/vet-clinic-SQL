/* Populate database with sample data. */

-- Animal: His name is Agumon. He was born on Feb 3rd, 2020, and currently weighs 10.23kg. He was neutered and he has never tried to escape.
INSERT INTO animals (name, date_of_birth,escape_attemps,neutered,weight_kg) VALUES ('Agumon', '02/03/2020', 0, true, 10.23);

-- Animal: Her name is Gabumon. She was born on Nov 15th, 2018, and currently weighs 8kg. She is neutered and she has tried to escape 2 times.
INSERT INTO animals (name, date_of_birth,escape_attemps,neutered,weight_kg) VALUES ('Gabumon', '11/15/2018', 2, true, 8);

-- Animal: His name is Pikachu. He was born on Jan 7th, 2021, and currently weighs 15.04kg. He was not neutered and he has tried to escape once.
INSERT INTO animals (name, date_of_birth,escape_attemps,neutered,weight_kg) VALUES ('Pikachu', '01/07/2021', 1, false, 15.04);

-- Animal: Her name is Devimon. She was born on May 12th, 2017, and currently weighs 11kg. She is neutered and she has tried to escape 5 times.
INSERT INTO animals (name, date_of_birth,escape_attemps,neutered,weight_kg) VALUES ('Devimon', '05/12/2017', 5, true, 11);


