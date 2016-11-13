CREATE TABLE animal_censado(


    animal__id INTEGER NOT NULL,


    nombre VARCHAR(50),
    aptitud VARCHAR(50),
    capa VARCHAR(50),
    domicilio VARCHAR(50),
    idchip INTEGER,
    lazarillo BOOLEAN,


    CONSTRAINT animal_censado__clave
        PRIMARY KEY (animal__id),


    CONSTRAINT animal_censado_extends_animal
        FOREIGN KEY (animal__id) REFERENCES animal
);