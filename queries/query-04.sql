SELECT *
FROM (
         SELECT
             i.nombre,
             COUNT(*) AS nInc
         FROM
             Incidencia i
         WHERE i.tipo = 'infraccion'
         GROUP BY i.nombre
     ) AS NI
WHERE 5 > (SELECT COUNT(*)
           FROM (
                    SELECT
                        i.nombre,
                        COUNT(*) AS nInc
                    FROM
                        Incidencia i
                    WHERE i.tipo = 'infraccion'
                    GROUP BY i.nombre)
               AS NI2
           WHERE NI2.nInc > NI.nInc);