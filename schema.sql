/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
    id INT GENERATED BY DEFAULT AS IDENTITY NOT NULL,
    name VARCHAR(50) NOT NULL,
    date_of_birth DATE,
    escape_attempts INT,
    neutured BOOLEAN,
    weight_kg DECIMAL,
    PRIMARY KEY(id)
);

ALTER TABLE animals ADD species VARCHAR(50);

CREATE TABLE owners(
    id INT GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1),
    full_name VARCHAR(50),
    age INT,
    PRIMARY KEY(id)
);

CREATE TABLE species (
    id INT GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1),
    name VARCHAR(50),
    PRIMARY KEY(id)
);

/* Already set animals id as autoincremented primary key */

ALTER TABLE animals DROP COLUMN species;

ALTER TABLE animals ADD COLUMN species_id INT;
ALTER TABLE animals ADD CONSTRAINT species_fk FOREIGN KEY (species_id) REFERENCES species(id);

ALTER TABLE animals ADD COLUMN owners_id INT;
ALTER TABLE animals ADD CONSTRAINT owners_fk FOREIGN KEY (owners_id) REFERENCES owners(id);

CREATE TABLE vets(
    id INT GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1),
    name VARCHAR(100),
    age INT,
    date_of_graduation DATE,
    PRIMARY KEY(id)
);

CREATE TABLE specializations(
    species_id INT,
    vets_id INT,
    PRIMARY KEY (species_id, vets_id),
    FOREIGN KEY (species_id) REFERENCES species(id),
    FOREIGN KEY (vets_id) REFERENCES vets(id)
);

CREATE TABLE visits (
    animals_id INT,
    vets_id INT,
    date_of_visits DATE,
    PRIMARY KEY (animals_id, vets_id),
    FOREIGN KEY (animals_id) REFERENCES animals(id),
    FOREIGN KEY (vets_id) REFERENCES vets(id)
);

ALTER TABLE owners ADD COLUMN email VARCHAR(120);

DELETE FROM visits;

ALTER TABLE visits DROP CONSTRAINT visits_pkey;

CREATE INDEX animals_id_index ON visits (animals_id);
CREATE INDEX vets_id_index ON visits (vets_id);
CREATE INDEX email_index ON owners (email);

