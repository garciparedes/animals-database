CREATE VIEW view_organizacion
AS
    SELECT
        *
    FROM
        responsable
        NATURAL JOIN organizacion;


