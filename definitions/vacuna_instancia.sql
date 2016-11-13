CREATE TABLE vacuna_instancia(


    vacuna__nombre VARCHAR(50) NOT NULL,

    animal__id INTEGER NOT NULL,


    fecha_aplicacion TIMESTAMP,
    fecha_fin_validez TIMESTAMP,


    CONSTRAINT vacuna_instancia__clave
        PRIMARY KEY (vacuna__nombre, fecha_aplicacion, animal__id),


    CONSTRAINT vacuna_instancia__vacuna
        FOREIGN KEY (vacuna__nombre) REFERENCES vacuna,

    CONSTRAINT vacuna_instancia__animal
        FOREIGN KEY (animal__id) REFERENCES animal
);