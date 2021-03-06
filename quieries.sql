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

BEGIN;
  SAVEPOINT deleted_animals;
  DELETE FROM animals;
  SELECT * FROM animals;
  ROLLBACK TO deleted_animals;
  SELECT * from animals;
COMMIT;

BEGIN;
  DELETE FROM animals
    WHERE date_of_birth > '2022-01-01';
  SAVEPOINT delete_newborns;
  UPDATE animals SET weight_kg = weight_kg * -1;
  ROLLBACK TO delete_newborns;
  UPDATE animals SET weight_kg = weight_kg * -1
    WHERE weight_kg < 0;
COMMIT;

/* How many animals are there? */
SELECT count(name) 
  FROM animals;

/* How many animals have never tried to escape? */
SELECT count(name) 
  FROM animals 
  WHERE escape_attempts = 0;

/* What is the average weight of animals? */
SELECT avg(weight_kg) FROM animals;

/* Who escapes the most, neutered or not neutered animals? */
SELECT neutered, max(escape_attempts) 
  FROM animals 
  GROUP BY neutered;

/* What is the minimum and maximum weight of each type 
** of animal? */
SELECT max(weight_kg), min(weight_kg) 
  FROM animals;

/* What is the average number of escape attempts per 
** animal type of those born between 1990 and 2000 */

SELECT species, avg(escape_attempts) 
  FROM animals
  WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-01-01'
  GROUP BY species;

/* What animals belong to Melody Pond? */
SELECT full_name as owner_name, name
  FROM animals
  LEFT JOIN owners 
    ON owners.id = owner_id
WHERE owners.full_name = 'Melody Ponds';

/* List of all animals that are pokemon (their type is Pokemon). */
SELECT animals.name, species.name 
  FROM animals
  JOIN species 
    ON animals.species_id = species.id
  WHERE species.name = 'Pokemon';

  /* List all owners and their animals, remember to include those that 
  ** don't own any animal. */
  SELECT owners.full_name as owner_name, 
         animals.name as animal
    FROM animals
    FULL JOIN owners
    ON owner_id = owners.id;

/* How many animals are there per species? */
SELECT species.name, count(animals.name)
  FROM animals
  JOIN species ON species_id = species.id
  GROUP BY species.name;

/* List all Digimon owned by Jennifer Orwell. */
SELECT owners.full_name, animals.name
  FROM animals
  JOIN owners ON animals.owner_id = owners.id
  WHERE owners.full_name = 'Jennifer Orwell';

/* List all animals owned by Dean Winchester that haven't 
** tried to escape. */
SELECT animals.name as animal, 
       owners.full_name as owner, 
       animals.escape_attempts
  FROM animals
  JOIN owners ON animals.owner_id = owners.id
  WHERE owners.full_name = 'Dean Winchester' 
    AND animals.escape_attempts = 0;

/* Who owns the most animals? */
SELECT owners.full_name, count(animals.name) as animals
  FROM animals
    JOIN owners ON animals.owner_id = owners.id
    GROUP BY owners.full_name
    ORDER BY animals DESC
    FETCH FIRST ROW ONLY;

/* Who was the last animal seen by William Tatcher? */
SELECT vets.name, animals.name, visit_date FROM visits
  JOIN vets ON vet_id = vets.id
  JOIN animals ON animal_id = animals.id
  WHERE vets.name = 'William Tatcher'
  ORDER BY visit_date DESC;

/*  How many different animals did Stephanie Mendez see? */
SELECT vets.name, count(animal_id) FROM visits
  JOIN vets ON vet_id = vets.id
  WHERE vets.name = 'Stephanie Mendez'
  GROUP BY vets.name;

/* List all vets and their specialties, including vets with 
** no specialties. */
SELECT vets.name, species.name
  FROM specializations
  FULL JOIN vets ON vet_id = vets.id
  FULL JOIN species ON species_id = species.id;

/* List all animals that visited Stephanie Mendez between 
** April 1st and August 30th, 2020. */
SELECT vets.name, animals.name, visit_date
  FROM visits
  JOIN vets ON vet_id = vets.id
  JOIN animals ON animal_id = animals.id
  WHERE vets.name = 'Stephanie Mendez' 
    AND visit_date BETWEEN '2020-04-01' AND '2020-08-01';

/* What animal has the most visits to vets? */
SELECT animals.name, count(visit_date) as visits
  FROM visits
  JOIN animals ON animal_id = animals.id
  GROUP BY animals.name
  ORDER BY visits DESC;

/* Who was Maisy Smith's first visit? */
SELECT vets.name, animals.name, visit_date
  FROM visits
  JOIN vets ON vet_id = vets.id
  JOIN animals ON animal_id = animals.id
  WHERE vets.name = 'Maisy Smith'
  ORDER BY visit_date ASC
  FETCH FIRST ROW ONLY;

/* Details for most recent visit: animal information, vet information, 
** and date of visit. */
SELECT vets.name, animals.name, visit_date
  FROM visits
  JOIN vets ON vet_id = vets.id
  JOIN animals ON animal_id = animals.id
  ORDER BY visit_date DESC
  FETCH FIRST ROW ONLY;

/* How many visits were with a vet that did not specialize in that 
** animal's species? */
SELECT count(*)
  FROM visits
  JOIN vets ON vets.id = visits.vet_id
  JOIN animals ON animals.id = visits.animal_id
  WHERE animals.species_id NOT IN (
    SELECT coalesce(specializations.species_id,0)
    FROM vets
    LEFT JOIN specializations ON (specializations.vet_id = vets.id)
    WHERE vets.id = visits.vet_id
  );

/* What specialty should Maisy Smith consider getting? Look for the 
** species she gets the most. */
SELECT vets.name, species.name, count(animals.species_id)
  FROM visits
  JOIN vets ON vets.id = visits.vet_id
  JOIN animals ON animals.id = visits.animal_id
  JOIN species ON species.id = animals.species_id
  WHERE vets.name = 'Maisy Smith'
  GROUP by vets.name, species.name
  ORDER BY count(animals.species_id) DESC
  FETCH FIRST ROW ONLY;