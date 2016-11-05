CREATE TABLE incidencia (

    identificadorAP INTEGER NOT NULL,
    identificadorRP INTEGER NOT NULL,
    fechaInicioP TIMESTAMP NOT NULL,

    fecha TIMESTAMP,
    tipo VARCHAR(50),


    CONSTRAINT claveIncidencia
        PRIMARY KEY (identificadorAP, identificadorRP, fecha),


    CONSTRAINT propiedadIncidencia
        FOREIGN KEY (identificadorAP, identificadorRP, fechaInicioP) REFERENCES propiedad
);