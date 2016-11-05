CREATE TABLE InstanciaVacuna(

    nombreV VARCHAR(50) NOT NULL,
    identificadorA INTEGER NOT NULL,

    fechaAplicacion TIMESTAMP,
    fechaFinValidez TIMESTAMP,


    CONSTRAINT claveIVacuna
        PRIMARY KEY (nombreV, fechaAplicacion, identificadorA),


    CONSTRAINT vacunaIVacuna
        FOREIGN KEY (nombreV) REFERENCES Vacuna,

    CONSTRAINT iAnimalIVacuna
        FOREIGN KEY (identificadorA) REFERENCES InstanciaAnimal
);