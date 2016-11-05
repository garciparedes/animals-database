CREATE TABLE infraccion (

    identificador INTEGER,
    tipo VARCHAR(50),
    descripcion TEXT,


    CONSTRAINT infraccion__clave
        PRIMARY KEY (identificador)
);