CREATE TABLE animal (

    /*
    Atributos propios de animal
     */
    id_animal   INTEGER,

    especie     VARCHAR(50) NOT NULL,
    raza        VARCHAR(50) NOT NULL,

    de_compañia BIT         NOT NULL,
    peligroso   BIT         NOT NULL,
    exotico     BIT         NOT NULL,
    extranjero  BIT         NOT NULL,


    CONSTRAINT animal__clave
    PRIMARY KEY (id_animal)
);
