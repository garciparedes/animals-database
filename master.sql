
/*
PRACTICA ANALISIS Y DISENO DE BASE DE DATOS: ANIMALES

AUTORES:
SERGIO GARCIA PRADO (garciparedes.me)
FERNANDO URBON DOMINGUEZ
SERGIO MUNOZ GOZALO
*/


/*
DROP DE ANTIGUAS TABLAS
*/

DROP VIEW view_robo RESTRICT;
DROP VIEW view_persona RESTRICT;
DROP VIEW view_perdida RESTRICT;
DROP VIEW view_organizacion RESTRICT;
DROP VIEW view_infraccion RESTRICT;
DROP VIEW view_ficha_censo RESTRICT;
DROP VIEW view_animal_potencialmente_peligroso RESTRICT;
DROP VIEW view_animal_censado RESTRICT;

ALTER TABLE vacuna DROP FOREIGN KEY vacuna_instancia__animal;
ALTER TABLE persona DROP FOREIGN KEY persona__responsable;
ALTER TABLE organizacion DROP FOREIGN KEY organizacion__responsable;
ALTER TABLE licencia DROP FOREIGN KEY licencia_instancia__responsable;
ALTER TABLE incidencia DROP FOREIGN KEY incidencia__propiedad;
ALTER TABLE incidencia DROP FOREIGN KEY incidencia__tenedor;
ALTER TABLE animal_censado DROP FOREIGN KEY animal_censado_extends_animal;
ALTER TABLE propiedad DROP FOREIGN KEY propiedad__animal;
ALTER TABLE propiedad DROP FOREIGN KEY propiedad__responsable;
DROP TABLE vacuna;
DROP TABLE persona;
DROP TABLE organizacion;
DROP TABLE licencia;
DROP TABLE incidencia;
DROP TABLE animal_censado;
DROP TABLE propiedad;
DROP TABLE responsable;
DROP TABLE animal;



/*
DEFINICION DE TABLAS
*/

/*
Tabla Animal
 */
CREATE TABLE animal (

    /*
    Atributos propios de animal
     */
    id_animal   INTEGER AUTO_INCREMENT,

    especie     VARCHAR(50) NOT NULL,
    raza        VARCHAR(50) NOT NULL,

    de_compañia BIT         NOT NULL,
    peligroso   BIT         NOT NULL,
    exotico     BIT         NOT NULL,
    extranjero  BIT         NOT NULL,


    CONSTRAINT animal__clave
    PRIMARY KEY (id_animal)
);


/*
Tabla Animal Censado
 */
CREATE TABLE animal_censado (

    /*
    Clave foranea hacia animal
     */
    id_animal        INTEGER,


    /*
    Atributos propios de animal_censado
     */
    nombre           VARCHAR(50)  NOT NULL,
    aptitud          VARCHAR(50)  NOT NULL,
    capa             VARCHAR(50)  NOT NULL,
    domicilio        VARCHAR(512) NOT NULL,
    id_chip          INTEGER      NOT NULL,
    id_censal        INTEGER      NOT NULL,
    lazarillo        BIT          NOT NULL,


    nacimiento DATE         NOT NULL,
    muerte     DATE,


    CONSTRAINT animal_censado__unique_censal
    UNIQUE (id_censal),


    CONSTRAINT animal_censado__unique_chip
    UNIQUE (id_chip),

    CONSTRAINT animal_censado__clave
    PRIMARY KEY (id_animal),


    CONSTRAINT animal_censado_extends_animal
    FOREIGN KEY (id_animal)
    REFERENCES animal (id_animal),


    CONSTRAINT animal__fecha
    CHECK (
        CASE WHEN muerte IS NOT NULL
            THEN
                nacimiento <= muerte
        END
    )
);

/*
Tabla Vacuna
 */
CREATE TABLE vacuna (


    /*
    Clave foranea hacia animal
     */
    id_animal     INTEGER,


    /*
    Atributos propios de vacuna_instancia
     */
    nombre_vacuna VARCHAR(50),
    aplicacion    TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    fin           TIMESTAMP NULL DEFAULT NULL ,


    CONSTRAINT vacuna_instancia__clave
    PRIMARY KEY (nombre_vacuna, aplicacion, id_animal),


    CONSTRAINT vacuna_instancia__animal
    FOREIGN KEY (id_animal)
    REFERENCES animal (id_animal),



    CONSTRAINT vacuna__fecha
    CHECK (
        CASE WHEN fin IS NOT NULL
            THEN
                aplicacion <= fin
        END
    )
);

/*
Tabla Responsable
 */
CREATE TABLE responsable (


    /*
    Atributos propios de responsable
     */
    id_responsable INTEGER NOT NULL AUTO_INCREMENT,
    nombre         VARCHAR(50)  NOT NULL,
    domicilio      VARCHAR(512) NOT NULL,


    CONSTRAINT responsable__clave
    PRIMARY KEY (id_responsable)
);

/*
Tabla Persona
 */
CREATE TABLE persona (
    id_responsable INTEGER      NOT NULL,

    nif            VARCHAR(20)  NOT NULL,
    apellidos      VARCHAR(100) NOT NULL,
    nacimiento     DATE         NOT NULL,
    delitos        BIT          NOT NULL,
    seguro_rc      DATE,

    CONSTRAINT persona__unique_nif
    UNIQUE (nif),

    CONSTRAINT persona__clave
    PRIMARY KEY (id_responsable),

    CONSTRAINT persona__responsable
    FOREIGN KEY (id_responsable)
    REFERENCES responsable (id_responsable),


    CONSTRAINT persona__nacimiento
    CHECK (nacimiento <= CURRENT_TIMESTAMP),


    /*
    https://ec.europa.eu/taxation_customs/tin/pdf/es/TIN_-_subject_sheet_-_1_structure_summary_es.pdf
     */
    CONSTRAINT persona__nif_es
    CHECK (nif LIKE '[0-9](8)%(1)' OR '%(1)[0-9](7)%(1)')
);


/*
Tabla Organizacion
 */
CREATE TABLE organizacion (

    id_responsable INTEGER     NOT NULL,

    cif            VARCHAR(20) NOT NULL,
    tipo           VARCHAR(50) NOT NULL,

    CONSTRAINT organizacion__unique_cif
    UNIQUE (cif),

    CONSTRAINT organizacion__clave
    PRIMARY KEY (id_responsable),


    CONSTRAINT organizacion__responsable
    FOREIGN KEY (id_responsable)
    REFERENCES responsable (id_responsable),


    CONSTRAINT organizacion__tipo
    CHECK (
        tipo IN ('explotacion', 'zoo', 'circo', 'clinica')
    ),

    CONSTRAINT persona__nif_es
    CHECK (cif LIKE '%(1)[0-9](8)%(1)')
);


/*
Tabla Licencia
 */
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
                CURRENT_TIMESTAMP - YEAR(18) >= (
                    SELECT p.nacimiento
                    FROM persona p
                    WHERE
                        p.id_responsable = id_responsable AND
                        p.delitos = FALSE AND
                        p.seguro_rc >= CURRENT_TIMESTAMP
                )
        END
    )

);


/*
Tabla Propiedad
 */
CREATE TABLE propiedad (

    /*
    Clave foranea hacia animal
     */
    id_animal        INTEGER,


    /*
    Clave foranea hacia responsable
     */
    id_responsable   INTEGER,


    /*
    Atributos propios de propiedad
     */
    inicio_propiedad TIMESTAMP      DEFAULT CURRENT_TIMESTAMP,
    fin              TIMESTAMP NULL DEFAULT NULL,


    CONSTRAINT propiedad__clave
    PRIMARY KEY (id_animal, inicio_propiedad),


    CONSTRAINT propiedad__responsable
    FOREIGN KEY (id_responsable)
    REFERENCES responsable (id_responsable),


    CONSTRAINT propiedad__animal
    FOREIGN KEY (id_animal)
    REFERENCES animal (id_animal),


    CONSTRAINT propiedad__unique
    UNIQUE (id_animal, id_responsable, inicio_propiedad),


    CONSTRAINT propiedad__date
    CHECK (
        CASE WHEN fin IS NOT NULL
            THEN
                inicio_propiedad <= fin
        END
    )
);

/*
Tabla Incidencia
 */
CREATE TABLE incidencia (

    /*
    Clave foranea hacia propiedad
     */
    id_animal        INTEGER     NOT NULL,
    inicio_propiedad TIMESTAMP   NOT NULL,


    /*
    Atributos propios de incidencia
     */
    fecha            TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    nombre           VARCHAR(50),
    sancion          DECIMAL,
    medida_cautelar  VARCHAR(512),


    /*
    Clave foranea hacia de tenedor
     */
    id_tenedor       INTEGER,


    CONSTRAINT incidencia__clave
    PRIMARY KEY (id_animal, fecha),


    CONSTRAINT incidencia__propiedad
    FOREIGN KEY (id_animal, inicio_propiedad)
    REFERENCES propiedad (id_animal, inicio_propiedad),


    CONSTRAINT incidencia__tenedor
    FOREIGN KEY (id_tenedor)
    REFERENCES responsable (id_responsable),


    CONSTRAINT incidencia__fecha
    CHECK (inicio_propiedad >= fecha),

    CONSTRAINT incidencia__sancion
    CHECK (sancion >= 0)
);


/*
DEFINICION DE VISTAS
*/

/*
Vista de animal censado
 */
CREATE OR REPLACE VIEW view_animal_censado
AS
    SELECT *
    FROM
        animal
        NATURAL JOIN animal_censado;




/*
Vista de organizacion
 */
CREATE OR REPLACE VIEW view_organizacion
AS
    SELECT
        *
    FROM
        responsable
        NATURAL JOIN organizacion;




/*
Vista de persona
 */
CREATE OR REPLACE VIEW view_persona
AS
    SELECT *
    FROM
        responsable
        NATURAL JOIN persona;




/*
Vista de infraccion
 */
CREATE OR REPLACE VIEW view_infraccion
AS
    SELECT
        i.id_animal,
        i.inicio_propiedad,
        i.id_tenedor,
        i.nombre,
        i.fecha,
        i.sancion,
        i.medida_cautelar,
        (
            CASE
                WHEN sancion >= 30 AND sancion <= 100
                    THEN 'leve'
                WHEN sancion > 100 AND sancion <= 300
                    THEN 'grave'
                WHEN sancion > 300 AND sancion <= 1200
                    THEN 'muy grave'
                ELSE ''
            END
        ) AS 'tipo_sancion'

    FROM incidencia i
    WHERE i.sancion > 0;

/*
Vista de perdidas
 */
CREATE OR REPLACE VIEW view_perdida
AS
    SELECT
        i.id_animal,
        i.inicio_propiedad,
        i.id_tenedor,
        i.fecha
    FROM incidencia i
    WHERE i.nombre = 'perdida';

/*
Vista de robo
 */
CREATE OR REPLACE VIEW view_robo
AS
    SELECT
        i.id_animal,
        i.inicio_propiedad,
        i.id_tenedor,
        i.fecha
    FROM incidencia i
    WHERE i.nombre = 'robo';

/*
Vista de animal potencialmente peligroso
 */
CREATE OR REPLACE VIEW view_animal_potencialmente_peligroso
AS
    SELECT *
    FROM
        view_animal_censado a
    WHERE a.peligroso = TRUE;




/*
Vista de fichas del censo
 */
CREATE OR REPLACE VIEW view_ficha_censo
AS
    SELECT
        a.especie,
        a.raza,
        a.aptitud,
        a.peligroso,
        extract(YEAR FROM a.nacimiento) as nacimiento,
        a.domicilio   AS domicilio_animal,
        per.nombre,
        per.apellidos,
        per.nif,
        per.domicilio AS domicilio_responsable,
        lic.num_licencia,
        a.id_censal,
        a.id_chip
    FROM
        view_animal_censado a,
        propiedad p,
        view_persona per LEFT JOIN (
        SELECT
            per1.id_responsable,
            l1.num_licencia
        FROM
            view_persona per1,
            licencia l1,
            licencia l2
        WHERE
            l1.id_responsable = per1.id_responsable AND
            l2.id_responsable = per1.id_responsable AND
            l1.nombre = 'perros_peligrosos' AND
            l2.nombre = 'perros_peligrosos' AND
            l1.inicio >= l2.inicio
        ) as lic on per.id_responsable = lic.id_responsable
    WHERE
        per.id_responsable = p.id_responsable AND
        p.id_animal = a.id_animal;



/*
POBLACION DE TABLAS
*/

/*
Insercion de animales
 */

INSERT INTO animal (id_animal, especie, raza, de_compañia, peligroso, exotico, extranjero) VALUE
    (7, 'vaca', 'Cattle', FALSE, FALSE, FALSE, FALSE);

INSERT INTO animal (id_animal, especie, raza, de_compañia, peligroso, exotico, extranjero) VALUE
    (8, 'vaca', 'Cattle', FALSE, FALSE, FALSE, FALSE);

INSERT INTO animal (id_animal, especie, raza, de_compañia, peligroso, exotico, extranjero) VALUE
    (9, 'cabra', 'boer', FALSE, TRUE, FALSE, FALSE);


/*
Insercion de animales censados
 */


INSERT INTO animal (id_animal, especie, raza, de_compañia, peligroso, exotico, extranjero) VALUE
    (1, 'perro', 'alano', TRUE, TRUE, FALSE, TRUE);

INSERT INTO animal (id_animal, especie, raza, de_compañia, peligroso, exotico, extranjero) VALUE
    (2, 'perro', 'alano', TRUE, TRUE, FALSE, FALSE);

INSERT INTO animal (id_animal, especie, raza, de_compañia, peligroso, exotico, extranjero) VALUE
    (3, 'gato', 'persa', TRUE, FALSE, TRUE, TRUE);

INSERT INTO animal (id_animal, especie, raza, de_compañia, peligroso, exotico, extranjero) VALUE
    (4, 'gato', 'alano', TRUE, FALSE, FALSE, FALSE);

INSERT INTO animal (id_animal, especie, raza, de_compañia, peligroso, exotico, extranjero) VALUE
    (5, 'gato', 'siamese', TRUE, FALSE, FALSE, TRUE);

INSERT INTO animal (id_animal, especie, raza, de_compañia, peligroso, exotico, extranjero) VALUE
    (6, 'perro', 'alano', TRUE, TRUE, FALSE, FALSE);

INSERT INTO animal (id_animal, especie, raza, de_compañia, peligroso, exotico, extranjero) VALUE
    (10, 'perro', 'mastin', TRUE, TRUE, FALSE, FALSE);

INSERT INTO animal (id_animal, especie, raza, de_compañia, peligroso, exotico, extranjero) VALUE
    (11, 'perro', 'pastor aleman', TRUE, TRUE, FALSE, FALSE);

INSERT INTO animal_censado (id_animal, nombre, aptitud, capa, domicilio, id_chip, id_censal, lazarillo, nacimiento)
    VALUE
    (1, 'paco', 'tranquilo', 'blanco', 'la rua', '1234', '1', FALSE, '2005-11-10');

INSERT INTO animal_censado (id_animal, nombre, aptitud, capa, domicilio, id_chip, id_censal, lazarillo, nacimiento)
    VALUE
    (2, 'calcetines', 'tranquilo', 'blanco', 'la rua', '12342', '2', FALSE, '2005-11-10');

INSERT INTO animal_censado (id_animal, nombre, aptitud, capa, domicilio, id_chip, id_censal, lazarillo, nacimiento)
    VALUE
    (3, 'charly', 'tranquilo', 'blanco', 'la rua', '12343', '3', FALSE, '2005-11-10');

INSERT INTO animal_censado (id_animal, nombre, aptitud, capa, domicilio, id_chip, id_censal, lazarillo, nacimiento)
    VALUE
    (4, 'toby', 'tranquilo', 'blanco', 'la rua', '12345', '4', FALSE, '2005-11-10');

INSERT INTO animal_censado (id_animal, nombre, aptitud, capa, domicilio, id_chip, id_censal, lazarillo, nacimiento)
    VALUE
    (5, 'toby', 'tranquilo', 'blanco', 'la rua', '12346', '5', FALSE, '2005-11-10');

INSERT INTO animal_censado (id_animal, nombre, aptitud, capa, domicilio, id_chip, id_censal, lazarillo, nacimiento)
    VALUE
    (6, 'manchas', 'tranquilo', 'blanco', 'la rua', '12347', '6', FALSE, '2005-11-10');

INSERT INTO animal_censado (id_animal, nombre, aptitud, capa, domicilio, id_chip, id_censal, lazarillo, nacimiento)
    VALUE
    (10, 'misifu', 'tranquilo', 'blanco', 'la rua', '12348', '7', FALSE, '2005-11-10');

INSERT INTO animal_censado (id_animal, nombre, aptitud, capa, domicilio, id_chip, id_censal, lazarillo, nacimiento)
    VALUE
    (11, 'misifu', 'salvaje', 'blanco', 'la rua', '12349', '8', FALSE, '2004-11-10');

/*
Insercion de vacunas
 */


INSERT INTO vacuna (id_animal, nombre_vacuna) VALUES
    (1, 'rabia');

INSERT INTO vacuna (id_animal, nombre_vacuna) VALUES
    (3, 'rabia');

INSERT INTO vacuna (id_animal, nombre_vacuna) VALUES
    (4, 'rabia');

INSERT INTO vacuna (id_animal, nombre_vacuna) VALUES
    (7, 'rabia');

INSERT INTO vacuna (id_animal, nombre_vacuna) VALUES
    (8, 'rabia');

INSERT INTO vacuna (id_animal, nombre_vacuna) VALUES
    (9, 'rabia');

INSERT INTO vacuna (id_animal, nombre_vacuna) VALUES
    (10, 'rabia');

/*
Insercion de personas
 */


INSERT INTO responsable (id_responsable, nombre, domicilio) VALUE
    (1 ,'sergio', 'la paz 7 3ºc');

INSERT INTO responsable (id_responsable, nombre, domicilio) VALUE
    (2 ,'javier', 'la paz 7 3ºc');

INSERT INTO responsable (id_responsable, nombre, domicilio) VALUE
    (4,'fernando', 'la paz 7 3ºc');

INSERT INTO responsable (id_responsable, nombre, domicilio) VALUE
    (5, 'alberto', 'la paz 7 3ºc');

INSERT INTO responsable (id_responsable, nombre, domicilio) VALUE
    (6,'juan', 'la paz 7 3ºc');

INSERT INTO responsable (id_responsable, nombre, domicilio) VALUE
    (7,'mario', 'la paz 7 3ºc');

INSERT INTO responsable (id_responsable, nombre, domicilio) VALUE
    (8,'cristian', 'la paz 7 3ºc');

INSERT INTO responsable (id_responsable, nombre, domicilio) VALUE
    (9,'maria', 'la paz 7 3ºc');

INSERT INTO responsable (id_responsable, nombre, domicilio) VALUE
    (10,'silvia', 'la paz 7 3ºc');

INSERT INTO responsable (id_responsable, nombre, domicilio) VALUE
    (11,'jose', 'la paz 7 3ºc');

INSERT INTO responsable (id_responsable, nombre, domicilio) VALUE
    (12,'lucia', 'la paz 7 3ºc');

INSERT INTO responsable (id_responsable, nombre, domicilio) VALUE
    (13,'mariano', 'la paz 7 3ºc');

INSERT INTO responsable (id_responsable, nombre, domicilio) VALUE
    (14,'eutiquio', 'la paz 7 3ºc');

INSERT INTO responsable (id_responsable, nombre, domicilio) VALUE
    (15,'carlos', 'la paz 7 3ºc');

INSERT INTO persona (id_responsable, nif, apellidos, nacimiento, delitos, seguro_rc) VALUE
    (1, '07253620H', 'garcia prado', '1994-08-11', FALSE, '2020-10-02');

INSERT INTO persona (id_responsable, nif, apellidos, nacimiento, delitos, seguro_rc) VALUE
    (2, '72911354C', 'sánchez', '1990-08-11', FALSE, '2020-10-04');

INSERT INTO persona (id_responsable, nif, apellidos, nacimiento, delitos, seguro_rc) VALUE
    (4, '28504321F', 'lopez', '1992-08-11', FALSE , '2008-10-12');

INSERT INTO persona (id_responsable, nif, apellidos, nacimiento, delitos, seguro_rc) VALUE
    (5, '30446307B', 'fernandez', '1997-08-11', FALSE,'2020-10-21');

INSERT INTO persona (id_responsable, nif, apellidos, nacimiento, delitos, seguro_rc) VALUE
    (6, '42441622K', 'hoyos', '1986-08-11', FALSE, NULL);

INSERT INTO persona (id_responsable, nif, apellidos, nacimiento, delitos, seguro_rc) VALUE
    (7, '37241668E', 'romero', '1975-08-11', TRUE, NULL);

INSERT INTO persona (id_responsable, nif, apellidos, nacimiento, delitos, seguro_rc) VALUE
    (8, '76071821B', 'fernandez', '1954-08-11', FALSE, '2016-12-10');

INSERT INTO persona (id_responsable, nif, apellidos, nacimiento, delitos, seguro_rc) VALUE
    (9, '51469358G', 'ramirez', '200-08-11', FALSE, NULL);

INSERT INTO persona (id_responsable, nif, apellidos, nacimiento, delitos, seguro_rc) VALUE
    (10, '90307191Z', 'hernández', '1964-08-11', TRUE , '2020-10-16');

INSERT INTO persona (id_responsable, nif, apellidos, nacimiento, delitos, seguro_rc) VALUE
    (11, '84355907A', 'gutierrez', '1984-08-11', FALSE, NULL);

INSERT INTO persona (id_responsable, nif, apellidos, nacimiento, delitos, seguro_rc) VALUE
    (12, '51454171C', 'marcos', '1993-08-11', FALSE, NULL);

INSERT INTO persona (id_responsable, nif, apellidos, nacimiento, delitos, seguro_rc) VALUE
    (13, '03207026K', 'urbón', '1961-08-11', FALSE, NULL);

INSERT INTO persona (id_responsable, nif, apellidos, nacimiento, delitos, seguro_rc) VALUE
    (14, '89051216T', 'cabeza', '1955-08-11', TRUE, NULL);

INSERT INTO persona (id_responsable, nif, apellidos, nacimiento, delitos, seguro_rc) VALUE
    (15, '97400094Q', 'ceinos', '1967-08-11', FALSE, NULL);

/*
Insercion de organizaciones
 */


INSERT INTO responsable (id_responsable, nombre, domicilio) VALUE
    (3, 'fasa', 'la paz 7 3ºc');

INSERT INTO responsable (id_responsable, nombre, domicilio) VALUE
    (30, 'zoo el refugio', 'la paz 7 3ºc');

INSERT INTO responsable (id_responsable, nombre, domicilio) VALUE
    (31, 'circo del sol', 'la paz 7 3ºc');

INSERT INTO responsable (id_responsable, nombre, domicilio) VALUE
    (32, 'clinica mataperros', 'la paz 7 3ºc');

INSERT INTO responsable (id_responsable, nombre, domicilio) VALUE
    (33, 'clinica expanta cabras', 'la paz 7 3ºc');

INSERT INTO responsable (id_responsable, nombre, domicilio) VALUE
    (34, 'explotacion de vacuno ramirez', 'la paz 7 3ºc');


INSERT INTO organizacion (id_responsable, cif, tipo) VALUE
    (3, '423452352', 'explotacion');

INSERT INTO organizacion (id_responsable, cif, tipo) VALUE
    (30, '423452351', 'zoo');

INSERT INTO organizacion (id_responsable, cif, tipo) VALUE
    (31, '423452353', 'circo');

INSERT INTO organizacion (id_responsable, cif, tipo) VALUE
    (32, '423452354', 'clinica');

INSERT INTO organizacion (id_responsable, cif, tipo) VALUE
    (33, '423452355', 'clinica');

INSERT INTO organizacion (id_responsable, cif, tipo) VALUE
    (34, '423452356', 'explotacion');


/*
Insercion de licencias
 */


INSERT INTO licencia (id_responsable, nombre, num_licencia, inicio, fin) VALUE
    (1, 'perros_peligrosos', 1, '2007-10-01', '2027-10-01');

INSERT INTO licencia (id_responsable, nombre, num_licencia, inicio, fin) VALUE
    (2, 'perros_peligrosos', 2, '2007-10-01', '2027-10-01');

INSERT INTO licencia (id_responsable, nombre, num_licencia, inicio, fin) VALUE
    (3, 'perros_peligrosos', 3, '2007-10-01', '2027-10-01');

INSERT INTO licencia (id_responsable, nombre, num_licencia, inicio, fin) VALUE
    (4, 'perros_peligrosos', 4, '2007-10-01', '2027-10-01');

INSERT INTO licencia (id_responsable, nombre, num_licencia, inicio, fin) VALUE
    (5, 'perros_peligrosos', 5, '2007-10-01', '2027-10-01');

/*
Insercion de propiedades
 */


INSERT INTO propiedad (id_animal, id_responsable, inicio_propiedad, fin) VALUE
    (1, 2, '2010-12-21', NULL);

INSERT INTO propiedad (id_animal, id_responsable, inicio_propiedad, fin) VALUE
    (2, 2, '2010-12-21', NULL);

INSERT INTO propiedad (id_animal, id_responsable, inicio_propiedad, fin) VALUE
    (3, 2, '2010-12-21', '2012-12-21');

INSERT INTO propiedad (id_animal, id_responsable, inicio_propiedad, fin) VALUE
    (3, 1, '2012-12-21', '2013-12-21');

INSERT INTO propiedad (id_animal, id_responsable, inicio_propiedad, fin) VALUE
    (3, 2, '2013-12-21', NULL);

INSERT INTO propiedad (id_animal, id_responsable, inicio_propiedad, fin) VALUE
    (4, 2, '2010-12-21', NULL);


/*
Insercion de incidencias
 */

INSERT INTO incidencia (id_animal, inicio_propiedad, fecha, nombre, sancion, medida_cautelar, id_tenedor) VALUE
    (1, '2010-12-21', '2016-12-05', 'mordedura', 123, NULL, NULL);

INSERT INTO incidencia (id_animal, inicio_propiedad, fecha, nombre, sancion, medida_cautelar, id_tenedor) VALUE
    (1, '2010-12-21', '2016-12-05 11:22', 'robo', NULL, NULL, NULL);

INSERT INTO incidencia (id_animal, inicio_propiedad, fecha, nombre, sancion, medida_cautelar, id_tenedor) VALUE
    (1, '2010-12-21', '2016-12-06', 'robo', NULL, NULL, NULL);

INSERT INTO incidencia (id_animal, inicio_propiedad, fecha, nombre, sancion, medida_cautelar, id_tenedor) VALUE
    (2, '2010-12-21', '2016-12-07', 'perdida', NULL, NULL, NULL);

INSERT INTO incidencia (id_animal, inicio_propiedad, fecha, nombre, sancion, medida_cautelar, id_tenedor) VALUE
    (2, '2010-12-21', '2016-12-08', 'sin bozal', 123, NULL, NULL);

INSERT INTO incidencia (id_animal, inicio_propiedad, fecha, nombre, sancion, medida_cautelar, id_tenedor) VALUE
    (1, '2010-12-21', '2016-12-09', 'caca calle', 123, NULL, NULL);

INSERT INTO incidencia (id_animal, inicio_propiedad, fecha, nombre, sancion, medida_cautelar, id_tenedor) VALUE
    (1, '2010-12-21', '2016-12-15', 'robo', NULL, NULL, 2);

INSERT INTO incidencia (id_animal, inicio_propiedad, fecha, nombre, sancion, medida_cautelar, id_tenedor) VALUE
    (2, '2010-12-21', '2015-01-17', 'caca calle', 123, NULL, NULL);

INSERT INTO incidencia (id_animal, inicio_propiedad, fecha, nombre, sancion, medida_cautelar, id_tenedor) VALUE
    (2, '2010-12-21', '2015-02-18', 'caca calle', 79, NULL, NULL);

INSERT INTO incidencia (id_animal, inicio_propiedad, fecha, nombre, sancion, medida_cautelar, id_tenedor) VALUE
    (2, '2010-12-21', '2015-03-19', 'caca calle', 123, NULL, NULL);

INSERT INTO incidencia (id_animal, inicio_propiedad, fecha, nombre, sancion, medida_cautelar, id_tenedor) VALUE
    (2, '2010-12-21', '2015-04-20', 'caca calle', 43, NULL, NULL);

INSERT INTO incidencia (id_animal, inicio_propiedad, fecha, nombre, sancion, medida_cautelar, id_tenedor) VALUE
    (2, '2010-12-21', '2015-05-21', 'caca calle', 200, NULL, NULL);

INSERT INTO incidencia (id_animal, inicio_propiedad, fecha, nombre, sancion, medida_cautelar, id_tenedor) VALUE
    (1, '2010-12-21', '2015-06-22', 'caca calle', 233, NULL, NULL);

INSERT INTO incidencia (id_animal, inicio_propiedad, fecha, nombre, sancion, medida_cautelar, id_tenedor) VALUE
    (3, '2010-12-21', '2015-07-23', 'caca calle', 30, NULL, NULL);

INSERT INTO incidencia (id_animal, inicio_propiedad, fecha, nombre, sancion, medida_cautelar, id_tenedor) VALUE
    (3, '2010-12-21', '2015-08-24', 'caca calle', 1000, NULL, NULL);

INSERT INTO incidencia (id_animal, inicio_propiedad, fecha, nombre, sancion, medida_cautelar, id_tenedor) VALUE
    (3, '2010-12-21', '2015-09-25', 'caca calle', 756, NULL, NULL);

INSERT INTO incidencia (id_animal, inicio_propiedad, fecha, nombre, sancion, medida_cautelar, id_tenedor) VALUE
    (1, '2010-12-21', '2015-10-26', 'caca calle', 322, NULL, NULL);

INSERT INTO incidencia (id_animal, inicio_propiedad, fecha, nombre, sancion, medida_cautelar, id_tenedor) VALUE
    (3, '2010-12-21', '2015-11-27', 'caca calle', 129, NULL, NULL);

INSERT INTO incidencia (id_animal, inicio_propiedad, fecha, nombre, sancion, medida_cautelar, id_tenedor) VALUE
    (1, '2010-12-21', '2015-12-28', 'caca calle', 50, NULL, NULL);

INSERT INTO incidencia (id_animal, inicio_propiedad, fecha, nombre, sancion, medida_cautelar, id_tenedor) VALUE
    (1, '2010-12-21', '2015-12-29', 'caca calle', 43, NULL, NULL);

INSERT INTO incidencia (id_animal, inicio_propiedad, fecha, nombre, sancion, medida_cautelar, id_tenedor) VALUE
    (1, '2010-12-21', '2015-12-30', 'caca calle', 64, NULL, NULL);

INSERT INTO incidencia (id_animal, inicio_propiedad, fecha, nombre, sancion, medida_cautelar, id_tenedor) VALUE
    (1, '2010-12-21', '2015-12-31', 'caca calle', 139, NULL, NULL);


/*
CONSULTAS
*/

/*
Consulta 1: Todos los propietarios que han tenido al menos una propiedad incluyendo la cuenta de las mismas
 */

SELECT
    Res.id_responsable as id,
    Res.nombre,
    COUNT(*) as cuenta
FROM
    responsable Res,
    propiedad Pr
WHERE
    Res.id_responsable = Pr.id_responsable
GROUP BY res.id_responsable
ORDER BY COUNT(*) DESC;

/*
Consulta 2: Ficha de registro de los animales censados que han nacido en 2005
 */
SELECT *
FROM view_ficha_censo censo
WHERE censo.nacimiento = 2005;

/*
Consulta 3: Ranking de especies de animales censados mas veces vacunados
 */
SELECT
    a.especie,
    COUNT(*) AS nro_vacunas
FROM
    animal a
    NATURAL JOIN vacuna
GROUP BY
    a.especie
HAVING COUNT(*) > 1
ORDER BY nro_vacunas DESC;

/*
Consulta 4: 5 infracciones mas comunes
 */
SELECT *
FROM (
         SELECT
             i.nombre,
             COUNT(*) AS nro_infracciones
         FROM
             view_infraccion i
         GROUP BY i.nombre
     ) AS NI
WHERE 5 > (
    SELECT COUNT(*)
    FROM (
             SELECT
                 i.nombre,
                 COUNT(*) AS nro_infracciones
             FROM
                 view_infraccion i
             GROUP BY i.nombre)
        AS NI2
    WHERE NI2.nro_infracciones > NI.nro_infracciones
);

/*
Consulta 5: El numero de responsables que ha tenido cada animal
 */
SELECT
    p.id_animal,
    COUNT(*)
FROM
    (
        SELECT pr.id_animal
        FROM
            propiedad pr
        GROUP BY
            pr.id_animal,
            pr.id_responsable
    ) AS p
GROUP BY
    p.id_animal;

/*
Consulta 6: Numero medio de vacunas que se han suministrado a cada animal agrupados por especie
 */

SELECT
    a.especie,
    ava.nro_vacunas / a.nro_ejemplares AS nro_medio_vacunas
FROM (
         SELECT
             a.especie,
             COUNT(*) AS nro_ejemplares
         FROM
             animal a
         GROUP BY
             a.especie
     ) AS a,
    (
        SELECT
            a.especie,
            COUNT(*) AS nro_vacunas
        FROM
            (
                SELECT *
                FROM animal
                    NATURAL JOIN vacuna
            ) AS a
        GROUP BY
            a.especie
    ) AS ava
WHERE a.especie = ava.especie;

/*
Consulta 7: Todas las vacunas que ha puesto una persona (javier) a sus animales
 */

SELECT a.id_animal,
    v.nombre_vacuna,
    v.aplicacion
FROM view_persona vp,
    propiedad pr,
    animal a,
    vacuna v
WHERE
    vp.id_responsable = Pr.id_responsable AND
    Pr.id_animal = a.id_animal AND
    a.id_animal = v.id_animal AND
    vp.nombre = 'javier';

/*
Consulta 8: Listado de vacunas suministradas en un periodo concreto de tiempo
 */

SELECT DISTINCT
    a.id_animal,
    a.aplicacion
FROM
    (
        SELECT *
        FROM animal
            NATURAL JOIN vacuna
    ) AS a
WHERE
    a.aplicacion >= '2016-01-01' AND
    a.aplicacion <= '2016-12-21';

/*
Consulta 9: El listado de infracciones en las que ha participado cada persona
 */

SELECT
    vp.nombre,
    vp.apellidos,
    i.fecha,
    i.nombre,
    i.sancion,
    i.medida_cautelar,
    i.tipo_sancion
FROM
    view_persona vp,
    propiedad p,
    view_infraccion i
WHERE
    vp.id_responsable = i.id_tenedor OR
    (
        vp.id_responsable = p.id_responsable AND
        p.id_animal = i.id_animal AND
        p.inicio_propiedad = i.inicio_propiedad
    )
ORDER BY i.fecha DESC;

/*
Consulta 10: Ranking de los tipos de animal censado que mas se pierden agrupados por capa
 */

SELECT
    ac.capa,
    COUNT(*) as nro_perdidas
FROM
    view_animal_censado ac,
    view_perdida i
WHERE i.id_animal = ac.id_animal
GROUP BY ac.capa;

/*
Consulta 11: Nombres de perro mas comunes ordenados
 */

SELECT
    ac.nombre,
    COUNT(*) AS cuenta
FROM
    view_animal_censado ac
WHERE ac.especie = 'perro'
GROUP BY ac.nombre
ORDER BY COUNT(*) DESC;

/*
Consulta 12: Animales que han cambiado de responsable pero luego han tenido otra vez el mismo
 */

SELECT DISTINCT
    p1.id_animal,
    p1.id_responsable
FROM
    propiedad p1,
    propiedad p2
WHERE
    p1.id_animal = p2.id_animal AND
    p1.inicio_propiedad <> p2.inicio_propiedad AND
    p1.id_responsable = p2.id_responsable;

