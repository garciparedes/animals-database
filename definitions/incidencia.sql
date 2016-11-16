CREATE TABLE incidencia (


    fecha TIMESTAMP,
    tipo VARCHAR(50),


    propiedad__animal__id INTEGER  NOT NULL,
    propiedad__responsable__id INTEGER NOT NULL,
    propiedad__fecha_inicio TIMESTAMP NOT NULL,

    infracion__nombre VARCHAR(50) NOT NULL,

    fecha TIMESTAMP,
    tenedor__id INTEGER,


    sancion MONEY,
    medida_cautelar TEXT,


    CONSTRAINT infraccion_instancia__clave
        PRIMARY KEY (
            propiedad__animal__id,
            propiedad__responsable__id,
            fecha
        ),



    CONSTRAINT incidencia__propiedad
        FOREIGN KEY (
            propiedad__animal__id,
            propiedad__responsable__id,
            propiedad__fecha_inicio
    ) REFERENCES propiedad,

    CONSTRAINT infraccion_instancia__infraccion
        FOREIGN KEY (infracion__nombre) REFERENCES infraccion,

    CONSTRAINT infraccion_instancia__tenedor
        FOREIGN KEY (tenedor__id) REFERENCES responsable
);