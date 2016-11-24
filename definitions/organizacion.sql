CREATE TABLE organizacion (

    id_responsable INTEGER NOT NULL ,

    nif            VARCHAR(20),
    tipo           VARCHAR(50),

    CONSTRAINT organizacion__clave
    PRIMARY KEY (id_responsable, nif),


    CONSTRAINT organizacion__responsable
    FOREIGN KEY (id_responsable) REFERENCES responsable
);