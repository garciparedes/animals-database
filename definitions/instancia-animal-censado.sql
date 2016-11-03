CREATE TABLE InstanciaAnimalCensado(

    identificadorA INTEGER NOT NULL,
    nombre VARCHAR(50),
    aptitud VARCHAR(50),
    capa VARCHAR(50),
    domicilio VARCHAR(50),
    idchip INTEGER,
    lazarillo BOOLEAN,



    CONSTRAINT claveIACensado
        PRIMARY KEY (identificadorA),

    CONSTRAINT extendsIAnimal
        FOREIGN KEY (identificadorA) REFERENCES InstanciaAnimal
);