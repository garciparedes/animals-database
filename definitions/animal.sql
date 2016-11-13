CREATE TABLE animal(

    especie VARCHAR(50) NOT NULL,
    raza VARCHAR(50) NOT NULL,

    id INTEGER,
    de_compañia BOOLEAN,
    potencialmente_peligroso BOOLEAN,
    fecha_nacimiento TIMESTAMP,
    fecha_muerte TIMESTAMP,
    exotico BOOLEAN,
    extranjero BOOLEAN,


    CONSTRAINT animal__clave
        PRIMARY KEY (id)
);