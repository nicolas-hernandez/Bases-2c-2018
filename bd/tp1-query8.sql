SELECT sh.id_sh, sh.nombre, sh.color_capa
FROM tp1.superheroe sh, tp1.posee p, tp1.habilidad h
WHERE sh.id_sh = p.id_sh and p.id_habilidad = h.id_habilidad and h.id_habilidad = 5;