SELECT sh."idSuperHeroe",
	   sh.nombre,
	   sh.color_disfraz,
FROM tp1."Superheroe" sh
JOIN tp1."Posee" p ON sh."idSuperHeroe" = p."idSuperHeroe"
JOIN tp1."Habilidad" h ON p."idHabilidad" = h."idHabilidad"
WHERE h."idHabilidad" = 5;
