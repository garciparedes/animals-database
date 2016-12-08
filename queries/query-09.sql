SELECT
    vp.nombre,
    vp.apellidos,
    i.fecha,
    i.nombre,
    i.sancion,
    i.medida_cautelar
FROM
    view_persona vp,
    propiedad p,
    view_infraccion i
WHERE
    vp.id_responsable = i.id_tenedor OR
    (
        vp.id_responsable = p.id_responsable AND
        p.id_animal = i.id_animal AND
        p.inicio_propiedad = i.inicio_propiedad
    )
ORDER BY i.fecha DESC