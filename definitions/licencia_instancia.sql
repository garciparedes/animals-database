CREATE TABLE licencia_instancia(


    responsable__id INTEGER NOT NULL,

    licencia__id INTEGER NOT NULL,


    num_licencia INTEGER,
    fecha_inicio TIMESTAMP,
    fecha_fin TIMESTAMP,


    CONSTRAINT licencia_instancia__clave
        PRIMARY KEY (num_licencia, fecha_inicio),


    CONSTRAINT licencia_instancia__responsable
        FOREIGN KEY (responsable__id) REFERENCES responsable,

    CONSTRAINT licencia_instancia__licencia
        FOREIGN KEY (licencia__id) REFERENCES licencia
);