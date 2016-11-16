CREATE TABLE licencia_instancia(


    /*
    Clave foranea hacia responsable
     */
    id_responsable INTEGER NOT NULL,


    /*
    Clave foranea hacia licencia
     */
    nombre_licencia VARCHAR(50) NOT NULL,


    /*
    Atributos propios de instancia licencia_instancia
     */
    num_licencia INTEGER,
    inicio_licencia TIMESTAMP,
    fin_licencia TIMESTAMP,



    CONSTRAINT licencia_instancia__clave
        PRIMARY KEY (num_licencia, inicio_licencia),


    CONSTRAINT licencia_instancia__responsable
        FOREIGN KEY (id_responsable) REFERENCES responsable,

    CONSTRAINT licencia_instancia__licencia
        FOREIGN KEY (nombre_licencia) REFERENCES licencia
);