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
    incidencia i
WHERE
    (
        (
            vp.id_responsable = p.id_responsable AND
            p.id_animal = i.id_animal AND
            p.inicio_propiedad = i.inicio_propiedad
        ) OR
        vp.id_responsable = i.id_tenedor
    ) AND i.tipo = 'infraccion'
ORDER BY i.fecha DESC