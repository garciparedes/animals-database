CREATE TABLE organizacion (

    id_responsable INTEGER     NOT NULL,

    nif            VARCHAR(20) NOT NULL,
    tipo           VARCHAR(50) NOT NULL,

    CONSTRAINT organizacion__clave
    PRIMARY KEY (id_responsable, nif),


    CONSTRAINT organizacion__responsable
    FOREIGN KEY (id_responsable)
    REFERENCES responsable (id_responsable),


    CONSTRAINT organizacion__tipo
    CHECK (
        tipo = 'explotacion' OR
        tipo = 'zoo' OR
        tipo = 'circo' OR
        tipo = 'clinica'
    )
);