SELECT distinct civil.dni as dniCivil,
				civil.nombre as nombreCivil,
				civil.apellido as apellidoCivil,
				binc.nombre as nombreBarrio
FROM tp1."Incidente" i 
JOIN tp1."SeInvolucraron" si ON i."idIncidente" = si."idIncidente"
JOIN tp1."Direccion" dinc ON i."idDireccion" = dinc."idDireccion"
JOIN tp1."Barrio" binc ON dinc."idBarrio" = binc."idBarrio" 
JOIN tp1."Civil" civil ON si.dni = civil.dni
JOIN
	(SELECT  c.dni, b."idBarrio", b.nombre
	FROM tp1."Civil" c, tp1."ViveEn" ve, tp1."Direccion" d, tp1."Barrio" b
	WHERE c.dni = ve.dni and ve."idDireccion" = d."idDireccion" and d."idBarrio" = b."idBarrio"
	and ve."fechaInicio" = 
	(SELECT max(ve1."fechaInicio")
	FROM tp1."Civil" civ, tp1."ViveEn" ve1, tp1."Direccion" d1, tp1."Barrio" b1
	WHERE civ.dni = ve1.dni and civ.dni = c.dni and ve1."idDireccion" = d1."idDireccion" and d1."idBarrio" = b1."idBarrio"
	GROUP BY civ.dni) ) civil_barrio
ON civil.dni = civil_barrio.dni
WHERE binc."idBarrio" = civil_barrio."idBarrio";
