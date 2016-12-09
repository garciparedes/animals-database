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