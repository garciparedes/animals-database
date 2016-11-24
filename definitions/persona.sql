CREATE TABLE persona (
    id_responsable INTEGER NOT NULL,

    dni VARCHAR(20),
    apellidos VARCHAR(100),
    f_nacimiento TIMESTAMP,
    delitos BIT,
    seguro_rc BIT,

    CONSTRAINT persona__clave
    PRIMARY KEY (id_responsable, dni),

    CONSTRAINT persona__responsable
    FOREIGN KEY (id_responsable) REFERENCES responsable
)