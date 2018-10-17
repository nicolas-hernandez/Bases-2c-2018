SELECT i."idIncidente" as "idIncidente",
	   i.fecha,
	   i.calle_1 as calle_1,
	   i.calle_2 as calle_2,
		'Oficial' as tipo,
        o.placa as "placaOficial",
		o.dni as dni,
		o.nombre as nombre,
		o.apellido as apellido,
		ro.descripcion as "rol"
FROM tp1."Incidente" i
JOIN tp1."OficialSeInvolucro" osi ON i."idIncidente" = osi."idIncidente"
JOIN tp1."Oficial" o ON osi.placa = o.placa
JOIN tp1."RolOficial" ro ON osi."idResponsabilidad" = ro."idResponsabilidad"
WHERE i.fecha < '2018-10-07' and i.fecha > '2018-09-15'
UNION
SELECT i."idIncidente" AS "idIncidente",
	   i.fecha,
	   i.calle_1 as calle_1,
	   i.calle_2 as calle_2,
		'Civil' as tipo,
        NULL as "placaOficial",
		c.dni as dni,
		c.nombre as nombre,
		c.apellido as apellido,
		rc.nombre as "rol"
FROM tp1."Incidente" i
JOIN tp1."SeInvolucraron" si ON i."idIncidente" = si."idIncidente"
JOIN tp1."Civil" c ON si.dni = c.dni
JOIN tp1."RolCivil" rc ON si."idRolCivil" = rc."idRolCivil"
WHERE i.fecha < '2018-10-07' and i.fecha > '2018-09-15'
ORDER BY 1 ASC, 5 ASC
