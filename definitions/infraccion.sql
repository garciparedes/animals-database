CREATE TABLE infraccion (

    /*
    Atributos propios de infraccion
     */
    nombre_infraccion VARCHAR(50),
    tipo              VARCHAR(50) NOT NULL,
    descripcion       VARCHAR(512),


    CONSTRAINT infraccion__clave
    PRIMARY KEY (nombre_infraccion)
);