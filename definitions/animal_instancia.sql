CREATE TABLE animal_instancia(

    animal__especie VARCHAR(50) NOT NULL,
    animal__raza VARCHAR(50) NOT NULL,

    id INTEGER,
    de_compañia BOOLEAN,
    potencialmente_peligroso BOOLEAN,
    fecha_nacimiento TIMESTAMP,
    fecha_muerte TIMESTAMP,
    exotico BOOLEAN,
    extranjero BOOLEAN,


    CONSTRAINT animal_instancia__clave
        PRIMARY KEY (id),


    CONSTRAINT animal_instancia__animal
        FOREIGN KEY (animal__especie, animal__raza) REFERENCES animal
);