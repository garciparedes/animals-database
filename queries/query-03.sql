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