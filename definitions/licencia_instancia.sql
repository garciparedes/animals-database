CREATE TABLE licencia_instancia(

    identificadorR INTEGER NOT NULL,
    identificadorL INTEGER NOT NULL,

    numLicencia INTEGER,
    fechaInicio TIMESTAMP,
    fechaFin TIMESTAMP,


    CONSTRAINT licencia_instancia__clave
        PRIMARY KEY (numLicencia, fechaInicio),


    CONSTRAINT licencia_instancia__responsable
        FOREIGN KEY (identificadorR) REFERENCES responsable,

    CONSTRAINT licencia_instancia__licencia
        FOREIGN KEY (identificadorL) REFERENCES licencia
);