CREATE TABLE persona (
    id_responsable INTEGER      NOT NULL,

    dni            VARCHAR(20)  NOT NULL,
    apellidos      VARCHAR(100) NOT NULL,
    nacimiento     DATE         NOT NULL,
    delitos        BIT          NOT NULL,
    seguro_rc      DATE,

    CONSTRAINT persona__clave
    PRIMARY KEY (id_responsable, dni),

    CONSTRAINT persona__responsable
    FOREIGN KEY (id_responsable)
    REFERENCES responsable (id_responsable)
    /*
    ,


    CONSTRAINT unique_responsable_persona
    CHECK (
        NOT exists(
            SELECT o.id_responsable
            FROM organizacion o
            WHERE o.id_responsable = id_responsable
        )
    )
    */
);

CREATE TRIGGER unique_responsable_persona
BEFORE INSERT ON persona
FOR EACH ROW
    BEGIN
        IF NEW.id_responsable NOT IN (
            SELECT o.id_responsable
            FROM organizacion o -- CHANGED THE ALIAS TO A
            WHERE (NEW.id_responsable = o.id_responsable)
        )
        THEN -- MISSING THEN
            CALL 'Insert not allowed';
        END IF;
    END;
