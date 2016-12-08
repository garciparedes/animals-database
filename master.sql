
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


CREATE TABLE organizacion (

    id_responsable INTEGER     NOT NULL,

    cif            VARCHAR(20) NOT NULL,
    tipo           VARCHAR(50) NOT NULL,

    CONSTRAINT organizacion__clave
    PRIMARY KEY (id_responsable, cif),


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
    REFERENCES responsable (id_responsable)

    /*
    CONSTRAINT licencia_perros_peligrosos
    CHECK (
        CASE WHEN nombre = 'perros_peligrosos'
            THEN
                CURRENT_TIMESTAMP - YEAR(18) <= (
                    SELECT v.nacimiento
                    FROM view_persona v
                    WHERE
                        v.id_responsable = id_responsable AND
                        v.delitos = TRUE AND
                        v.seguro_rc >= CURRENT_TIMESTAMP
                )
        END
    )
    */
);


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
     /*
     ,


    CONSTRAINT propiedad__overlapping
    CHECK (
        NOT exists(
            SELECT *
            FROM propiedad p
            WHERE
                p.id_animal = id_animal AND
                (
                    (
                        p.inicio_propiedad >= inicio_propiedad AND
                        p.fin <= inicio_propiedad
                    ) OR
                    (
                        p.inicio_propiedad >= fin AND
                        p.fin <= fin
                    )
                )

        )

    )
    */
);

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
    tipo             VARCHAR(50) NOT NULL,
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
    CHECK (sancion >= 0),


    CONSTRAINT incidencia__tipos
    CHECK (
        tipo IN ('denuncia', 'robo', 'perdida')
    )
);


/*
DEFINICION DE VISTAS
*/

CREATE OR REPLACE VIEW view_animal_censado
AS
    SELECT *
    FROM
        animal
        NATURAL JOIN animal_censado;




CREATE OR REPLACE VIEW view_organizacion
AS
    SELECT
        *
    FROM
        responsable
        NATURAL JOIN organizacion;




CREATE OR REPLACE VIEW view_persona
AS
    SELECT *
    FROM
        responsable
        NATURAL JOIN persona;




CREATE OR REPLACE VIEW view_infraccion
AS
    SELECT
        i.id_animal,
        i.inicio_propiedad,
        i.id_tenedor,
        i.nombre,
        i.fecha,
        i.sancion,
        i.medida_cautelar
    FROM incidencia i
    WHERE i.tipo = 'infraccion';

CREATE OR REPLACE VIEW view_perdida
AS
    SELECT
        i.id_animal,
        i.inicio_propiedad,
        i.id_tenedor,
        i.nombre,
        i.fecha
    FROM incidencia i
    WHERE i.tipo = 'perdida';

CREATE OR REPLACE VIEW view_robo
AS
    SELECT
        i.id_animal,
        i.inicio_propiedad,
        i.id_tenedor,
        i.nombre,
        i.fecha
    FROM incidencia i
    WHERE i.tipo = 'robo';

CREATE OR REPLACE VIEW view_animal_potencialmente_peligroso
AS
    SELECT *
    FROM
        animal a NATURAL JOIN animal_censado
    WHERE a.peligroso = TRUE;




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
            per.id_responsable,
            l1.num_licencia
        FROM
            view_persona per,
            licencia l1,
            licencia l2
        WHERE
            l1.id_responsable = per.id_responsable AND
            l2.id_responsable = per.id_responsable AND
            l1.inicio > l2.inicio
        ) as lic on per.id_responsable = lic.id_responsable
    WHERE
        per.id_responsable = p.id_responsable AND
        p.id_animal = a.id_animal;



/*
POBLACION DE TABLAS
*/

INSERT INTO animal (id_animal, especie, raza, de_compañia, peligroso, exotico, extranjero) VALUES
    (7,     'vaca',     'Cattle',   FALSE,  FALSE,  FALSE,  FALSE),
    (8,     'vaca',     'Cattle',   FALSE,  FALSE,  FALSE,  FALSE),
    (9,     'cabra',    'boer',     FALSE,  TRUE,   FALSE,  FALSE);


INSERT INTO animal (id_animal, especie, raza, de_compañia, peligroso, exotico, extranjero) VALUES
    (1,     'perro',    'alano',    TRUE,   TRUE,   FALSE,  TRUE),
    (2,     'perro',    'alano',    TRUE,   TRUE,   FALSE,  FALSE),
    (3,     'gato',     'persa',    TRUE,   FALSE,  TRUE,   TRUE),
    (4,     'gato',     'alano',    TRUE,   FALSE,  FALSE,  FALSE),
    (5,     'gato',     'siamese',  TRUE,   FALSE,  FALSE,  TRUE),
    (6,     'perro',    'alano',    TRUE,   TRUE,   FALSE,  FALSE),
    (10,    'perro',    'mastin',   TRUE,   TRUE,   FALSE,  FALSE);


INSERT INTO animal_censado (id_animal, nombre, aptitud, capa, domicilio, id_chip, id_censal, lazarillo, nacimiento)
VALUES
    (1, 'paco', 'tranquilo', 'blanco', 'la rua', '1234', '1', FALSE, '2005-11-10'),
    (2, 'calcetines', 'tranquilo', 'blanco', 'la rua', '12342', '2', FALSE, '2005-11-10'),
    (3, 'charly', 'tranquilo', 'blanco', 'la rua', '12343', '3', FALSE, '2005-11-10'),
    (4, 'toby', 'tranquilo', 'blanco', 'la rua', '12345', '4', FALSE, '2005-11-10'),
    (5, 'toby', 'tranquilo', 'blanco', 'la rua', '12346', '5', FALSE, '2005-11-10'),
    (6, 'manchas', 'tranquilo', 'blanco', 'la rua', '12347', '6', FALSE, '2005-11-10'),
    (10, 'misifu', 'tranquilo', 'blanco', 'la rua', '12348', '7', FALSE, '2005-11-10');


INSERT INTO vacuna (id_animal, nombre_vacuna) VALUES
    (1, 'rabia'),
    (2, 'rabia'),
    (3, 'rabia'),
    (4, 'rabia'),
    (5, 'rabia'),
    (6, 'rabia'),
    (7, 'rabia'),
    (8, 'rabia'),
    (9, 'rabia'),
    (10, 'rabia');

INSERT INTO responsable (id_responsable, nombre, domicilio) VALUES
    (1 ,'sergio', 'la paz 7 3ºc'),
    (2 ,'javier', 'la paz 7 3ºc'),
    (4,'fernando', 'la paz 7 3ºc'),
    (5, 'alberto', 'la paz 7 3ºc'),
    (6,'juan', 'la paz 7 3ºc'),
    (7,'mario', 'la paz 7 3ºc'),
    (8,'cristian', 'la paz 7 3ºc'),
    (9,'maria', 'la paz 7 3ºc'),
    (10,'silvia', 'la paz 7 3ºc'),
    (11,'jose', 'la paz 7 3ºc'),
    (12,'lucia', 'la paz 7 3ºc'),
    (13,'mariano', 'la paz 7 3ºc'),
    (14,'eutiquio', 'la paz 7 3ºc'),
    (15,'carlos', 'la paz 7 3ºc');

INSERT INTO persona (id_responsable, nif, apellidos, nacimiento, delitos, seguro_rc) VALUES
    (1, '07253620H', 'garcia prado', '1994-08-11', FALSE, '2020-10-02'),
    (2, '72911354C', 'sánchez', '1990-08-11', FALSE, '2020-10-04'),
    (4, '28504321F', 'lopez', '1992-08-11', FALSE , '2008-10-12'),
    (5, '30446307B', 'fernandez', '1997-08-11', FALSE,'2020-10-21'),
    (6, '42441622K', 'hoyos', '1986-08-11', FALSE, NULL),
    (7, '37241668E', 'romero', '1975-08-11', TRUE, NULL),
    (8, '76071821B', 'fernandez', '1954-08-11', FALSE, '2016-12-10'),
    (9, '51469358G', 'ramirez', '200-08-11', FALSE, NULL),
    (10, '90307191Z', 'hernández', '1964-08-11', TRUE , '2020-10-16'),
    (11, '84355907A', 'gutierrez', '1984-08-11', FALSE, NULL),
    (12, '51454171C', 'marcos', '1993-08-11', FALSE, NULL),
    (13, '03207026K', 'urbón', '1961-08-11', FALSE, NULL),
    (14, '89051216T', 'cabeza', '1955-08-11', TRUE, NULL),
    (15, '97400094Q', 'ceinos', '1967-08-11', FALSE, NULL);

INSERT INTO responsable (id_responsable, nombre, domicilio) VALUES
    (3, 'fasa', 'la paz 7 3ºc'),
    (30, 'zoo el refugio', 'la paz 7 3ºc'),
    (31, 'circo del sol', 'la paz 7 3ºc'),
    (32, 'clinica mataperros', 'la paz 7 3ºc'),
    (33, 'clinica expanta cabras', 'la paz 7 3ºc'),
    (34, 'explotacion de vacuno ramirez', 'la paz 7 3ºc');


INSERT INTO organizacion (id_responsable, cif, tipo) VALUES
    (3, '423452352', 'explotacion'),
    (30, '423452351', 'zoo'),
    (31, '423452353', 'circo'),
    (32, '423452354', 'clinica'),
    (33, '423452355', 'clinica'),
    (34, '423452356', 'explotacion');


INSERT INTO licencia (id_responsable, nombre, num_licencia, inicio, fin) VALUES
    (1, 'perros_peligrosos', 1, '2007-10-01', '2027-10-01'),
    (2, 'perros_peligrosos', 2, '2007-10-01', '2027-10-01'),
    (3, 'perros_peligrosos', 3, '2007-10-01', '2027-10-01'),
    (4, 'perros_peligrosos', 4, '2007-10-01', '2027-10-01'),
    (5, 'perros_peligrosos', 5, '2007-10-01', '2027-10-01');

INSERT INTO propiedad (id_animal, id_responsable, inicio_propiedad, fin) VALUES
    (1, 2, '2010-12-21', NULL),
    (2, 2, '2010-12-21', NULL),
    (3, 2, '2010-12-21', '2012-12-21'),
    (3, 1, '2012-12-21', '2013-12-21'),
    (3, 2, '2013-12-21', NULL),
    (4, 2, '2010-12-21', NULL);


INSERT INTO incidencia (id_animal, inicio_propiedad, fecha, nombre, tipo, sancion, medida_cautelar, id_tenedor) VALUES
    (1, '2010-12-21', '2016-12-05', 'mordedura', 'infraccion', 123, NULL, NULL),
    (1, '2010-12-21', '2016-12-05 11:22', NULL, 'robo', NULL, NULL, NULL),
    (1, '2010-12-21', '2016-12-06', NULL, 'robo', NULL, NULL, NULL),
    (2, '2010-12-21', '2016-12-07', NULL, 'perdida', NULL, NULL, NULL),
    (2, '2010-12-21', '2016-12-08', 'sin bozal', 'infraccion', 123, NULL, NULL),
    (1, '2010-12-21', '2016-12-09', 'caca calle', 'infraccion', 123, NULL, NULL),
    (1, '2010-12-21', '2016-12-15', NULL, 'robo', NULL, NULL, 2),
    (2, '2010-12-21', '2015-01-17', 'caca calle', 'infraccion', 123, NULL, NULL),
    (2, '2010-12-21', '2015-02-18', 'caca calle', 'infraccion', 79, NULL, NULL),
    (2, '2010-12-21', '2015-03-19', 'caca calle', 'infraccion', 123, NULL, NULL),
    (2, '2010-12-21', '2015-04-20', 'caca calle', 'infraccion', 43, NULL, NULL),
    (2, '2010-12-21', '2015-05-21', 'caca calle', 'infraccion', 200, NULL, NULL),
    (1, '2010-12-21', '2015-06-22', 'caca calle', 'infraccion', 233, NULL, NULL),
    (3, '2010-12-21', '2015-07-23', 'caca calle', 'infraccion', 30, NULL, NULL),
    (3, '2010-12-21', '2015-08-24', 'caca calle', 'infraccion', 1000, NULL, NULL),
    (3, '2010-12-21', '2015-09-25', 'caca calle', 'infraccion', 756, NULL, NULL),
    (1, '2010-12-21', '2015-10-26', 'caca calle', 'infraccion', 322, NULL, NULL),
    (3, '2010-12-21', '2015-11-27', 'caca calle', 'infraccion', 129, NULL, NULL),
    (1, '2010-12-21', '2015-12-28', 'caca calle', 'infraccion', 50, NULL, NULL),
    (1, '2010-12-21', '2015-12-29', 'caca calle', 'infraccion', 43, NULL, NULL),
    (1, '2010-12-21', '2015-12-30', 'caca calle', 'infraccion', 64, NULL, NULL),
    (1, '2010-12-21', '2015-12-31', 'caca calle', 'infraccion', 139, NULL, NULL);


/*
CONSULTAS
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

SELECT *
FROM view_ficha_censo censo
WHERE censo.nacimiento = 2005;

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
ORDER BY nro_vacunas DESC;

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

SELECT DISTINCT
    a.id_animal
FROM
    (
        SELECT *
        FROM animal
            NATURAL JOIN vacuna
    ) AS a
WHERE
    a.aplicacion >= '2016-01-01' AND
    a.aplicacion <= '2016-12-21';

SELECT
    vp.nombre,
    vp.apellidos,
    i.fecha,
    i.nombre,
    i.sancion,
    i.medida_cautelar
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

SELECT
    ac.capa,
    COUNT(*) as nro_perdidas
FROM
    view_animal_censado ac,
    view_perdida i
WHERE i.id_animal = ac.id_animal
GROUP BY ac.capa;

SELECT
    ac.nombre,
    COUNT(*) AS cuenta
FROM
    view_animal_censado ac
WHERE ac.especie = 'perro'
GROUP BY ac.nombre
ORDER BY COUNT(*) DESC;

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

