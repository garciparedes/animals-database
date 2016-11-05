CREATE TABLE infraccion_instancia (

    sancion MONEY,
    medidaCautelar TEXT,


    identificadorAPI INTEGER  NOT NULL,
    identificadorRPI INTEGER NOT NULL,
    fechaI TIMESTAMP NOT NULL,


    identificadorInf INTEGER NOT NULL,

    identificadorR INTEGER NOT NULL,




    CONSTRAINT claveIInfracción
        PRIMARY KEY (identificadorAPI, identificadorRPI, fechaI),



    CONSTRAINT iInfraccionIncidencia
        FOREIGN KEY (identificadorAPI, identificadorRPI, fechaI) REFERENCES incidencia,

    CONSTRAINT infraccionIInfraccion
        FOREIGN KEY (identificadorInf) REFERENCES infraccion,

    CONSTRAINT responsableIInfraccion
        FOREIGN KEY (identificadorR) REFERENCES responsable
);