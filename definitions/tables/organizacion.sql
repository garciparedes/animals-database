CREATE TABLE organizacion (

    id_responsable INTEGER     NOT NULL,

    nif            VARCHAR(20) NOT NULL,
    tipo           VARCHAR(50) NOT NULL,

    CONSTRAINT organizacion__clave
    PRIMARY KEY (id_responsable, nif),


    CONSTRAINT organizacion__responsable
    FOREIGN KEY (id_responsable)
    REFERENCES responsable (id_responsable)

    /*
    ,
    CONSTRAINT unique_responsable_organizacion
    CHECK (
        NOT exists(
            SELECT p.id_responsable
            FROM persona p
            WHERE p.id_responsable = id_responsable
        )
    )
    */
);