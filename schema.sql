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