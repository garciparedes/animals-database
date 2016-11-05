CREATE TABLE vacuna_instancia(

    nombreV VARCHAR(50) NOT NULL,
    identificadorA INTEGER NOT NULL,

    fechaAplicacion TIMESTAMP,
    fechaFinValidez TIMESTAMP,


    CONSTRAINT claveIVacuna
        PRIMARY KEY (nombreV, fechaAplicacion, identificadorA),


    CONSTRAINT vacunaIVacuna
        FOREIGN KEY (nombreV) REFERENCES vacuna,

    CONSTRAINT iAnimalIVacuna
        FOREIGN KEY (identificadorA) REFERENCES animal_instancia
);