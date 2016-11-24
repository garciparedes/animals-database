CREATE TABLE animal (

    /*
    Atributos propios de animal
     */
    id_animal INTEGER,
    especie VARCHAR(50) NOT NULL,
    raza VARCHAR(50) NOT NULL,
    de_compañia BIT,
    potencialmente_peligroso BIT,
    fecha_nacimiento TIMESTAMP,
    fecha_muerte TIMESTAMP,
    exotico BIT,
    extranjero BIT,



    CONSTRAINT animal__clave
        PRIMARY KEY (id_animal)
);
