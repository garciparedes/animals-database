/*
Vista de fichas del censo
 */
CREATE OR REPLACE VIEW view_ficha_censo
AS
    SELECT
        a.especie,
        a.raza,
        a.aptitud,
        a.peligroso,
        extract(YEAR FROM a.nacimiento) as nacimiento,
        a.domicilio   AS domicilio_animal,
        per.nombre,
        per.apellidos,
        per.nif,
        per.domicilio AS domicilio_responsable,
        lic.num_licencia,
        a.id_censal,
        a.id_chip
    FROM
        view_animal_censado a,
        propiedad p,
        view_persona per LEFT JOIN (
        SELECT
            per.id_responsable,
            l1.num_licencia
        FROM
            view_persona per,
            licencia l1,
            licencia l2
        WHERE
            l1.id_responsable = per.id_responsable AND
            l2.id_responsable = per.id_responsable AND
            l1.inicio > l2.inicio
        ) as lic on per.id_responsable = lic.id_responsable
    WHERE
        per.id_responsable = p.id_responsable AND
        p.id_animal = a.id_animal;
