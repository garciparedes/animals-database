/*
Tabla Organizacion
 */
CREATE TABLE organizacion (

    id_responsable INTEGER     NOT NULL,

    cif            VARCHAR(20) NOT NULL,
    tipo           VARCHAR(50) NOT NULL,

    CONSTRAINT organizacion__unique_cif
    UNIQUE (cif),

    CONSTRAINT organizacion__clave
    PRIMARY KEY (id_responsable),


    CONSTRAINT organizacion__responsable
    FOREIGN KEY (id_responsable)
    REFERENCES responsable (id_responsable),


    CONSTRAINT organizacion__tipo
    CHECK (
        tipo IN ('explotacion', 'zoo', 'circo', 'clinica')
    ),

    CONSTRAINT persona__nif_es
    CHECK (cif LIKE '%(1)[0-9](8)%(1)')
);
