CREATE TABLE persona (
    id_responsable INTEGER      NOT NULL,

    nif            VARCHAR(20)  NOT NULL,
    apellidos      VARCHAR(100) NOT NULL,
    nacimiento     DATE         NOT NULL,
    delitos        BIT          NOT NULL,
    seguro_rc      DATE,

    CONSTRAINT persona__unique_nif
    UNIQUE (nif),

    CONSTRAINT persona__clave
    PRIMARY KEY (id_responsable),

    CONSTRAINT persona__responsable
    FOREIGN KEY (id_responsable)
    REFERENCES responsable (id_responsable),


    CONSTRAINT persona__nacimiento
    CHECK (nacimiento <= CURRENT_TIMESTAMP),


    /*
    https://ec.europa.eu/taxation_customs/tin/pdf/es/TIN_-_subject_sheet_-_1_structure_summary_es.pdf
     */
    CONSTRAINT persona__nif_es
    CHECK (nif LIKE '[0-9](8)%(1)' OR '%(1)[0-9](7)%(1)')
);
