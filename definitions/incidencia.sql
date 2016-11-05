CREATE TABLE incidencia (

    identificadorAP INTEGER NOT NULL,
    identificadorRP INTEGER NOT NULL,
    propiedad__fecha_inicio TIMESTAMP NOT NULL,

    fecha TIMESTAMP,
    tipo VARCHAR(50),


    CONSTRAINT incidencia__clave
        PRIMARY KEY (identificadorAP, identificadorRP, fecha),


    CONSTRAINT incidencia__propiedad
        FOREIGN KEY (identificadorAP, identificadorRP, propiedad__fecha_inicio) REFERENCES propiedad
);