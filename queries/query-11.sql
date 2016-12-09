/*
Consulta 11: Nombres de perro mas comunes ordenados
 */

SELECT
    ac.nombre,
    COUNT(*) AS cuenta
FROM
    view_animal_censado ac
WHERE ac.especie = 'perro'
GROUP BY ac.nombre
ORDER BY COUNT(*) DESC;