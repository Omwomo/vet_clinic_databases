/*Queries that provide answers to the questions from all projects.*/

SELECT * FROM animals WHERE name LIKE '%mon';
SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-01-01';
SELECT name FROM animals WHERE neutured = true AND escape_attempts < 3;
SELECT date_of_birth FROM animals WHERE name IN ('Agumon', 'Pikachu');
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;
SELECT * FROM animals WHERE neutured = true;
SELECT * FROM animals WHERE name != 'Gabumon';
SELECT * FROM animals WHERE weight_kg BETWEEN 10.4 AND 17.3;

/* Day 2 queries */

BEGIN;
DELETE FROM animals WHERE date_of_birth > '2022-01-01';
SAVEPOINT SP1;
UPDATE animals SET weight_kg = -1 * ABS(weight_kg);
ROLLBACK SP1;
UPDATE animals SET weight_kg = -1 * ABS(weight_kg) WHERE weight_kg < 0;
COMMIT;

/* In this line I used ABS which didn't convert the values to positive
"UPDATE animals SET weight_kg = -1 * ABS(weight_kg) WHERE weight_kg < 0;"
So I begin a new transaction where I converted the values to positive */

BEGIN;
UPDATE animals SET weight_kg = -1 * (weight_kg) WHERE weight_kg < 0;
COMMIT;
