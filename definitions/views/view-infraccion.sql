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