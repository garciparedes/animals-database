CREATE OR REPLACE VIEW view_ficha_censo
AS
    SELECT
        a.especie,
        a.raza,
        a.aptitud,
        a.peligroso,
        a.nacimiento,
        a.domicilio   AS domicilio_animal,
        per.nombre,
        per.apellidos,
        per.nif,
        per.domicilio AS domicilio_dueño,
        a.id_censal,
        a.id_chip
    FROM
        view_animal_censado a,
        propiedad p,
        view_persona per
    WHERE
        per.id_responsable = p.id_responsable AND
        p.id_animal = a.id_animal