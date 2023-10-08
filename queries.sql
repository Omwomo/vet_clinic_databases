/*Queries that provide answers to the questions from all projects.*/

SELECT * FROM animals WHERE name LIKE '%mon';

SELECT name FROM animals
WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-01-01';

SELECT name FROM animals
WHERE neutured = true AND escape_attempts < 3;

SELECT date_of_birth FROM animals
WHERE name IN ('Agumon', 'Pikachu');

SELECT name, escape_attempts FROM animals
WHERE weight_kg > 10.5;

SELECT * FROM animals
WHERE neutured = true;

SELECT * FROM animals
WHERE name != 'Gabumon';

SELECT * FROM animals
WHERE weight_kg BETWEEN 10.4 AND 17.3;

/* Day 2 queries */

BEGIN;
UPDATE animals SET species = 'unspecified';
SELECT * FROM animals;
ROLLBACK;

BEGIN;
UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';
UPDATE animals SET species = 'pokemon' WHERE species IS NULL OR species = '';
SELECT * FROM animals;
COMMIT;
SELECT * FROM animals;

BEGIN;
DELETE FROM animals WHERE date_of_birth > '2022-01-01';
SAVEPOINT SP1;
UPDATE animals SET weight_kg = -1 * ABS(weight_kg);
ROLLBACK SP1;
UPDATE animals SET weight_kg = -1 * ABS(weight_kg) WHERE weight_kg < 0;
COMMIT;

BEGIN;
UPDATE animals SET weight_kg = -1 * (weight_kg) WHERE weight_kg < 0;
COMMIT;

/* LAST QUERIES */
SELECT COUNT(*) FROM animals;

SELECT COUNT(*) FROM animals
WHERE escape_attempts = 0;

SELECT AVG(weight_kg) FROM animals;

SELECT neutured, COUNT(*) as escape_count
FROM animals GROUP BY neutured
ORDER BY escape_count DESC LIMIT 1;

SELECT species, MIN(weight_kg) as min_weight, MAX(weight_kg) as max_weight
FROM animals GROUP BY species;

SELECT species, MIN(weight_kg) as min_weight, MAX(weight_kg) as max_weight
FROM animals GROUP BY species;

SELECT AVG(escape_attempts) FROM animals
WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-01-01';

/* DAY 3 QUREIES */
SELECT animals.name, owners.full_name
FROM animals
INNER JOIN owners ON animals.owners_id = owners.id
WHERE owners.full_name = 'Melody Pond';

SELECT animals.name
FROM animals
INNER JOIN species ON animals.species_id = species.id
WHERE species.name = 'Pokemon';

SELECT species.name, COUNT(animals.id) as animals_count
FROM animals JOIN species
ON species_id = species.id
GROUP BY species.name;

SELECT animals.name AS digimon_owned
FROM animals
JOIN species ON animals.species_id = species.id
JOIN owners ON animals.owners_id = owners.id
WHERE owners.full_name = 'Jennifer Orwell' AND species.name = 'Digimon';

SELECT animals.name AS never_escaped
FROM animals
JOIN species ON animals.species_id = species.id
JOIN owners ON animals.owners_id = owners.id
WHERE owners.full_name = 'Dean Winchester' AND animals.escape_attempts = 0;

SELECT owners.full_name, COUNT(animals.name) AS owns_the_most_animals
FROM owners
JOIN animals ON animals.owners_id = owners.id
GROUP BY owners.full_name
ORDER BY owns_the_most_animals DESC LIMIT 1;

SELECT owners.full_name AS animal_owner, animals.name AS animal_name
FROM animals
RIGHT JOIN owners ON animals.owners_id = owners.id;

/* DAY 4 QUERIES */

/* Last animal seen by William Tatcher */
SELECT animals.name AS last_animals_visited_by_Tatcher, visits.date_of_visits AS date_visited
FROM animals
JOIN visits ON animals.id = visits.animals_id
JOIN vets ON vets.id = visits.vets_id
WHERE vets.id = 1
GROUP BY visits.date_of_visits, animals.name
ORDER BY date_visited DESC LIMIT 1;

/* Number of different animals seen by Stephanie */
SELECT COUNT(animals.id) AS number_of_animals_seen_by_Stephanie
FROM animals
JOIN visits ON animals.id = visits.animals_id
JOIN vets ON vets.id = visits.vets_id
WHERE vets.id = 3;

/* listing all vets and their specialities */
SELECT vets.name, species.name AS speciality
FROM vets
LEFT JOIN specializations ON vets.id = specializations.vets_id
LEFT JOIN species ON species.id = specializations.species_id;

/* animals visited by stephanies between april and august 2020 */
SELECT animals.name AS animals_visited_by_Stephanie
FROM animals
JOIN visits ON animals.id = visits.animals_id
JOIN vets ON vets.id = visits.vets_id
WHERE vets.id = 3
AND visits.date_of_visits BETWEEN '2020-04-01' AND '2020-08-30';

/* Most visited animal */
SELECT animals.name
FROM animals
JOIN ( SELECT animals_id, COUNT(animals_id) AS visits_count
FROM visits
GROUP BY animals_id
ORDER BY visits_count DESC LIMIT 1 ) AS most_visited_animal ON animals.id = most_visited_animal.animals_id;

/* Miaisy's fist visit */
SELECT animals.name AS first_visit_by_Smith, visits.date_of_visits AS first_date
FROM animals
JOIN visits ON animals.id = visits.animals_id
JOIN vets ON vets.id = visits.vets_id
WHERE vets.name = 'Maisy Smith'
GROUP BY animals.name, visits.date_of_visits
ORDER BY first_date ASC LIMIT 1;

/* Details for most recent visits */
SELECT animals, vets, visits.date_of_visits AS most_recent_visit
FROM animals
JOIN visits ON animals.id = visits.animals_id
JOIN vets ON vets.id = visits.vets_id
ORDER BY most_recent_visit DESC LIMIT 1;

/* Species Mossy sholud consider taking */
SELECT species.name
FROM species
JOIN ( SELECT animals.species_id, COUNT(animals.species_id) AS most_specie_visited_by_Maisy
FROM animals
JOIN visits ON animals.id = visits.animals_id
JOIN vets ON visits.vets_id = vets.id
WHERE vets.id = 2
GROUP BY animals.species_id
ORDER BY most_specie_visited_by_Maisy DESC LIMIT 1 )
AS most_specie_visited_by_Maisy ON species.id = most_specie_visited_by_Maisy.species_id;

/* Visits without specialization */
SELECT COUNT(*) AS visits_without_specialization
FROM visits
JOIN animals ON visits.animals_id = animals.id
JOIN vets ON visits.vets_id = vets.id
LEFT JOIN specializations ON animals.species_id = specializations.species_id
AND visits.vets_id = specializations.vets_id
WHERE specializations.species_id IS NULL OR specializations.species_id <> animals.species_id;
