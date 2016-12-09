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