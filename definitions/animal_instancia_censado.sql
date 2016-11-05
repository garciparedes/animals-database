CREATE TABLE animal_instancia_censado(

    identificadorA INTEGER NOT NULL,
    nombre VARCHAR(50),
    aptitud VARCHAR(50),
    capa VARCHAR(50),
    domicilio VARCHAR(50),
    idchip INTEGER,
    lazarillo BOOLEAN,



    CONSTRAINT animal_instancia_censado__clave
        PRIMARY KEY (identificadorA),

    CONSTRAINT animal_instancia_censado_extends_animal_instancia
        FOREIGN KEY (identificadorA) REFERENCES animal_instancia
);