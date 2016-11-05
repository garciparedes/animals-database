CREATE TABLE animal_instancia(


    id INTEGER,
    de_compañia BOOLEAN,
    potencialmente_peligroso BOOLEAN,
    fecha_nacimiento TIMESTAMP,
    fecha_muerte TIMESTAMP,
    exotico BOOLEAN,
    extranjero BOOLEAN,
    especie VARCHAR(50),
    raza VARCHAR(50),


    CONSTRAINT animal_instancia__clave
        PRIMARY KEY (id),


    CONSTRAINT animal_instancia__animal
        FOREIGN KEY (especie, raza) REFERENCES animal
);