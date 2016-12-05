CREATE TABLE licencia (


    /*
    Clave foranea hacia responsable
     */
    id_responsable  INTEGER     NOT NULL,


    /*
    Atributos propios de licencia
     */
    nombre VARCHAR(50) NOT NULL,
    num_licencia    INTEGER,
    inicio          DATE,

    fin             DATE        NOT NULL,


    CONSTRAINT licencia_instancia__clave
    PRIMARY KEY (nombre, num_licencia, inicio),


    CONSTRAINT licencia_instancia__responsable
    FOREIGN KEY (id_responsable)
    REFERENCES responsable (id_responsable)
);