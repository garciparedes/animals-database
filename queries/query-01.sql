SELECT
    Res.id_responsable as id,
    Res.nombre,
    COUNT(*) as cuenta
FROM
    responsable Res,
    propiedad Pr
WHERE
    Res.id_responsable = Pr.id_responsable
GROUP BY res.id_responsable
ORDER BY COUNT(*) DESC;