/*Queries that provide answers to the questions from all projects.*/

SELECT * FROM vet_clinic WHERE name LIKE '%mon';
SELECT name FROM vet_clinic WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-01-01';
SELECT name FROM vet_clinic WHERE neutured = true AND escape_attempts < 3;
SELECT date_of_birth FROM vet_clinic WHERE name IN ('Agumon', 'Pikachu');
SELECT name, escape_attempts FROM vet_clinic WHERE weight_kg > 10.5;
SELECT * FROM vet_clinic WHERE neutured = true;
SELECT * FROM vet_clinic WHERE name != 'Devimon';
SELECT * FROM vet_clinic WHERE weight_kg BETWEEN 10.4 AND 17.3;

