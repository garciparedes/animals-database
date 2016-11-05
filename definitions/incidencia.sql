CREATE TABLE incidencia (

    identificadorAP INTEGER NOT NULL,
    identificadorRP INTEGER NOT NULL,
    fechaInicioP TIMESTAMP NOT NULL,

    fecha TIMESTAMP,
    tipo VARCHAR(50),


    CONSTRAINT incidencia__clave
        PRIMARY KEY (identificadorAP, identificadorRP, fecha),


    CONSTRAINT incidencia__propiedad
        FOREIGN KEY (identificadorAP, identificadorRP, fechaInicioP) REFERENCES propiedad
);