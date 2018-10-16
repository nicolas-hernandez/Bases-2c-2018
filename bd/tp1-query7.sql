SELECT distinct civil.dni, civil.nombre, civil.apellido, binc.nombre
FROM tp1.incidente i 
JOIN tp1.se_involucraron si ON i.id_incidente = si.id_incidente
JOIN tp1.direccion dinc ON i.id_direccion = dinc.id_direccion
JOIN tp1.barrio binc ON dinc.id_barrio = binc.id_barrio 
JOIN tp1.civil civil ON si.dni = civil.dni
JOIN
	(SELECT  c.dni, b.id_barrio, b.nombre
	FROM tp1.civil c, tp1.vive_en ve, tp1.direccion d, tp1.barrio b
	WHERE c.dni = ve.dni and ve.id_direccion = d.id_direccion and d.id_barrio = b.id_barrio
	and ve.fecha_inicio = 
	(SELECT max(ve1.fecha_inicio)
	FROM tp1.civil civ, tp1.vive_en ve1, tp1.direccion d1, tp1.barrio b1
	WHERE civ.dni = ve1.dni and civ.dni = c.dni and ve1.id_direccion = d1.id_direccion and d1.id_barrio = b1.id_barrio
	GROUP BY civ.dni) ) civil_barrio
ON civil.dni = civil_barrio.dni
WHERE binc.id_barrio = civil_barrio.id_barrio;
