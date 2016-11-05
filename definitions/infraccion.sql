CREATE TABLE infraccion (


    nombre VARCHAR(50),
    tipo VARCHAR(50),
    descripcion TEXT,


    CONSTRAINT infraccion__clave
        PRIMARY KEY (nombre)
);