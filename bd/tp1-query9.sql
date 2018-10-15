SELECT distinct sh.id_sh, sh.nombre, sh.color_capa
FROM tp1.incidente i, tp1.super_participo sp, tp1.superheroe sh
WHERE i.id_incidente = sp.id_incidente and sp.id_sh = sh.id_sh;