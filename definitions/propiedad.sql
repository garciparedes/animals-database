CREATE TABLE propiedad (


    animal__id INTEGER NOT NULL,

    responsable__id INTEGER NOT NULL,


    fecha_inicio TIMESTAMP,
    fecha_fin TIMESTAMP,


    CONSTRAINT propiedad__clave
        PRIMARY KEY (
            animal__id,
            responsable__id,
            fecha_inicio
        ),


    CONSTRAINT propiedad__responsable
        FOREIGN KEY (responsable__id) REFERENCES responsable,

    CONSTRAINT propiedad__animal
        FOREIGN KEY (animal__id) REFERENCES animal
);