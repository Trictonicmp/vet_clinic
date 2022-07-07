/* Creating the database */
CREATE DATABASE vet_clinic;

/* Connecting to database */
\c vet_clinic

/* Creating animals table */
CREATE TABLE animals (
    id                  INT GENERATED ALWAYS AS IDENTITY,
    name                VARCHAR(40),
    date_of_birth      DATE,
    escape_attempts     INT,
    neutered            BOOLEAN,
    weight_kg           decimal,
    PRIMARY KEY(id)
);

/* Adding species column to naimal table */
ALTER TABLE animals 
    ADD species VARCHAR(40);

/* Create table named owners */
CREATE TABLE owners (
  id        INT GENERATED ALWAYS AS IDENTITY,
  full_name VARCHAR(100),
  age       INT,
  PRIMARY KEY (id)
);

/* Create table named species */
CREATE TABLE species (
  id    INT GENERATED ALWAYS AS IDENTITY,
  name  VARCHAR(30),
  PRIMARY KEY (id)
);

/* Modify animals table: remove "species", add fk "species_id" 
** add fk owner_id*/
ALTER TABLE animals
  DROP COLUMN species,
  ADD COLUMN species_id INT,
  ADD COLUMN owner_id   INT,
  ADD FOREIGN KEY (species_id) REFERENCES species(id),
  ADD FOREIGN KEY (owner_id) REFERENCES owners(id);

/* Create a table named vets */
CREATE TABLE vets (
  id      INT GENERATED ALWAYS AS IDENTITY,
  name    VARCHAR(40),
  age     INT,
  date_of_graduation DATE,
  PRIMARY KEY (id)
);