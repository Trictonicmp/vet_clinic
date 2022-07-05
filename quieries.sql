/* QUERIES */
/* Find all animals whose name ends in "mon" */
SELECT * FROM animals WHERE name LIKE '%mon';

/* List name of all animals that where born between 
** 2016 and 2019 */
SELECT name FROM animals 
  WHERE date_of_birth 
  BETWEEN '2016-01-01' AND '2019-01-01';

/* List the name of all animals that are neutered 
** and have less than 3 scape attempts */
SELECT name FROM animals 
  WHERE neutered = true AND escape_attempts < 3;

/* List date of birth of all animals named either 
** "Agumon" or "pikachu" */
SELECT date_of_birth FROM animals 
  WHERE name = 'Agumon' OR name = 'Pikachu';

/* List name and scape attempts of animals that
** weight more than 10.5kg */
SELECT name, escape_attempts FROM animals
  WHERE weight_kg > 10.5;

/* Find all animals that are neutered */
SELECT * FROM animals 
  WHERE neutered = true;

/* Find all animals not named "Gabumon" */
SELECT * FROM animals 
  WHERE name != 'Gabumon';

/* Find all animals with weight between 10.4kg and 17.3kg  
** (including the animals with the weights that equals 
** precisely 10.4kg or 17.3kg) */

SELECT * FROM animals 
  WHERE weight_kg >= 10.4 AND weight_kg <= 17.3;

/* Update animals by setting species to "unspecified" 
** Then rollback*/
BEGIN;
  SAVEPOINT unspecified_species;
  UPDATE animals SET species='unspecified';
  SELECT * FROM animals;
  ROLLBACK TO unspecified_species;
  SELECT * FROM animals;
COMMIT;

/* Update "animals" table by setting the "species" column
** to "digimon" for all animals that have a name ending
** in "mon" */

BEGIN;
  UPDATE animals
    SET species='digimon'
    WHERE name LIKE '%mon';
  UPDATE animals
    SET species='pokemon'
    WHERE species='';
COMMIT;