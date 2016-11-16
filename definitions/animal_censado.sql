CREATE TABLE animal_censado(

    /*
    Clave foranea hacia animal
     */
    id_animal INTEGER NOT NULL,


    /*
    Atributos propios de animal_censado
     */
    nombre VARCHAR(50),
    aptitud VARCHAR(50),
    capa VARCHAR(50),
    domicilio VARCHAR(50),
    idchip INTEGER,
    lazarillo BIT,



    CONSTRAINT animal_censado__clave
        PRIMARY KEY (id_animal),


    CONSTRAINT animal_censado_extends_animal
        FOREIGN KEY (id_animal) REFERENCES animal
);