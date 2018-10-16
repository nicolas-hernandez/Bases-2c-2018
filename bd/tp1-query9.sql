SELECT distinct sh.id_sh, sh.nombre, sh.color_capa
FROM tp1.incidente i
JOIN tp1.super_participo sp ON i.id_incidente = sp.id_incidente
JOIN tp1.superheroe sh ON sp.id_sh = sh.id_sh;
