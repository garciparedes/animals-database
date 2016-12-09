CREATE OR REPLACE VIEW view_robo
AS
    SELECT
        i.id_animal,
        i.inicio_propiedad,
        i.id_tenedor,
        i.fecha
    FROM incidencia i
    WHERE i.nombre = 'robo';