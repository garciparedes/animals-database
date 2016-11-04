CREATE TABLE Propiedad(

    identificadorA INTEGER NOT NULL,
    identificadorR INTEGER NOT NULL,

    fechaInicio TIMESTAMP,
    fechaFin TIMESTAMP,



    CONSTRAINT clavePropiedad
        PRIMARY KEY (identificadorA, identificadorR, fechaInicio),



    CONSTRAINT responsablePropiedad
        FOREIGN KEY (identificadorR) REFERENCES Responsable,


    CONSTRAINT iAnimalPropiedad
        FOREIGN KEY (identificadorA) REFERENCES InstanciaAnimal
);