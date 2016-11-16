CREATE TABLE infraccion (

    /*
    Atributos propios de infraccion
     */
    nombre_infraccion VARCHAR(50),
    tipo_infraccion VARCHAR(50),
    descripcion_infraccion VARCHAR,



    CONSTRAINT infraccion__clave
        PRIMARY KEY (nombre_infraccion)
);