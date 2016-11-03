CREATE TABLE Animal (

    especie VARCHAR(50),
    raza VARCHAR(50),
    descripcion TEXT,

    CONSTRAINT uniAnimal
        UNIQUE (especie,raza),

    CONSTRAINT claveAnimal
        PRIMARY KEY (especie, raza)
);

