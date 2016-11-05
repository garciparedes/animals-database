CREATE TABLE licencia (


    nombre VARCHAR(50),
    tipo VARCHAR(50),
    descripcion TEXT,


    CONSTRAINT licencia__clave
        PRIMARY KEY (nombre)
);