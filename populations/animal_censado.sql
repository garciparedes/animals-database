/*
Insercion de animales censados
 */


INSERT INTO animal (id_animal, especie, raza, de_compañia, peligroso, exotico, extranjero) VALUE
    (1, 'perro', 'alano', TRUE, TRUE, FALSE, TRUE);

INSERT INTO animal (id_animal, especie, raza, de_compañia, peligroso, exotico, extranjero) VALUE
    (2, 'perro', 'alano', TRUE, TRUE, FALSE, FALSE);

INSERT INTO animal (id_animal, especie, raza, de_compañia, peligroso, exotico, extranjero) VALUE
    (3, 'gato', 'persa', TRUE, FALSE, TRUE, TRUE);

INSERT INTO animal (id_animal, especie, raza, de_compañia, peligroso, exotico, extranjero) VALUE
    (4, 'gato', 'alano', TRUE, FALSE, FALSE, FALSE);

INSERT INTO animal (id_animal, especie, raza, de_compañia, peligroso, exotico, extranjero) VALUE
    (5, 'gato', 'siamese', TRUE, FALSE, FALSE, TRUE);

INSERT INTO animal (id_animal, especie, raza, de_compañia, peligroso, exotico, extranjero) VALUE
    (6, 'perro', 'alano', TRUE, TRUE, FALSE, FALSE);

INSERT INTO animal (id_animal, especie, raza, de_compañia, peligroso, exotico, extranjero) VALUE
    (10, 'perro', 'mastin', TRUE, TRUE, FALSE, FALSE);

INSERT INTO animal (id_animal, especie, raza, de_compañia, peligroso, exotico, extranjero) VALUE
    (11, 'perro', 'pastor aleman', TRUE, TRUE, FALSE, FALSE);

INSERT INTO animal_censado (id_animal, nombre, aptitud, capa, domicilio, id_chip, id_censal, lazarillo, nacimiento)
    VALUE
    (1, 'paco', 'tranquilo', 'blanco', 'la rua', '1234', '1', FALSE, '2005-11-10');

INSERT INTO animal_censado (id_animal, nombre, aptitud, capa, domicilio, id_chip, id_censal, lazarillo, nacimiento)
    VALUE
    (2, 'calcetines', 'tranquilo', 'blanco', 'la rua', '12342', '2', FALSE, '2005-11-10');

INSERT INTO animal_censado (id_animal, nombre, aptitud, capa, domicilio, id_chip, id_censal, lazarillo, nacimiento)
    VALUE
    (3, 'charly', 'tranquilo', 'blanco', 'la rua', '12343', '3', FALSE, '2005-11-10');

INSERT INTO animal_censado (id_animal, nombre, aptitud, capa, domicilio, id_chip, id_censal, lazarillo, nacimiento)
    VALUE
    (4, 'toby', 'tranquilo', 'blanco', 'la rua', '12345', '4', FALSE, '2005-11-10');

INSERT INTO animal_censado (id_animal, nombre, aptitud, capa, domicilio, id_chip, id_censal, lazarillo, nacimiento)
    VALUE
    (5, 'toby', 'tranquilo', 'blanco', 'la rua', '12346', '5', FALSE, '2005-11-10');

INSERT INTO animal_censado (id_animal, nombre, aptitud, capa, domicilio, id_chip, id_censal, lazarillo, nacimiento)
    VALUE
    (6, 'manchas', 'tranquilo', 'blanco', 'la rua', '12347', '6', FALSE, '2005-11-10');

INSERT INTO animal_censado (id_animal, nombre, aptitud, capa, domicilio, id_chip, id_censal, lazarillo, nacimiento)
    VALUE
    (10, 'misifu', 'tranquilo', 'blanco', 'la rua', '12348', '7', FALSE, '2005-11-10');

INSERT INTO animal_censado (id_animal, nombre, aptitud, capa, domicilio, id_chip, id_censal, lazarillo, nacimiento)
    VALUE
    (11, 'misifu', 'salvaje', 'blanco', 'la rua', '12349', '8', FALSE, '2004-11-10');