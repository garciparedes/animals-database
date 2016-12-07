CREATE ASSERTION persona_organizacion_unique
CHECK(
    (
        SELECT COUNT(*)
            FROM
                responsable r
                persona p,
                organizacion o
            WHERE
                r.id_responsable = p.id_responsable OR
                r.id_responsable = o.id_responsable
    ) = 1
);
