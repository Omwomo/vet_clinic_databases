/* Populate database with sample data. */
INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutured, weight_kg)
VALUES
  (1, 'Agumon', '2020-02-03', 0, true, 10.23),
  (2, 'Gabumon', '2018-11-15', 2, true, 8),
  (3, 'Pikachu', '2021-01-07', 1, false, 15.04),
  (4, 'Devimon', '2017-05-12', 5, true, 11);

  /* Additional insertions */
INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutured, weight_kg)
VALUES
  (5, 'Charmander', '2020-02-08', 0, true, 11),
  (6, 'Plantmon', '2021-11-15', 2, true, 5.7),
  (7, 'Squirtle', '1993-04-02', 3, false, 12.13),
  (8, 'Angemon', '2005-06-12', 1, true, 45),
  (9, 'Boarmon', '2005-06-07', 7, true, 20.4),
  (10, 'Blossom', '1998-10-13', 3, true, 17),
  (11, 'Ditto', '2022-05-14', 4, true, 22);


INSERT INTO owners (full_name, age)
VALUES
  ('Sam Smith', 34),
  ('Jennifer Orwell', 19),
  ('Bob', 45),
  ('Melody Pond', 77),
  ('Dean Winchester', 14),
  ('Jodie Whittaker', 38);


INSERT INTO species (name)
VALUES
  ('Pokemon'),
  ('Digimon');

UPDATE animals SET species_id = species.id FROM species WHERE species.name = 'Digimon' AND animals.name LIKE '%mon';
UPDATE animals SET species_id = species.id FROM species WHERE species.name = 'Pokemon' AND animals.species_id IS NULL;

UPDATE animals SET owners_id = owners.id FROM owners WHERE owners.full_name = 'Sam Smith' AND animals.name = 'Agumon';
UPDATE animals SET owners_id = owners.id FROM owners WHERE owners.full_name = 'Jennifer Orwell' AND animals.name IN ('Gabumon', 'Pikachu');
UPDATE animals SET owners_id = owners.id FROM owners WHERE owners.full_name = 'Bob' AND animals.name IN ('Devimon', 'Plantmon');
UPDATE animals SET owners_id = owners.id FROM owners WHERE owners.full_name = 'Melody Pond' AND animals.name IN ('Charmander', 'Squirtle', 'Blossom');
UPDATE animals SET owners_id = owners.id FROM owners WHERE owners.full_name = 'Dean Winchester' AND animals.name IN ('Angemon', 'Boarmon');

/* Rectified the mix up of Species */
UPDATE animals SET species_id = CASE WHEN species_id = 1 THEN 2 WHEN species_id = 2 THEN 1 ELSE species_id END;

INSERT INTO vets (name, age, date_of_graduation)
VALUES
  ('William Tatcher', 45, '2000-04-23'),
  ('Maisy Smith', 26, '2019-01-17'),
  ('Stephanie Mendez', 64, '1981-05-04'),
  ('Jack Harkness', 38, '2008-06-08');

INSERT INTO specializations (vets_id, species_id)
VALUES
  (1, 1),
  (3, 2),
  (3, 1),
  (4, 2);


