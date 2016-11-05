CREATE TABLE vacuna (


    nombre VARCHAR(50),
    obligatoria BOOLEAN,
    periodica BOOLEAN,
    descripcion TEXT,


    CONSTRAINT vacuna__clave
        PRIMARY KEY (nombre)
);