CREATE TABLE persona (
    id_responsable INTEGER      NOT NULL,

    dni            VARCHAR(20)  NOT NULL,
    apellidos      VARCHAR(100) NOT NULL,
    nacimiento     DATE         NOT NULL,
    delitos        BIT          NOT NULL,
    seguro_rc      BIT          NOT NULL,

    CONSTRAINT persona__clave
    PRIMARY KEY (id_responsable, dni),

    CONSTRAINT persona__responsable
    FOREIGN KEY (id_responsable)
    REFERENCES responsable (id_responsable)
)