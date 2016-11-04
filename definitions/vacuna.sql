CREATE TABLE Vacuna (

    nombre VARCHAR(50),
    obligatoria BOOLEAN,
    periodica BOOLEAN,
    descripcion TEXT,


    CONSTRAINT claveVacuna
        PRIMARY KEY (nombre)
);