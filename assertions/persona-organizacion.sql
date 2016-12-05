CREATE ASSERTION persona_organizacion_unique
CHECK((SELECT COUNT(*)
        FROM  persona p, organizacion o
        WHERE p.id_responsable = o.id_responsable) = 0);