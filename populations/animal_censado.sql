INSERT INTO animal (id_animal, especie, raza, de_compañia, peligroso, exotico, extranjero) VALUES
    (1,     'perro',    'alano',    TRUE,   TRUE,   FALSE,  TRUE),
    (2,     'perro',    'alano',    TRUE,   TRUE,   FALSE,  FALSE),
    (3,     'gato',     'persa',    TRUE,   FALSE,  TRUE,   TRUE),
    (4,     'gato',     'alano',    TRUE,   FALSE,  FALSE,  FALSE),
    (5,     'gato',     'siamese',  TRUE,   FALSE,  FALSE,  TRUE),
    (6,     'perro',    'alano',    TRUE,   TRUE,   FALSE,  FALSE),
    (10,    'perro',    'mastin',   TRUE,   TRUE,   FALSE,  FALSE);


INSERT INTO animal_censado (id_animal, nombre, aptitud, capa, domicilio, id_chip, id_censal, lazarillo, fecha_nacimiento)
VALUES
    (1, 'paco', 'tranquilo', 'blanco', 'la rua', '1234', '1', FALSE, '2005-11-10'),
    (2, 'calcetines', 'tranquilo', 'blanco', 'la rua', '12342', '2', FALSE, '2005-11-10'),
    (3, 'charly', 'tranquilo', 'blanco', 'la rua', '12343', '3', FALSE, '2005-11-10'),
    (4, 'toby', 'tranquilo', 'blanco', 'la rua', '12345', '4', FALSE, '2005-11-10'),
    (5, 'toby', 'tranquilo', 'blanco', 'la rua', '12346', '5', FALSE, '2005-11-10'),
    (6, 'manchas', 'tranquilo', 'blanco', 'la rua', '12347', '6', FALSE, '2005-11-10'),
    (10, 'misifu', 'tranquilo', 'blanco', 'la rua', '12348', '7', FALSE, '2005-11-10');
