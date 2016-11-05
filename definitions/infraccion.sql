CREATE TABLE infraccion (

    id INTEGER,
    tipo VARCHAR(50),
    descripcion TEXT,


    CONSTRAINT infraccion__clave
        PRIMARY KEY (id)
);