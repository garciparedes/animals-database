SELECT
    a.especie,
    COUNT(*) AS nro_vacunas
FROM
    animal a
    NATURAL JOIN vacuna
GROUP BY
    a.especie
ORDER BY nro_vacunas DESC;