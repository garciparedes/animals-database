CREATE TABLE propiedad (

    identificadorA INTEGER NOT NULL,
    identificadorR INTEGER NOT NULL,

    fechaInicio TIMESTAMP,
    fechaFin TIMESTAMP,



    CONSTRAINT propiedad__clave
        PRIMARY KEY (identificadorA, identificadorR, fechaInicio),



    CONSTRAINT propiedad__responsable
        FOREIGN KEY (identificadorR) REFERENCES responsable,


    CONSTRAINT propiedad__animal_instancia
        FOREIGN KEY (identificadorA) REFERENCES animal_instancia
);