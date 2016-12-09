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