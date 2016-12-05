CREATE TABLE vacuna_instancia (

    /*
    Clave foranea hacia vacuna
     */
    nombre_vacuna VARCHAR(50),

    /*
    Clave foranea hacia animal
     */
    id_animal     INTEGER,


    /*
    Atributos propios de vacuna_instancia
     */
    aplicacion    DATE,
    fin           DATE,


    CONSTRAINT vacuna_instancia__clave
    PRIMARY KEY (nombre_vacuna, aplicacion, id_animal),


    CONSTRAINT vacuna_instancia__vacuna
    FOREIGN KEY (nombre_vacuna)
    REFERENCES vacuna (nombre_vacuna),

    CONSTRAINT vacuna_instancia__animal
    FOREIGN KEY (id_animal)
    REFERENCES animal (id_animal)
);