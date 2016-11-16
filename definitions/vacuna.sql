CREATE TABLE vacuna (

    /*
    Atributos propios de vacuna
     */
    nombre_vacuna VARCHAR(50),
    obligatoria_vacuna BIT,
    periodica_vacuna BIT,
    descripcion_vacuna VARCHAR,



    CONSTRAINT vacuna__clave
        PRIMARY KEY (nombre_vacuna)
);