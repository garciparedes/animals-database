CREATE TABLE infraccion_instancia (


    incidencia__propiedad__animal_instancia__id INTEGER  NOT NULL,
    incidencia__propiedad__responsable__id INTEGER NOT NULL,
    incidencia__fecha TIMESTAMP NOT NULL,

    infracion__nombre VARCHAR(50) NOT NULL,

    responsable__id INTEGER NOT NULL,


    sancion MONEY,
    medida_cautelar TEXT,


    CONSTRAINT infraccion_instancia__clave
        PRIMARY KEY (
            incidencia__propiedad__animal_instancia__id,
            incidencia__propiedad__responsable__id,
            incidencia__fecha
        ),



    CONSTRAINT infraccion_instancia__incidencia
        FOREIGN KEY (
            incidencia__propiedad__animal_instancia__id,
            incidencia__propiedad__responsable__id,
            incidencia__fecha
    ) REFERENCES incidencia,

    CONSTRAINT infraccion_instancia__infraccion
        FOREIGN KEY (infracion__nombre) REFERENCES infraccion,

    CONSTRAINT infraccion_instancia__responsable
        FOREIGN KEY (responsable__id) REFERENCES responsable
);