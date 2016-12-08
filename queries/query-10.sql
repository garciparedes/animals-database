SELECT
    ac.capa,
    COUNT(*) as nro_perdidas
FROM
    view_animal_censado ac,
    view_perdida i
WHERE i.id_animal = ac.id_animal
GROUP BY ac.capa;