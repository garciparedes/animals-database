CREATE TABLE responsable (


    /*
    Atributos propios de responsable
     */
    id_responsable INTEGER,
    nombre_responsable VARCHAR(50),
    domicilio_responsable VARCHAR,



    CONSTRAINT responsable__clave
        PRIMARY KEY (id_responsable)
);