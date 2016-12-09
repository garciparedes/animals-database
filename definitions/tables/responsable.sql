/*
Tabla Responsable
 */
CREATE TABLE responsable (


    /*
    Atributos propios de responsable
     */
    id_responsable INTEGER NOT NULL AUTO_INCREMENT,
    nombre         VARCHAR(50)  NOT NULL,
    domicilio      VARCHAR(512) NOT NULL,


    CONSTRAINT responsable__clave
    PRIMARY KEY (id_responsable)
);