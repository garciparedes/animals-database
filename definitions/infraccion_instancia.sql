CREATE TABLE infraccion_instancia (


    identificadorAPI INTEGER  NOT NULL,
    identificadorRPI INTEGER NOT NULL,
    fechaI TIMESTAMP NOT NULL,

    infracion__id INTEGER NOT NULL,

    responsable__id INTEGER NOT NULL,


    sancion MONEY,
    medida_cautelar TEXT,


    CONSTRAINT infraccion_instancia__clave
        PRIMARY KEY (identificadorAPI, identificadorRPI, fechaI),



    CONSTRAINT infraccion_instancia__incidencia
        FOREIGN KEY (identificadorAPI, identificadorRPI, fechaI) REFERENCES incidencia,

    CONSTRAINT infraccion_instancia__infraccion
        FOREIGN KEY (infracion__id) REFERENCES infraccion,

    CONSTRAINT infraccion_instancia__responsable
        FOREIGN KEY (responsable__id) REFERENCES responsable
);