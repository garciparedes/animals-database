CREATE TABLE licencia (


    /*
    Clave foranea hacia responsable
     */
    id_responsable INTEGER     NOT NULL,


    /*
    Atributos propios de licencia
     */
    nombre         VARCHAR(50) NOT NULL,
    num_licencia   INTEGER,
    inicio         DATE,
    fin            DATE        NOT NULL,


    CONSTRAINT licencia_instancia__clave
    PRIMARY KEY (nombre, num_licencia, inicio),


    CONSTRAINT licencia_instancia__responsable
    FOREIGN KEY (id_responsable)
    REFERENCES responsable (id_responsable),


    CONSTRAINT licencia_perros_peligrosos
    CHECK (
        CASE WHEN nombre = 'perros_peligrosos'
            THEN
                CURRENT_TIMESTAMP - YEAR(18) <= (
                    SELECT p.nacimiento
                    FROM persona p
                    WHERE
                        p.id_responsable = id_responsable AND
                        p.delitos = TRUE AND
                        p.seguro_rc >= CURRENT_TIMESTAMP
                )
        END
    )

);
