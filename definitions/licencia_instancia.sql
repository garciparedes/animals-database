CREATE TABLE licencia_instancia (


    /*
    Clave foranea hacia responsable
     */
    id_responsable  INTEGER           NOT NULL,


    /*
    Clave foranea hacia licencia
     */
    nombre_licencia VARCHAR(50)       NOT NULL,


    /*
    Atributos propios de instancia licencia_instancia
     */
    num_licencia    INTEGER,
    inicio          DATE,
    fin             DATE NOT NULL,


    CONSTRAINT licencia_instancia__clave
    PRIMARY KEY (num_licencia, inicio),


    CONSTRAINT licencia_instancia__responsable
    FOREIGN KEY (id_responsable)
    REFERENCES responsable (id_responsable),

    CONSTRAINT licencia_instancia__licencia
    FOREIGN KEY (nombre_licencia)
    REFERENCES licencia (nombre_licencia)
);