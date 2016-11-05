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

    CONSTRAINT claveIAnimal
        PRIMARY KEY (identificador),

    CONSTRAINT animalIAnimal
        FOREIGN KEY (especie, raza) REFERENCES animal
);