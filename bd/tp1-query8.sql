SELECT sh."idSuperHeroe", sh.nombre, sh.color_capa
FROM tp1.superheroe sh 
JOIN tp1.posee p ON sh."idSuperHeroe" = p."idSuperHeroe"
JOIN tp1.habilidad h ON p."idHabilidad" = h."idHabilidad"
WHERE h."idHabilidad" = 5;
