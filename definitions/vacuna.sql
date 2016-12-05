CREATE TABLE vacuna (


    /*
    Clave foranea hacia animal
     */
    id_animal     INTEGER,


    /*
    Atributos propios de vacuna_instancia
     */
    nombre_vacuna VARCHAR(50),
    aplicacion    DATE,
    fin           DATE,


    CONSTRAINT vacuna_instancia__clave
    PRIMARY KEY (nombre_vacuna, aplicacion, id_animal),


    CONSTRAINT vacuna_instancia__animal
    FOREIGN KEY (id_animal)
    REFERENCES animal (id_animal)
);