SELECT distinct civil.dni, civil.nombre, civil.apellido, binc.nombre
FROM tp1.incidente i 
JOIN tp1.se_involucraron si ON i."idIncidente" = si."idIncidente"
JOIN tp1.direccion dinc ON i."idDireccion" = dinc."idDireccion"
JOIN tp1.barrio binc ON dinc."idBarrio" = binc."idBarrio" 
JOIN tp1.civil civil ON si.dni = civil.dni
JOIN
	(SELECT  c.dni, b."idBarrio", b.nombre
	FROM tp1.civil c, tp1.vive_en ve, tp1.direccion d, tp1.barrio b
	WHERE c.dni = ve.dni and ve."idDireccion" = d."idDireccion" and d."idBarrio" = b."idBarrio"
	and ve."fechaInicio" = 
	(SELECT max(ve1."fechaInicio")
	FROM tp1.civil civ, tp1.vive_en ve1, tp1.direccion d1, tp1.barrio b1
	WHERE civ.dni = ve1.dni and civ.dni = c.dni and ve1."idDireccion" = d1."idDireccion" and d1."idBarrio" = b1."idBarrio"
	GROUP BY civ.dni) ) civil_barrio
ON civil.dni = civil_barrio.dni
WHERE binc."idBarrio" = civil_barrio."idBarrio";
