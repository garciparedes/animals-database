CREATE TABLE propiedad (

    /*
    Clave foranea hacia animal
     */
    id_animal        INTEGER,


    /*
    Clave foranea hacia responsable
     */
    id_responsable   INTEGER,


    /*
    Atributos propios de propiedad
     */
    inicio_propiedad TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    fin              TIMESTAMP NULL DEFAULT NULL,


    UNIQUE (id_animal, id_responsable, inicio_propiedad),

    CONSTRAINT propiedad__clave
    PRIMARY KEY (id_animal, inicio_propiedad),


    CONSTRAINT propiedad__responsable
    FOREIGN KEY (id_responsable)
    REFERENCES responsable (id_responsable),

    CONSTRAINT propiedad__animal
    FOREIGN KEY (id_animal)
    REFERENCES animal (id_animal),


    CONSTRAINT propiedad__date
    CHECK (NOT EXISTS(
        SELECT *
        WHERE inicio_propiedad > fin
    ))
);