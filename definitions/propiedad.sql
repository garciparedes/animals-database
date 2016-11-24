CREATE TABLE propiedad (

    /*
    Clave foranea hacia animal
     */
    id_animal INTEGER NOT NULL,


    /*
    Clave foranea hacia responsable
     */
    id_responsable INTEGER NOT NULL,


    /*
    Atributos propios de propiedad
     */
    inicio_propiedad TIMESTAMP,
    fin_propiedad TIMESTAMP,



    CONSTRAINT propiedad__clave
        PRIMARY KEY (id_animal, id_responsable, inicio_propiedad),


    CONSTRAINT propiedad__responsable
        FOREIGN KEY (id_responsable) REFERENCES responsable,

    CONSTRAINT propiedad__animal
        FOREIGN KEY (id_animal) REFERENCES animal
);