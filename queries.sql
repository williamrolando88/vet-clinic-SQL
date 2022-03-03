/*Queries that provide answers to the questions from all projects.*/

-- *****************************************************************************
/* Create animals table */

-- Find all animals whose name ends in "mon".
SELECT * FROM animals WHERE name LIKE '%mon';
-- List the name of all animals born between 2016 and 2019.
SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-01-01';
-- List the name of all animals that are neutered and have less than 3 escape attempts.
SELECT name FROM animals WHERE neutered = true AND escape_attemps < 3;
-- List date of birth of all animals named either "Agumon" or "Pikachu".
SELECT date_of_birth FROM animals WHERE name = 'Agumon' OR name = 'Pikachu';
-- List name and escape attempts of animals that weigh more than 10.5kg
SELECT name, escape_attemps FROM animals WHERE weight_kg > 10.5;
-- Find all animals that are neutered.
SELECT * FROM animals WHERE neutered = true;
-- Find all animals not named Gabumon.
SELECT * FROM animals WHERE NOT name = 'Gabumon';
-- Find all animals with a weight between 10.4kg and 17.3kg (including the animals with the weights that equals precisely 10.4kg or 17.3kg)
SELECT * FROM animals WHERE weight_kg >= 10.4 AND weight_kg <=17.3;

-- *****************************************************************************
/* Query and update animals table */

-- Inside a transaction update the animals table by setting the species column to unspecified. Verify that change was made. Then roll back the change and verify that species columns went back to the state before transaction.
BEGIN;
UPDATE animals SET species = 'unspecified';
SELECT * FROM animals;
ROLLBACK;
SELECT * FROM animals;

-- Inside a transaction: Update the animals table by setting the species column to digimon for all animals that have a name ending in mon. Update the animals table by setting the species column to pokemon for all animals that don't have species already set. Commit the transaction. Verify that change was made and persists after commit.
BEGIN;
UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';
UPDATE animals SET species = 'pokemon' WHERE species <> 'digimon';
SELECT * FROM animals;
COMMIT;
SELECT * FROM animals;

-- Now, take a deep breath and... Inside a transaction delete all records in the animals table, then roll back the transaction. After the roll back verify if all records in the animals table still exist. After that you can start breath as usual ;)
BEGIN;
DELETE FROM animals WHERE id IS NOT NULL;
SELECT * FROM animals;
ROLLBACK;
SELECT * FROM animals;

-- Inside a transaction:
-- Delete all animals born after Jan 1st, 2022.
-- Create a savepoint for the transaction.
-- Update all animals' weight to be their weight multiplied by -1.
-- Rollback to the savepoint
-- Update all animals' weights that are negative to be their weight multiplied by -1.
-- Commit transaction
BEGIN;
DELETE FROM animals WHERE date_of_birth > '2022-01-01';
SAVEPOINT SP1;
UPDATE animals SET weight_kg = weight_kg* - 1;
ROLLBACK TO SP1;
UPDATE animals SET weight_kg = weight_kg* - 1 WHERE weight_kg < 0;
COMMIT;

-- Write queries to answer the following questions:
-- How many animals are there?
SELECT count(id) FROM animals;
-- How many animals have never tried to escape?
SELECT count(id) FROM animals WHERE escape_attemps = 0;
-- What is the average weight of animals?
SELECT avg(weight_kg) FROM animals;
-- Who escapes the most, neutered or not neutered animals?
SELECT neutered, max(escape_attemps) FROM animals GROUP BY neutered;
-- What is the minimum and maximum weight of each type of animal?
SELECT species, max(weight_kg), min(weight_kg) 
  FROM animals 
  GROUP BY species;
-- What is the average number of escape attempts per animal type of those born between 1990 and 2000?
SELECT species, avg(escape_attemps) 
  FROM animals
  WHERE date_of_birth >= '1990/01/01' AND date_of_birth <= '2000/01/01'
  GROUP BY species;

-- *****************************************************************************
/* Vet clinic database: query multiple tables */
-- Write queries (using JOIN) to answer the following questions:
-- 	What animals belong to Melody Pond?
SELECT animals.name 
  FROM animals
  JOIN owners 
  ON animals.owner_id = owners.id
  WHERE owners.name = 'Melody Pond';
-- 	List of all animals that are pokemon (their type is Pokemon).
SELECT * 
  FROM animals
  JOIN species 
  ON animals.species_id = species.id
  WHERE species.name = 'Pokemon';
-- 	List all owners and their animals, remember to include those that don't own any animal.
SELECT owners.name, animals.name 
  FROM owners
  LEFT JOIN animals 
  ON owners.id = animals.owner_id;
-- 	How many animals are there per species?
SELECT species.name, count(animals.id) 
  FROM animals
  JOIN species 
  ON animals.species_id=species.id
  GROUP BY species.name;
-- 	List all Digimon owned by Jennifer Orwell.
SELECT species.name, animals.name
  FROM animals
  JOIN owners
  ON animals.owner_id = owners.id
  JOIN species
  ON species.id = animals.species_id
  WHERE owners.name = 'Jennifer Orwell' AND species.name = 'Digimon';
-- 	List all animals owned by Dean Winchester that haven't tried to escape.
SELECT animals.name
  FROM animals
  JOIN owners
  ON animals.owner_id = owners.id
  WHERE owners.name = 'Dean Winchester' AND animals.escape_attemps = 0;
-- 	Who owns the most animals?
SELECT owners.name, count(animals.owner_id)
  FROM animals
  JOIN owners
  ON animals.owner_id = owners.id
  GROUP BY owners.name
  ORDER BY count(animals.owner_id) DESC;

-- *****************************************************************************
/* Join table for visits */

-- Write queries to answer the following:
--   Who was the last animal seen by William Tatcher?
SELECT animals.name, visits.visit_date FROM animals
  JOIN visits ON animals.id = visits.animal_id
  JOIN vet ON vet.id = visits.vet_id
  WHERE vet.name = 'William Tatcher'
  ORDER BY visits.visit_date DESC
  LIMIT 1;
--   How many different animals did Stephanie Mendez see?
SELECT count(animals.name) FROM animals
  JOIN visits ON animals.id = visits.animal_id
  JOIN vet ON vet.id = visits.vet_id
  WHERE vet.name = 'Stephanie Mendez';
--   List all vets and their specialties, including vets with no specialties.
SELECT vet.name, species.name FROM vet
  LEFT JOIN specialization ON vet.id = specialization.vet_id
  LEFT JOIN species ON species.id = specialization.species_id;
--   List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.
SELECT animals.name, visits.visit_date FROM animals
  JOIN visits ON animals.id = visits.animal_id
  JOIN vet ON vet.id = visits.vet_id
  WHERE vet.name = 'Stephanie Mendez' 
    AND visits.visit_date > '2020/04/01' 
    AND visits.visit_date < '2020/08/30'
  ORDER BY visits.visit_date ASC;
--   What animal has the most visits to vets?
SELECT animals.name, count(visits.visit_date) AS totalVisits FROM animals
  JOIN visits ON animals.id = visits.animal_id
  GROUP BY animals.name
  ORDER BY totalVisits DESC
  LIMIT 1;
--   Who was Maisy Smith's first visit?
SELECT animals.name, visits.visit_date FROM animals
  JOIN visits ON animals.id = visits.animal_id
  JOIN vet ON vet.id = visits.vet_id
  WHERE vet.name = 'Maisy Smith'
  ORDER BY visits.visit_date ASC
  LIMIT 1;
--   Details for most recent visit: animal information, vet information, and date of visit.
SELECT * FROM animals
  JOIN visits ON animals.id = visits.animal_id
  JOIN vet ON vet.id = visits.vet_id
  ORDER BY visits.visit_date DESC
  LIMIT 1;
--   How many visits were with a vet that did not specialize in that animal's species?
SELECT vet.name, species.name, count(visits.visit_date) FROM vet
  LEFT JOIN specialization ON vet.id = specialization.vet_id
  LEFT JOIN species ON species.id = specialization.species_id
  JOIN visits ON visits.vet_id = vet.id
  WHERE species.name IS NULL
  GROUP BY VET.name, species.name;
--   What specialty should Maisy Smith consider getting? Look for the species she gets the most.
SELECT species.name, count(species.name) FROM animals
  JOIN visits ON animals.id = visits.animal_id
  JOIN vet ON vet.id = visits.vet_id
  JOIN species ON animals.species_id = species.id
  WHERE vet.name = 'Maisy Smith'
  GROUP BY species.name
  LIMIT 1;
