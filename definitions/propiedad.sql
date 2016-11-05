CREATE TABLE propiedad (


    identificadorA INTEGER NOT NULL,
    identificadorR INTEGER NOT NULL,


    fecha_inicio TIMESTAMP,
    fecha_fin TIMESTAMP,


    CONSTRAINT propiedad__clave
        PRIMARY KEY (identificadorA, identificadorR, fecha_inicio),



    CONSTRAINT propiedad__responsable
        FOREIGN KEY (identificadorR) REFERENCES responsable,

    CONSTRAINT propiedad__animal_instancia
        FOREIGN KEY (identificadorA) REFERENCES animal_instancia
);