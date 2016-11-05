CREATE TABLE licencia_instancia(


    identificadorR INTEGER NOT NULL,
    identificadorL INTEGER NOT NULL,


    num_licencia INTEGER,
    fecha_inicio TIMESTAMP,
    fecha_fin TIMESTAMP,


    CONSTRAINT licencia_instancia__clave
        PRIMARY KEY (num_licencia, fecha_inicio),


    CONSTRAINT licencia_instancia__responsable
        FOREIGN KEY (identificadorR) REFERENCES responsable,

    CONSTRAINT licencia_instancia__licencia
        FOREIGN KEY (identificadorL) REFERENCES licencia
);