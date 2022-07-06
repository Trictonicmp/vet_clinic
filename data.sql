/* Insert data */
INSERT INTO  animals (
  name, 
  date_of_birth, 
  weight_kg,
  neutered, 
  escape_attempts 
)
VALUES (
  'Agumon',
  '2020-02-03',
  10.23
  true,
  0,
);


INSERT INTO  animals (
  name, 
  date_of_birth, 
  weight_kg,
  neutered, 
  escape_attempts 
)
VALUES (
  'Gabumon',
  '2018-11-15',
  8.00,
  true,
  2
);

INSERT INTO animals (
  name,
  date_of_birth,
  weight_kg,
  neutered,
  escape_attempts
)
VALUES (
  'Pikachu',
  '2021-01-07',
  15.04,
  false,
  1
);

INSERT INTO animals (
  name,
  date_of_birth,
  weight_kg,
  neutered,
  escape_attempts
)
VALUES (
  'Devimon',
  '2017-05-12',
  11.00,
  true,
  5
);


INSERT INTO animals (
  name,
  date_of_birth,
  weight_kg,
  neutered,
  escape_attempts
)
VALUES 
('Charmander', '2020-02-08', -11.00, false, 0),
('Plantmon', '2021-11-15', -5.70, true, 2),
('Squirtle', '1993-04-2', -12.13, false, 3),
('Angemon', '2005-06-12', -45.00, true, 1),
('Boarmon', '2005-06-07', 20.40, true, 7),
('Blossom', '1998-10-13', 17.00, true, 3),
('Ditto', '2022-05-14', 22.00, true, 4);


INSERT INTO owners (full_name, age)
VALUES
('Sam Smith', 34),
('Jennifer Orwell', 19),
('Bob', 45),
('Melody Ponds', 77),
('Dean Winchester', 14),
('Jodie Whittaker', 38);

INSERT INTO species (name)
VALUES ('Pokemon'), ('Digimon')


/* Modify inserted animals to include "species_id" if name
** ends in "mon" to be "Digimon" id otherwide be "Pokemon" id */
UPDATE animals
  SET species_id = species.id
  FROM species
  WHERE species.name = 'Pokemon';
UPDATE animals
  SET species_id = species.id
  FROM species
  WHERE animals.name LIKE '%mon' 
    AND species.name = 'Digimon';

/* Modify your inserted animals to include owner information (owner_id):  */
/* Sam Smith owns Agumon */
UPDATE animals
  SET owner_id = owners.id
  FROM owners
  WHERE animals.name = 'Agumon' 
    AND owners.full_name = 'Sam Smith';

/* Jennifer Orwell owns Gabumon and Pikachu. */
UPDATE animals
  SET owner_id = owners.id
  FROM owners
  WHERE (
    animals.name = 'Gabumon' OR 
    animals.name = 'Pikachu'
  ) 
    AND owners.full_name = 'Jennifer Orwell';

/* Bob owns Devimon and Plantmon. */
UPDATE animals
  SET owner_id = owners.id
  FROM owners
  WHERE (
    animals.name = 'Devimon' OR 
    animals.name = 'Plantmon'
  )
      AND owners.full_name = 'Bob';

/* Melody Pond owns Charmander, Squirtle, and Blossom. */
UPDATE animals
  SET owner_id = owners.id
  FROM owners
  WHERE (
    animals.name = 'Charmander' OR 
    animals.name = 'Squirtle' OR 
    animals.name = 'Blossom'
  )
    AND owners.full_name = 'Melody Ponds';
SELECT * FROM animals;

/* Dean Winchester owns Angemon and Boarmon. */
UPDATE animals 
  SET owner_id = owners.id 
  FROM owners
  WHERE (
    animals.name = 'Angemon' OR
    animals.name = 'Boarmon'
  )
    AND owners.full_name = 'Dean Winchester';
