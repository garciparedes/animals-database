CREATE TABLE infraccion_instancia (

    sancion MONEY,
    medidaCautelar TEXT,


    identificadorAPI INTEGER  NOT NULL,
    identificadorRPI INTEGER NOT NULL,
    fechaI TIMESTAMP NOT NULL,


    identificadorInf INTEGER NOT NULL,

    identificadorR INTEGER NOT NULL,




    CONSTRAINT infraccion_instancia__clave
        PRIMARY KEY (identificadorAPI, identificadorRPI, fechaI),



    CONSTRAINT infraccion_instancia__incidencia
        FOREIGN KEY (identificadorAPI, identificadorRPI, fechaI) REFERENCES incidencia,

    CONSTRAINT infraccion_instancia__infraccion
        FOREIGN KEY (identificadorInf) REFERENCES infraccion,

    CONSTRAINT infraccion_instancia__responsable
        FOREIGN KEY (identificadorR) REFERENCES responsable
);