CREATE TABLE Infraccion (

    identificador INTEGER,
    tipo VARCHAR(50),
    descripcion TEXT,


    CONSTRAINT claveInfraccion
        PRIMARY KEY (identificador)
);