CREATE TABLE incidencia (

    /*
    Clave foranea hacia propiedad
     */
    id_animal         INTEGER     NOT NULL,
    inicio_propiedad  TIMESTAMP   NOT NULL,

    /*
    Clave foranea hacia de tenedor
     */
    id_tenedor        INTEGER,


    /*
    Atributos propios de incidencia
     */
    nombre VARCHAR(50),
    fecha             TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    tipo              VARCHAR(50) NOT NULL,
    sancion           DECIMAL,
    medida_cautelar   VARCHAR(512),


    CONSTRAINT incidencia__clave
    PRIMARY KEY (id_animal, fecha, nombre),


    CONSTRAINT incidencia__propiedad
    FOREIGN KEY (id_animal, inicio_propiedad)
    REFERENCES propiedad (id_animal, inicio_propiedad),



    CONSTRAINT incidencia__tenedor
    FOREIGN KEY (id_tenedor)
    REFERENCES responsable (id_responsable)
);