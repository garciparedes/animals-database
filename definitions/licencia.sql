CREATE TABLE licencia (

    /*
    Atributos propios de licencia
     */
    nombre_licencia VARCHAR(50),
    tipo_licencia VARCHAR(50),
    descripcion_licencia VARCHAR(512),



    CONSTRAINT licencia__clave
        PRIMARY KEY (nombre_licencia)
);