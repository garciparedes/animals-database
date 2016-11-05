CREATE TABLE InstanciaLicencia(

    identificadorR INTEGER NOT NULL,
    identificadorL INTEGER NOT NULL,

    numLicencia INTEGER,
    fechaInicio TIMESTAMP,
    fechaFin TIMESTAMP,


    CONSTRAINT claveILicencia
        PRIMARY KEY (numLicencia, fechaInicio),


    CONSTRAINT responsableILicencia
        FOREIGN KEY (identificadorR) REFERENCES responsable,

    CONSTRAINT licenciaILicencia
        FOREIGN KEY (identificadorL) REFERENCES licencia
);