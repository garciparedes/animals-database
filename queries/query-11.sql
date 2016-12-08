SELECT
    ac.nombre,
    COUNT(*) AS cuenta
FROM
    view_animal_censado ac
WHERE ac.especie = 'perro'
GROUP BY ac.nombre
ORDER BY COUNT(*) DESC;