CREATE OR REPLACE VIEW view_animal_potencialmente_peligroso
AS
    SELECT *
    FROM
        animal a NATURAL JOIN animal_censado
    WHERE a.peligroso = TRUE;


