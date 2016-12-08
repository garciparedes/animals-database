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