CREATE TABLE licencia (

    /*
    Atributos propios de licencia
     */
    nombre_licencia VARCHAR(50),
    tipo            VARCHAR(50) NOT NULL,
    descripcion     VARCHAR(512),


    CONSTRAINT licencia__clave
    PRIMARY KEY (nombre_licencia)
);