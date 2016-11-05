CREATE TABLE vacuna_instancia(

    vacuna__nombre VARCHAR(50) NOT NULL,

    animal_instancia__id INTEGER NOT NULL,


    fecha_aplicacion TIMESTAMP,
    fecha_fin_validez TIMESTAMP,


    CONSTRAINT vacuna_instancia__clvae
        PRIMARY KEY (vacuna__nombre, fecha_aplicacion, animal_instancia__id),


    CONSTRAINT vacuna_instancia__vacuna
        FOREIGN KEY (vacuna__nombre) REFERENCES vacuna,

    CONSTRAINT vacuna_instancia__animal_instancia
        FOREIGN KEY (animal_instancia__id) REFERENCES animal_instancia
);