/*
Tabla Animal Censado
 */
CREATE TABLE animal_censado (

    /*
    Clave foranea hacia animal
     */
    id_animal        INTEGER,


    /*
    Atributos propios de animal_censado
     */
    nombre           VARCHAR(50)  NOT NULL,
    aptitud          VARCHAR(50)  NOT NULL,
    capa             VARCHAR(50)  NOT NULL,
    domicilio        VARCHAR(512) NOT NULL,
    id_chip          INTEGER      NOT NULL,
    id_censal        INTEGER      NOT NULL,
    lazarillo        BIT          NOT NULL,


    nacimiento DATE         NOT NULL,
    muerte     DATE,


    CONSTRAINT animal_censado__unique_censal
    UNIQUE (id_censal),


    CONSTRAINT animal_censado__unique_chip
    UNIQUE (id_chip),

    CONSTRAINT animal_censado__clave
    PRIMARY KEY (id_animal),


    CONSTRAINT animal_censado_extends_animal
    FOREIGN KEY (id_animal)
    REFERENCES animal (id_animal),


    CONSTRAINT animal__fecha
    CHECK (
        CASE WHEN muerte IS NOT NULL
            THEN
                nacimiento <= muerte
        END
    )
);