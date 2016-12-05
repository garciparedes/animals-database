CREATE TABLE vacuna (

    /*
    Atributos propios de vacuna
     */
    nombre_vacuna VARCHAR(50) NOT NULL,
    obligatoria   BIT         NOT NULL,
    periodica     BIT         NOT NULL,
    descripcion   VARCHAR(512),


    CONSTRAINT vacuna__clave
    PRIMARY KEY (nombre_vacuna)
);