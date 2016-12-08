SELECT
    p.id_animal,
    COUNT(*)
FROM
    (
        SELECT pr.id_animal
        FROM
            propiedad pr
        GROUP BY
            pr.id_animal,
            pr.id_responsable
    ) AS p
GROUP BY
    p.id_animal;