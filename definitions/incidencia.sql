CREATE TABLE incidencia (

    /*
    Clave foranea hacia propiedad
     */
    id_animal INTEGER NOT NULL,
    id_responsable INTEGER NOT NULL,
    inicio_propiedad TIMESTAMP NOT NULL,


    /*
    Clave foranea hacia infraccion
     */
    nombre_infraccion VARCHAR(50) NOT NULL,


    /*
    Clave foranea hacia de tenedor
     */
    id_tenedor INTEGER,


    /*
    Atributos propios de incidencia
     */
    fecha_incidencia TIMESTAMP,
    tipo VARCHAR(50),
    sancion DECIMAL,
    medida_cautelar VARCHAR(512),



    CONSTRAINT incidencia__clave
        PRIMARY KEY (id_animal, id_responsable,fecha_incidencia),


    CONSTRAINT incidencia__propiedad
        FOREIGN KEY (id_animal, id_responsable, inicio_propiedad) REFERENCES propiedad,

    CONSTRAINT incidencia__infraccion
        FOREIGN KEY (nombre_infraccion) REFERENCES infraccion,

    CONSTRAINT incidencia__tenedor
        FOREIGN KEY (id_tenedor) REFERENCES responsable
);