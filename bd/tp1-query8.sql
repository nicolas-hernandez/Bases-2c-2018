SELECT sh.id_sh, sh.nombre, sh.color_capa
FROM tp1.superheroe sh 
JOIN tp1.posee p ON sh.id_sh = p.id_sh
JOIN tp1.habilidad h ON p.id_habilidad = h.id_habilidad
WHERE h.id_habilidad = 5;
