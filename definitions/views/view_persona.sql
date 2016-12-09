/*
Vista de persona
 */
CREATE OR REPLACE VIEW view_persona
AS
    SELECT *
    FROM
        responsable
        NATURAL JOIN persona;


