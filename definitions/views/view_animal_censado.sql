CREATE VIEW view_animal_censado
AS
    SELECT *
    FROM
        animal
        NATURAL JOIN animal_censado;


