/*
Consulta 7: Todas las vacunas que ha puesto una persona (javier) a sus animales
 */

SELECT a.id_animal,
    v.nombre_vacuna,
    v.aplicacion
FROM view_persona vp,
    propiedad pr,
    animal a,
    vacuna v
WHERE
    vp.id_responsable = Pr.id_responsable AND
    Pr.id_animal = a.id_animal AND
    a.id_animal = v.id_animal AND
    vp.nombre = 'javier';