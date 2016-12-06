CREATE TABLE persona (
    id_responsable INTEGER      NOT NULL,

    dni            VARCHAR(20)  NOT NULL,
    apellidos      VARCHAR(100) NOT NULL,
    nacimiento     DATE         NOT NULL,
    delitos        BIT          NOT NULL,
    seguro_rc      DATE,

    CONSTRAINT persona__unique_dni
    UNIQUE (dni),

    CONSTRAINT persona__clave
    PRIMARY KEY (id_responsable),

    CONSTRAINT persona__responsable
    FOREIGN KEY (id_responsable)
    REFERENCES responsable (id_responsable),


    CONSTRAINT persona__nacimiento
    CHECK (nacimiento <= CURRENT_TIMESTAMP)
);
