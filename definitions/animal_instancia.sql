CREATE TABLE animal_instancia(

    identificador INTEGER,
    deCompañia BOOLEAN,
    potencialmentePeligroso BOOLEAN,
    fechaNacimiento TIMESTAMP,
    fechaMuerte TIMESTAMP,
    exotico BOOLEAN,
    extranjero BOOLEAN,
    especie VARCHAR(50),
    raza VARCHAR(50),

    CONSTRAINT animal_instancia__clave
        PRIMARY KEY (identificador),

    CONSTRAINT animal_instancia__animal
        FOREIGN KEY (especie, raza) REFERENCES animal
);