CREATE TABLE vacuna_instancia(

    /*
    Clave foranea hacia vacuna
     */
    nombre_vacuna VARCHAR(50) NOT NULL,

    /*
    Clave foranea hacia animal
     */
    id_animal INTEGER NOT NULL,


    /*
    Atributos propios de vacuna_instancia
     */
    aplicacion_vacuna TIMESTAMP,
    fin_vacuna TIMESTAMP,



    CONSTRAINT vacuna_instancia__clave
        PRIMARY KEY (nombre_vacuna, aplicacion_vacuna, id_animal),


    CONSTRAINT vacuna_instancia__vacuna
        FOREIGN KEY (nombre_vacuna) REFERENCES vacuna,

    CONSTRAINT vacuna_instancia__animal
        FOREIGN KEY (id_animal) REFERENCES animal
);