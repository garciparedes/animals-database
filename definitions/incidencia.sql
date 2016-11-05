CREATE TABLE incidencia (


    propiedad__animal_instancia__id INTEGER NOT NULL,
    propiedad__responsable__id INTEGER NOT NULL,
    propiedad__fecha_inicio TIMESTAMP NOT NULL,


    fecha TIMESTAMP,
    tipo VARCHAR(50),


    CONSTRAINT incidencia__clave
        PRIMARY KEY (
            propiedad__animal_instancia__id,
            propiedad__responsable__id,
            fecha
        ),


    CONSTRAINT incidencia__propiedad
        FOREIGN KEY (
            propiedad__animal_instancia__id,
            propiedad__responsable__id,
            propiedad__fecha_inicio
        ) REFERENCES propiedad
);