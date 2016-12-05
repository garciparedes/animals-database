CREATE VIEW view_persona
AS
    SELECT *
    FROM
        responsable
        NATURAL JOIN persona;


