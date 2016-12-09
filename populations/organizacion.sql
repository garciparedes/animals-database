/*
Insercion de organizaciones
 */


INSERT INTO responsable (id_responsable, nombre, domicilio) VALUE
    (3, 'fasa', 'la paz 7 3ºc');

INSERT INTO responsable (id_responsable, nombre, domicilio) VALUE
    (30, 'zoo el refugio', 'la paz 7 3ºc');

INSERT INTO responsable (id_responsable, nombre, domicilio) VALUE
    (31, 'circo del sol', 'la paz 7 3ºc');

INSERT INTO responsable (id_responsable, nombre, domicilio) VALUE
    (32, 'clinica mataperros', 'la paz 7 3ºc');

INSERT INTO responsable (id_responsable, nombre, domicilio) VALUE
    (33, 'clinica expanta cabras', 'la paz 7 3ºc');

INSERT INTO responsable (id_responsable, nombre, domicilio) VALUE
    (34, 'explotacion de vacuno ramirez', 'la paz 7 3ºc');


INSERT INTO organizacion (id_responsable, cif, tipo) VALUE
    (3, '423452352', 'explotacion');

INSERT INTO organizacion (id_responsable, cif, tipo) VALUE
    (30, '423452351', 'zoo');

INSERT INTO organizacion (id_responsable, cif, tipo) VALUE
    (31, '423452353', 'circo');

INSERT INTO organizacion (id_responsable, cif, tipo) VALUE
    (32, '423452354', 'clinica');

INSERT INTO organizacion (id_responsable, cif, tipo) VALUE
    (33, '423452355', 'clinica');

INSERT INTO organizacion (id_responsable, cif, tipo) VALUE
    (34, '423452356', 'explotacion');
