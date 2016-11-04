CREATE TABLE Responsable (

    identificador INTEGER,
    nombre VARCHAR(50),
    domicilio TEXT,

    CONSTRAINT claveResponsable
        PRIMARY KEY (identificador)
);