/*
Vista de animal potencialmente peligroso
 */
CREATE OR REPLACE VIEW view_animal_potencialmente_peligroso
AS
    SELECT *
    FROM
        view_animal_censado a
    WHERE a.peligroso = TRUE;


