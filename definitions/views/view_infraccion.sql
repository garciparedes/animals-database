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