CREATE TABLE vacuna_instancia(

    nombreV VARCHAR(50) NOT NULL,
    identificadorA INTEGER NOT NULL,

    fechaAplicacion TIMESTAMP,
    fechaFinValidez TIMESTAMP,


    CONSTRAINT vacuna_instancia__clvae
        PRIMARY KEY (nombreV, fechaAplicacion, identificadorA),


    CONSTRAINT vacuna_instancia__vacuna
        FOREIGN KEY (nombreV) REFERENCES vacuna,

    CONSTRAINT vacuna_instancia__animal_instancia
        FOREIGN KEY (identificadorA) REFERENCES animal_instancia
);