/*
Vista de animal censado
 */
CREATE OR REPLACE VIEW view_animal_censado
AS
    SELECT *
    FROM
        animal
        NATURAL JOIN animal_censado;


