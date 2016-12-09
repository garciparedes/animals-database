CREATE TABLE incidencia (

    /*
    Clave foranea hacia propiedad
     */
    id_animal        INTEGER     NOT NULL,
    inicio_propiedad TIMESTAMP   NOT NULL,


    /*
    Atributos propios de incidencia
     */
    fecha            TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    nombre           VARCHAR(50),
    sancion          DECIMAL,
    medida_cautelar  VARCHAR(512),


    /*
    Clave foranea hacia de tenedor
     */
    id_tenedor       INTEGER,


    CONSTRAINT incidencia__clave
    PRIMARY KEY (id_animal, fecha),


    CONSTRAINT incidencia__propiedad
    FOREIGN KEY (id_animal, inicio_propiedad)
    REFERENCES propiedad (id_animal, inicio_propiedad),


    CONSTRAINT incidencia__tenedor
    FOREIGN KEY (id_tenedor)
    REFERENCES responsable (id_responsable),


    CONSTRAINT incidencia__fecha
    CHECK (inicio_propiedad >= fecha),

    CONSTRAINT incidencia__sancion
    CHECK (sancion >= 0)
);