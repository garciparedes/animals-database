/*
Consulta 2: Ficha de registro de los animales censados que han nacido en 2005
 */
SELECT *
FROM view_ficha_censo censo
WHERE censo.nacimiento = 2005;