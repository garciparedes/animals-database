SELECT DISTINCT
    p1.id_animal,
    p1.id_responsable
FROM
    propiedad p1,
    propiedad p2
WHERE
    p1.id_animal = p2.id_animal AND
    p1.inicio_propiedad <> p2.inicio_propiedad AND
    p1.id_responsable = p2.id_responsable;