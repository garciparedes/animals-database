CREATE TABLE animal (

    especie VARCHAR(50),
    raza VARCHAR(50),
    descripcion TEXT,

    CONSTRAINT animal__clave
        PRIMARY KEY (especie, raza)
);

