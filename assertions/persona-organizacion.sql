CREATE ASSERTION persona_organizacion_unique
CHECK((SELECT COUNT(*)
        FROM  Persona P, Organizacion O
        WHERE P.id_responsable = O.id_responsable) = 0);